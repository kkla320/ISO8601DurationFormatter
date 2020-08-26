//
//  DateComponents+ISO8601Duration.swift
//  
//
//  Created by Ahmed Moussa on 3/31/20.
//

import Foundation

@available(iOS 7.0, *)
extension DateComponents {
    /**
    Convert  a [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations) string  object to [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents)
     
    ```
    let dateComponents = DateComponents(year: 6,
                                        month: 2,
                                        day: 2,
                                        hour: 4,
                                        minute: 44,
                                        second: 22,
                                        weekOfYear: 2)

    let ISO8601DurationString = dateComponents.toISO8601Duration()
    print(ISO8601DurationString) // P6Y2M2W2DT4H44M22S
    ```
     
    - returns: A [String](https://developer.apple.com/documentation/swift/string) object [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations) format using the current instance of [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents)
     */
    public func toISO8601Duration() -> String {
        var result = "P"
        result.append("\(self.year ?? 0)Y")
        result.append("\(self.month ?? 0)M")
        result.append("\(self.weekOfYear ?? 0)W")
        result.append("\(self.day ?? 0)D")
        result.append("T")
        result.append("\(self.hour ?? 0)H")
        result.append("\(self.minute ?? 0)M")
        result.append("\(self.second ?? 0)S")
        return result
    }
}
