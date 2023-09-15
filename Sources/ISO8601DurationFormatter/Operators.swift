import Foundation

extension Optional where Wrapped == Int {
    static func +(_ lhs: Self, _ rhs: Self) -> Self {
        if lhs == nil && rhs == nil {
            return nil
        }
        return (lhs ?? 0) + (rhs ?? 0)
    }
    
    static func *(_ lhs: Self, _ rhs: Int) -> Self {
        guard let lhs = lhs else {
            return nil
        }
        return lhs * rhs
    }
}

extension DateComponents {
    static func +(_ lhs: DateComponents, _ rhs: DateComponents) -> DateComponents {
        var result = DateComponents()
        result.second = lhs.second + rhs.second
        result.minute = lhs.minute + rhs.minute
        result.hour = lhs.hour + rhs.hour
        result.day = lhs.day + rhs.day
        result.weekOfYear = lhs.weekOfYear + rhs.weekOfYear
        result.month = lhs.month + rhs.month
        result.year = lhs.year + rhs.year
        return result
    }
    
    static func *(_ lhs: DateComponents, _ rhs: Int) -> DateComponents {
        var result = DateComponents()
        result.second = lhs.second * rhs
        result.minute = lhs.minute * rhs
        result.hour = lhs.hour * rhs
        result.day = lhs.day * rhs
        result.weekOfYear = lhs.weekOfYear * rhs
        result.month = lhs.month * rhs
        result.year = lhs.year * rhs
        return result
    }
}
