import Foundation

@available(iOS 13.0, *)
public class ISO8601DurationFormatter: Formatter {
    private let dateUnitMapping: [Character: Calendar.Component] = ["Y": .year, "M": .month, "W": .weekOfYear, "D": .day]
    private let timeUnitMapping: [Character: Calendar.Component] = ["H": .hour, "M": .minute, "S": .second]
    
    public func dateComponents(from string: String) -> DateComponents? {
        var dateComponents: AnyObject? = nil
        if getObjectValue(&dateComponents, for: string, errorDescription: nil) {
            return dateComponents as? DateComponents
        }
        
        return nil
    }
    
    public override func string(for obj: Any?) -> String? {
        return nil
    }
    
    public override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        guard let unitValues = durationUnitValues(for: string) else {
              return false
           }

           var components = DateComponents()
           for (unit, value) in unitValues {
              components.setValue(value, for: unit)
           }
        obj?.pointee = components as AnyObject
        return true
    }
    
    private func durationUnitValues(for string: String) -> [(Calendar.Component, Int)]? {
      guard string.hasPrefix("P") else {
         return nil
      }

      let duration = String(string.dropFirst())

      guard let separatorRange = duration.range(of: "T") else {
        return unitValuesWithMapping(for: duration, dateUnitMapping)
      }

      let date = String(duration[..<separatorRange.lowerBound])
      let time = String(duration[separatorRange.upperBound...])

        guard let dateUnits = unitValuesWithMapping(for: date, dateUnitMapping),
            let timeUnits = unitValuesWithMapping(for: time, timeUnitMapping) else {
            return nil
      }

      return dateUnits + timeUnits
   }
    
    func unitValuesWithMapping(for string: String, _ mapping: [Character: Calendar.Component]) -> [(Calendar.Component, Int)]? {
          if string.isEmpty {
             return []
          }

          var components: [(Calendar.Component, Int)] = []

          let identifiersSet = CharacterSet(charactersIn: String(mapping.keys))

          let scanner = Scanner(string: string)
          while !scanner.isAtEnd {
            var value: Int = 0
            guard scanner.scanInt(&value) else {
                return nil
            }
            
            var identifier: NSString?
            guard scanner.scanCharacters(from: identifiersSet, into: &identifier) else {
                return nil
            }
            
            guard identifier != nil else {
                return nil
            }
            
            let unit = mapping[Character(identifier! as String)]!
            components.append((unit, value))
          }
          return components
       }
}
