import XCTest
@testable import ISO8601DurationFormatter

final class ISO8601DurationFormatterTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ISO8601DurationFormatter().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
