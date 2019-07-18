import XCTest
@testable import ISO8601DurationFormatter

@available(iOS 13.0, *)
final class ISO8601DurationFormatterTests: XCTestCase {
    var formatter: ISO8601DurationFormatter!
    
    override func setUp() {
        formatter = ISO8601DurationFormatter()
    }
    
    func testParseMinute() {
        let input = "PT40M"
        let dateComponents = formatter.dateComponents(from: input)
        
        XCTAssertNotNil(dateComponents)
        XCTAssertNotNil(dateComponents!.minute)
        XCTAssertEqual(40, dateComponents!.minute!)
    }
    
    func testParseHour() {
            let input = "PT1H"
            let dateComponents = formatter.dateComponents(from: input)
            
            XCTAssertNotNil(dateComponents)
            XCTAssertNotNil(dateComponents!.hour)
            XCTAssertEqual(1, dateComponents!.hour!)
        }

    static var allTests = [
        ("testParseMinute", testParseMinute),
        ("testParseHour", testParseHour),
    ]
}
