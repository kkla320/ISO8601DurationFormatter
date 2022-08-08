import Foundation

extension Dictionary where Key == Character, Value == Calendar.Component {
    static var dateUnitMapping: Self = ["Y": .year, "M": .month, "W": .weekOfYear, "D": .day]
    static var timeUnitMapping: Self = ["H": .hour, "M": .minute, "S": .second]
}
