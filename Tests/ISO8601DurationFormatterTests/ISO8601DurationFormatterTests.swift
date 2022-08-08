import XCTest
@testable import ISO8601DurationFormatter

@available(iOS 13.0, *)
final class ISO8601DurationFormatterTests: XCTestCase {
    var formatter: ISO8601DurationFormatter!
    
    override func setUp() {
        formatter = ISO8601DurationFormatter()
    }

    override func tearDown() {
        formatter = nil
    }
    
    func test_getObjectValue() {
        let input = "5M"
        
        var object: AnyObject?
        var error: NSString?
        let didSucceed = formatter.getObjectValue(&object, for: input, errorDescription: &error)
        
        XCTAssertFalse(didSucceed)
        XCTAssertNil(object)
        XCTAssertEqual(DateComponents.ISO8601ConversionErrors.prefixMissing.description, error as? String)
    }
    
    func testDateComponentsToISO8601Duration() {
        let dateComponents = DateComponents(calendar: nil, timeZone: nil, era: nil, year: 6, month: 2, day: 2, hour: 4, minute: 44, second: 22, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: 2, yearForWeekOfYear: nil)
        let ISO8601DurationStr = dateComponents.toISO8601Duration()
        
        XCTAssertEqual(ISO8601DurationStr, "P6Y2M2W2DT4H44M22S")
    }
}
