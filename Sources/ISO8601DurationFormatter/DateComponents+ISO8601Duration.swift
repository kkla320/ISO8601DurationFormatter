//
//  DateComponents+ISO8601Duration.swift
//  
//
//  Created by Ahmed Moussa on 3/31/20.
//

import Foundation

@available(iOS 7.0, *)
extension DateComponents {
    /// Convert  a [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations) string  object to [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents)
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
    /// let ISO8601DurationString = dateComponents.toISO8601Duration()
    /// print(ISO8601DurationString) // P6Y2M2W2DT4H44M22S
    /// ```
    /// - Parameter omitZeroValues: Defines if zero or nil values should be excluded from the resulting string
    /// - Returns: A [String](https://developer.apple.com/documentation/swift/string) object [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations) format using the current instance of [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents)
    public func toISO8601Duration(omitZeroOrNilValues: Bool = false) -> String {
        if allComponentsZeroOrNil && omitZeroOrNilValues {
            return "PT0S"
        }
        var result = "P"
        result.append(year ?? 0, suffix: "Y", omitZeroValues: omitZeroOrNilValues)
        result.append(month ?? 0, suffix: "M", omitZeroValues: omitZeroOrNilValues)
        result.append(weekOfYear ?? 0, suffix: "W", omitZeroValues: omitZeroOrNilValues)
        result.append(day ?? 0, suffix: "D", omitZeroValues: omitZeroOrNilValues)
        if !allTimeComponentsZeroOrNil || !omitZeroOrNilValues {
            result.append("T")
            result.append(hour ?? 0, suffix: "H", omitZeroValues: omitZeroOrNilValues)
            result.append(minute ?? 0, suffix: "M", omitZeroValues: omitZeroOrNilValues)
            result.append(second ?? 0, suffix: "S", omitZeroValues: omitZeroOrNilValues)
        }
        return result
    }

    private var allComponentsZeroOrNil: Bool {
        let components = [year, month, weekOfYear, day, hour, minute, second]
        return components.allSatisfy { ($0 ?? 0) == 0 }
    }
    
    private var allTimeComponentsZeroOrNil: Bool {
        let components = [hour, minute, second]
        return components.allSatisfy { ($0 ?? 0) == 0 }
    }
}
