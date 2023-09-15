import Foundation

@available(macOS 12.0, *)
/// A type that creates a ISO8601 duration representation of DateComponents
public struct ISO8601DurationFormatStyle: ParseableFormatStyle {
    /// A stategy to convert ISO8601 duration strings to DateComponents
    public struct Strategy: Foundation.ParseStrategy {
        public typealias ParseInput = String
        public typealias ParseOutput = DateComponents
        
        public func parse(_ value: String) throws -> DateComponents {
            return try DateComponents(iso8601DurationString: value)
        }
    }
    
    /// The strategy used to parse ISO8601 duration strings to DateComponents
    public let parseStrategy: Strategy
    
    /// Defines if zero or nil values should be excluded from the resulting string
    public let omitZeroOrNilValues: Bool
    
    init(omitZeroOrNilValues: Bool = false) {
        self.omitZeroOrNilValues = omitZeroOrNilValues
        self.parseStrategy = Strategy()
    }
    
    /// Creates a ISO8601 duration string from DateComponents
    /// - Parameter value: The DateComponents to format
    /// - Returns: The ISO8601 duration string
    public func format(_ value: DateComponents) -> String {
        return value.toISO8601Duration(omitZeroOrNilValues: omitZeroOrNilValues)
    }
}

@available(macOS 12.0, *)
extension ISO8601DurationFormatStyle {
    /// Creates a new ISO8601DurationFormatStyle where the omitZeroOrNilValues parameters is overridden
    /// - Parameter omitZeroOrNilValues: Defines if zero or nil values should be excluded from the resulting string
    /// - Returns: The new ISO8601DurationFormatStyle
    public func omitZeroOrNilValues(_ omitZeroOrNilValues: Bool) -> ISO8601DurationFormatStyle {
        return ISO8601DurationFormatStyle(omitZeroOrNilValues: omitZeroOrNilValues)
    }
}

@available(macOS 12.0, *)
extension FormatStyle where Self == ISO8601DurationFormatStyle {
    /// A formatter that creates a ISO8601 duration representation of DateComponents
    public static var iso8601Duration: Self {
        return ISO8601DurationFormatStyle()
    }
}
