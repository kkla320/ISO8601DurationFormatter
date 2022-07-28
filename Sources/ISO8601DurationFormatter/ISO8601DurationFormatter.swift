import Foundation

/// A formatter that converts between durations specified by [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations) values
@available(iOS 13.0, *)
public class ISO8601DurationFormatter: Formatter {
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
    
    /// Return a [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents) object created by parsing a given [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations) string. If the parameter obj is not a string, this method returns nil.
    ///
    /// ```swift
    /// let input = "PT40M30S"
    /// let dateComponents = formatter.string(for: input)
    /// print(dateComponents.minute) // 40
    /// print(dateComponents.seconds) // 30
    /// ```
    /// - Parameter string: A [String](https://developer.apple.com/documentation/swift/string) object that is parsed to generate the returned [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents) object.
    /// - Returns: A [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents) object created by parsing `string`, or `nil` if string could not be parsed
    /// - Throws: DateComponents.ISO8601ConversionErrors if parsing does not work.
    public override func string(for obj: Any?) -> String? {
        if let dateComponents = obj as? DateComponents {
            return dateComponents.toISO8601Duration()
        }
        return nil
    }
    
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
