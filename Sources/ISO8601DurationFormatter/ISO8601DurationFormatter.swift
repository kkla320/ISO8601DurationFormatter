import Foundation

/// A formatter that converts between durations specified by [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations) values
@available(iOS 13.0, *)
public class ISO8601DurationFormatter: Formatter {
    /// Defines if zero or nil values should be excluded from the resulting string
    public var omitZeroOrNilValues: Bool = false
    
    /// Return a [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents) object created by parsing a given [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations) string
    ///
    /// ```swift
    /// let input = "PT40M30S"
    /// let dateComponents = try formatter.dateComponents(from: input)
    /// print(dateComponents.minute) // 40
    /// print(dateComponents.seconds) // 30
    /// ```
    /// - Parameter string: A [String](https://developer.apple.com/documentation/swift/string) object that is parsed to generate the returned [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents) object.
    /// - Returns: A [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents) object created by parsing `string`, or `nil` if string could not be parsed
    /// - Throws: DateComponents.ISO8601ConversionErrors if parsing does not work.
    public func dateComponents(from string: String) throws -> DateComponents {
        return try DateComponents(iso8601DurationString: string)
    }
    
    /// Convert a [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations) string  object to [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents)
    ///
    /// ```swift
    /// let dateComponents = DateComponents(
    ///     year: 6,
    ///     month: 2,
    ///     day: 2,
    ///     hour: 4,
    ///     minute: 44,
    ///     second: 22,
    ///     weekOfYear: 2
    /// )
    ///
    /// let string = formatter.string(from: dateComponents)
    /// print(string) // P6Y2M2W2DT4H44M22S
    /// ```
    /// - Parameter dateComponents: A [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents) object that is parsed to create a a [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations) string.
    /// - Returns: A [String](https://developer.apple.com/documentation/swift/string) object [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations) format using the current instance of [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents)
    public func string(from dateComponents: DateComponents) -> String {
        return dateComponents.toISO8601Duration(omitZeroOrNilValues: omitZeroOrNilValues)
    }
    
    /// Return a [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents) object created by parsing a given [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations) string. If the parameter obj is not a string, this method returns nil.
    ///
    /// ```swift
    /// let input = "PT40M30S"
    /// let dateComponents = formatter.string(for: input)
    /// print(dateComponents?.minute) // 40
    /// print(dateComponents?.seconds) // 30
    /// ```
    /// - Parameter string: A [String](https://developer.apple.com/documentation/swift/string) object that is parsed to generate the returned [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents) object.
    /// - Returns: A [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents) object created by parsing `string`, or `nil` if string could not be parsed
    /// - Throws: DateComponents.ISO8601ConversionErrors if parsing does not work.
    public override func string(for obj: Any?) -> String? {
        if let dateComponents = obj as? DateComponents {
            return dateComponents.toISO8601Duration(omitZeroOrNilValues: omitZeroOrNilValues)
        }
        return nil
    }
    
    /// Returns by reference a [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents) object after creating it from a string.
    /// - Parameters:
    ///   - obj: A reference that will contain a [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents) object if the function returns true
    ///   - string: A [String](https://developer.apple.com/documentation/swift/string) object that is parsed to generate the returned [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents) object.
    ///   - error: A reference that will contain a error description if the function returns false.
    /// - Returns: True if the function could successfully create a [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents) object. Otherwise false.
    public override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        do {
            let components = try DateComponents(iso8601DurationString: string)
            obj?.pointee = components as AnyObject
            return true
        } catch let catchedError {
            error?.pointee = String(describing: catchedError) as NSString
            return false
        }
    }
}
