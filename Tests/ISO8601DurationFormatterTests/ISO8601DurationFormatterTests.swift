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
    
    func testParseSecond() {
        let input = "PT5S"
        let dateComponents = formatter.dateComponents(from: input)

        XCTAssertEqual(5, dateComponents?.second)
    }
    
    func testParseMinute() {
        let input = "PT40M"
        let dateComponents = formatter.dateComponents(from: input)

        XCTAssertEqual(40, dateComponents?.minute)
    }
    
    func testParseHour() {
        let input = "PT1H"
        let dateComponents = formatter.dateComponents(from: input)

        XCTAssertEqual(1, dateComponents?.hour)
    }
    
    func testParseTime() {
        let input = "PT1H40M45S"
        let dateComponents = formatter.dateComponents(from: input)

        XCTAssertEqual(1, dateComponents?.hour)
        XCTAssertEqual(40, dateComponents?.minute)
        XCTAssertEqual(45, dateComponents?.second)
    }
    
    func testParseDay() {
        let input = "P20D"
        let dateComponents = formatter.dateComponents(from: input)

        XCTAssertEqual(20, dateComponents?.day)
    }
    
    func testParseWeek() {
        let input = "P1W"
        let dateComponents = formatter.dateComponents(from: input)

        XCTAssertEqual(1, dateComponents?.weekOfYear)
    }
    
    func testParseMonth() {
        let input = "P3M"
        let dateComponents = formatter.dateComponents(from: input)

        XCTAssertEqual(3, dateComponents?.month)
    }
    
    func testParseYear() {
        let input = "P6Y"
        let dateComponents = formatter.dateComponents(from: input)

        XCTAssertEqual(6, dateComponents?.year)
    }
    
    func testParseDate() {
        let input = "P6Y3M1W20D"
        let dateComponents = formatter.dateComponents(from: input)

        XCTAssertEqual(6, dateComponents?.year)
        XCTAssertEqual(3, dateComponents?.month)
        XCTAssertEqual(1, dateComponents?.weekOfYear)
        XCTAssertEqual(20, dateComponents?.day)
    }
    
    func testParseComplete() {
        let input = "P6Y3M1W20DT3H40M3S"
        let dateComponents = formatter.dateComponents(from: input)

        XCTAssertEqual(6, dateComponents?.year)
        XCTAssertEqual(3, dateComponents?.month)
        XCTAssertEqual(1, dateComponents?.weekOfYear)
        XCTAssertEqual(20, dateComponents?.day)
        XCTAssertEqual(3, dateComponents?.hour)
        XCTAssertEqual(40, dateComponents?.minute)
        XCTAssertEqual(3, dateComponents?.second)
    }

    func testParsingInvalidStringReturnsNil() {
        let input = "XXX"
        let dateComponents = formatter.dateComponents(from: input)

        XCTAssertNil(dateComponents)
    }
    
    func testDateComponentsToISO8601Duration() {
        let dateComponents = DateComponents(calendar: nil, timeZone: nil, era: nil, year: 6, month: 2, day: 2, hour: 4, minute: 44, second: 22, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: 2, yearForWeekOfYear: nil)
        let ISO8601DurationStr = dateComponents.toISO8601Duration()
        
        XCTAssertEqual(ISO8601DurationStr, "P6Y2M2W2DT4H44M22S")
    }

    static var allTests = [
        ("testDateComponentsToISO8601Duration", testDateComponentsToISO8601Duration),
        ("testParseComplete", testParseComplete),
        ("testParseDate", testParseDate),
        ("testParseYear", testParseYear),
        ("testParseMonth", testParseMonth),
        ("testParseWeek", testParseWeek),
        ("testParseDay", testParseDay),
        ("testParseTime", testParseTime),
        ("testParseSecond", testParseSecond),
        ("testParseMinute", testParseMinute),
        ("testParseHour", testParseHour),
    ]
}
