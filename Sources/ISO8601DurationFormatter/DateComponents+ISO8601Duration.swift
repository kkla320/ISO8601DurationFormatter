//
//  DateComponents+ISO8601Duration.swift
//  
//
//  Created by Ahmed Moussa on 3/31/20.
//

import Foundation

@available(iOS 7.0, *)
extension DateComponents {
    func toISO8601Duration() -> String {
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
