import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ISO8601DurationFormatterTests.allTests),
    ]
}
#endif
