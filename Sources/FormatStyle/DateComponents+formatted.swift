import Foundation

@available(macOS 12.0, *)
extension DateComponents {
    /// Creates a string representation of DateComponents using the provided format
    /// - Parameter format: The format style to apply.
    /// - Returns: A string, formatted according to the specified style.
    public func formatted<F: FormatStyle>(_ format: F) -> F.FormatOutput where F.FormatInput == DateComponents {
        return format.format(self)
    }
}
