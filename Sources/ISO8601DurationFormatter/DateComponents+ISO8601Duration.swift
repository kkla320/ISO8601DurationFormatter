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
        if allComponentsZero {
            return "PT0S"
        }
        var result = "P"
        result.appendIfNonZero(year, suffix: "Y")
        result.appendIfNonZero(month, suffix: "M")
        result.appendIfNonZero(weekOfYear, suffix: "W")
        result.appendIfNonZero(day, suffix: "D")
        if hour?.magnitude != 0 || minute?.magnitude != 0 || second?.magnitude != 0 {
            result.append("T")
            result.appendIfNonZero(hour, suffix: "H")
            result.appendIfNonZero(minute, suffix: "M")
            result.appendIfNonZero(second, suffix: "S")
        }
        return result
    }

    private var allComponentsZero: Bool {
        let components = [year, month, weekOfYear, day, hour, minute, second]
        return components.allSatisfy { $0?.magnitude ?? 0 == 0 }
    }

}

private extension String {

    mutating func appendIfNonZero(_ dateComponentValue: Int?, suffix letter: String) {
        guard
            let dateComponentValue = dateComponentValue,
            dateComponentValue.magnitude > 0 else {
            return
        }
        self.append("\(dateComponentValue)\(letter)")
    }

}
