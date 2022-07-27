import Foundation

/**
 A formatter that converts between durations specified by [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations) values
 */
@available(iOS 13.0, *)
public class ISO8601DurationFormatter: Formatter {

    public enum Error: Swift.Error, LocalizedError {
        case fractionalValuesNotSupported
        case description(message: String)

        public var errorDescription: String? {
            switch self {
            case .fractionalValuesNotSupported:
                return String(describing: self)
            case .description(let message):
                return message
            }
        }
    }

    private let dateUnitMapping: [Character: Calendar.Component] = ["Y": .year, "M": .month, "W": .weekOfYear, "D": .day]
    private let timeUnitMapping: [Character: Calendar.Component] = ["H": .hour, "M": .minute, "S": .second]
    
    /**
    Return a [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents) object created by parsing a given [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations) string

    ```
    let input = "PT40M30S"
    let dateComponents = formatter.dateComponents(from: input)
    if let dateComponents = dateComponents {
        print(dateComponents.minute) // 40
        print(dateComponents.seconds) // 30
    }
    ```

    - parameter string: A [String](https://developer.apple.com/documentation/swift/string) object that is parsed to generate the returned [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents) object.
    - returns: A  [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents) object created by parsing `string`, or `nil` if string could not be parsed
     */
    public func dateComponents(from string: String) throws -> DateComponents? {
        var dateComponents: AnyObject?
        var errorDescription: NSString?
        if getObjectValue(&dateComponents, for: string, errorDescription: &errorDescription) {
            return dateComponents as? DateComponents
        }
        if let errorDescription = errorDescription as? String {
            if errorDescription == Error.fractionalValuesNotSupported.localizedDescription {
                throw Error.fractionalValuesNotSupported
            }
            throw Error.description(message: errorDescription)
        }
        
        return nil
    }
    
    public override func string(for obj: Any?) -> String? {
        if let dateComponents = obj as? DateComponents {
            return dateComponents.toISO8601Duration()
        }
        return nil
    }
    
    public override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        do {
            guard let unitValues = try durationUnitValues(for: string) else {
                return false
            }

            var components = DateComponents()
            for (unit, value) in unitValues {
                components.setValue(value, for: unit)
            }
            obj?.pointee = components as AnyObject
            return true
        } catch(let caughtError) {
            error?.pointee = String(describing: caughtError) as NSString
            return false
        }
    }
    
    private func durationUnitValues(for string: String) throws -> [(Calendar.Component, Int)]? {
        var duration = string.uppercased()
        guard duration.hasPrefix("P") || duration.hasPrefix("-P") else {
            return nil
        }

        let isNegative = duration.hasPrefix("-")
        if isNegative {
            duration = String(duration.dropFirst())
        }

        // Drop initial `P`
        duration = String(duration.dropFirst())

        guard let separatorRange = duration.range(of: "T") else {
            return try unitValuesWithMapping(for: duration, mapping: dateUnitMapping, isNegative: isNegative)
        }

        let date = String(duration[..<separatorRange.lowerBound])
        let time = String(duration[separatorRange.upperBound...])

        guard let dateUnits = try unitValuesWithMapping(for: date, mapping: dateUnitMapping, isNegative: isNegative),
              let timeUnits = try unitValuesWithMapping(for: time, mapping: timeUnitMapping, isNegative: isNegative) else {
            return nil
        }

        return dateUnits + timeUnits
    }
    
    func unitValuesWithMapping(for string: String, mapping: [Character: Calendar.Component], isNegative: Bool) throws -> [(Calendar.Component, Int)]? {
        if string.isEmpty {
            return []
        }

        var components: [(Calendar.Component, Int)] = []

        let identifiersSet = CharacterSet(charactersIn: String(mapping.keys))

        let scanner = Scanner(string: string)
        while !scanner.isAtEnd {
            var doubleVal: Double = 0
            guard scanner.scanDouble(&doubleVal) else {
                return nil
            }

            // Throw an error for fractional representations as these are not suppored by `DateComponents`
            let isInteger = floor(doubleVal) == doubleVal
            guard isInteger else {
                throw Error.fractionalValuesNotSupported
            }

            var value = Int(floor(doubleVal))
            
            if isNegative {
                value = -value
            }

            var scannedIdentifier: NSString?
            guard scanner.scanCharacters(from: identifiersSet, into: &scannedIdentifier) else {
                return nil
            }

            guard let identifier = scannedIdentifier as String? else {
                return nil
            }

            let unit = mapping[Character(identifier)]!
            components.append((unit, value))
        }
        return components
    }
}
