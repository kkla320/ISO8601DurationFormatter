import Foundation

/**
 A formatter that converts between durations specified by [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations) values
 */
@available(iOS 13.0, *)
public class ISO8601DurationFormatter: Formatter {
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
    public func dateComponents(from string: String) -> DateComponents? {
        var dateComponents: AnyObject? = nil
        if getObjectValue(&dateComponents, for: string, errorDescription: nil) {
            return dateComponents as? DateComponents
        }
        
        return nil
    }
    
    public override func string(for obj: Any?) -> String? {
        return nil
    }
    
    public override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        guard let unitValues = durationUnitValues(for: string) else {
            return false
        }

        var components = DateComponents()
        for (unit, value) in unitValues {
            components.setValue(value, for: unit)
        }
        obj?.pointee = components as AnyObject
        return true
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
            var value: Int = 0
            guard scanner.scanInt(&value) else {
                return nil
            }

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
