import Foundation

@available(macOS 10.15, *)
extension DateComponents {
    /// The possible errors thrown while parsing a
    public enum ISO8601ConversionErrors: Error, CustomStringConvertible, Equatable {
        /// The ISO8601 input string contains a decimal number
        case fractionalValuesNotSupported
        /// The prefix is missing from the input string
        case prefixMissing
        /// While parsing, a invalid character appeared
        case invalidCharacter(String, String.Index)
        
        public var description: String {
            switch self {
                case .fractionalValuesNotSupported:
                    return "The provided string contains a decimal number, which cannot be parsed"
                case .prefixMissing:
                    return "The provided string does not include the P or -P prefix"
                case .invalidCharacter(let input, let index):
                    return "The provided string contains an invalid character at \(input.distance(from: input.startIndex, to: index))"
            }
        }
    }
    
    /// Created a [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents) object by parsing a given [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations) string
    ///
    /// ```swift
    /// let input = "PT40M30S"
    /// let dateComponents = try DateComponents(iso8601DurationString: input)
    /// print(dateComponents.minute) // 40
    /// print(dateComponents.seconds) // 30
    /// ```
    /// - Parameter iso8601DurationString: A [String](https://developer.apple.com/documentation/swift/string) object that is parsed to generate the returned [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents) object.
    /// - Throws: DateComponents.ISO8601ConversionErrors if parsing does not work.
    public init(iso8601DurationString: String) throws {
        var duration = iso8601DurationString.uppercased()
        let hasPrefixForNegtivDuration = duration.hasPrefix("-P")
        guard duration.hasPrefix("P") || hasPrefixForNegtivDuration else {
            throw ISO8601ConversionErrors.prefixMissing
        }

        duration = String(duration.dropFirst(hasPrefixForNegtivDuration ? 2 : 1))

        guard let separatorRange = duration.range(of: "T") else {
            self = try Self.dateComponentsWithMapping(
                for: duration,
                mapping: .dateUnitMapping
            ) * (hasPrefixForNegtivDuration ? -1 : 1)
            return
        }

        let date = String(duration[..<separatorRange.lowerBound])
        let time = String(duration[separatorRange.upperBound...])

        let dateUnits = try Self.dateComponentsWithMapping(for: date, mapping: .dateUnitMapping)
        let timeUnits = try Self.dateComponentsWithMapping(for: time, mapping: .timeUnitMapping)
        
        self = (dateUnits + timeUnits) * (hasPrefixForNegtivDuration ? -1 : 1)
    }
    
    private static func dateComponentsWithMapping(for string: String, mapping: [Character: Calendar.Component]) throws -> DateComponents {
        if string.isEmpty {
            return DateComponents()
        }

        var components: DateComponents = DateComponents()

        let identifiersSet = CharacterSet(charactersIn: String(mapping.keys))

        let scanner = Scanner(string: string)
        while !scanner.isAtEnd {
            guard let doubleValue = scanner.scanDouble() else {
                let nextIndex = string.index(after: scanner.currentIndex)
                throw ISO8601ConversionErrors.invalidCharacter(scanner.string, nextIndex)
            }
            
            let (wholePart, fractionPart) = modf(doubleValue)
            
            // Throw an error for fractional representations as these are not suppored by `DateComponents`
            guard fractionPart == 0 else {
                throw ISO8601ConversionErrors.fractionalValuesNotSupported
            }
            
            guard let scannedIdentifier = scanner.scanCharacters(from: identifiersSet) else {
                let nextIndex = string.index(after: scanner.currentIndex)
                throw ISO8601ConversionErrors.invalidCharacter(scanner.string, nextIndex)
            }

            let value = Int(wholePart)
            let unit = mapping[Character(scannedIdentifier)]!
            components.setValue(value, for: unit)
        }
        return components
    }
}
