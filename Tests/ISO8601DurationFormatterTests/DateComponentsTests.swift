import XCTest

@testable import ISO8601DurationFormatter

final class DateComponentsTests: XCTestCase {
    // MARK: toISO8601Duration
    func test_toISO8601Duration() {
        let dateComponents = DateComponents(
            year: 6,
            month: 2,
            day: 2,
            hour: 4,
            minute: 44,
            second: 22,
            weekOfYear: 2
        )
        let ISO8601DurationStr = dateComponents.toISO8601Duration()
        
        XCTAssertEqual(ISO8601DurationStr, "P6Y2M2W2DT4H44M22S")
    }
    
    func test_toISO8601Duration_shouldAppendAllZeroComponents_ifAllComponentsAreZero() {
        let dateComponents = DateComponents(
            year: 0,
            month: 0,
            day: 0,
            hour: 0,
            minute: 0,
            second: 0,
            weekOfYear: 0
        )
        let ISO8601DurationStr = dateComponents.toISO8601Duration()
        
        XCTAssertEqual(ISO8601DurationStr, "P0Y0M0W0DT0H0M0S")
    }
    
    func test_toISO8601Duration_shouldAppendAllZeroComponents_ifAllComponentsAreNil() {
        let dateComponents = DateComponents(
            year: nil,
            month: nil,
            day: nil,
            hour: nil,
            minute: nil,
            second: nil,
            weekOfYear: nil
        )
        let ISO8601DurationStr = dateComponents.toISO8601Duration()
        
        XCTAssertEqual(ISO8601DurationStr, "P0Y0M0W0DT0H0M0S")
    }
    
    func test_toISO8601Duration_dropReturnEmptyDurationString_ifEmitZeroValuesIsTrueAndAllComponentsAreZero() {
        let dateComponents = DateComponents(
            year: 0,
            month: 0,
            day: 0,
            hour: 0,
            minute: 0,
            second: 0,
            weekOfYear: 0
        )
        let ISO8601DurationStr = dateComponents.toISO8601Duration(emitZeroOrNilValues: true)
        
        XCTAssertEqual(ISO8601DurationStr, "PT0S")
    }
    
    func test_toISO8601Duration_dropReturnEmptyDurationString_ifEmitZeroValuesIsTrueAndAllComponentsAreNil() {
        let dateComponents = DateComponents(
            year: nil,
            month: nil,
            day: nil,
            hour: nil,
            minute: nil,
            second: nil,
            weekOfYear: nil
        )
        let ISO8601DurationStr = dateComponents.toISO8601Duration(emitZeroOrNilValues: true)
        
        XCTAssertEqual(ISO8601DurationStr, "PT0S")
    }
    
    func test_toISO8601Duration_shouldDropZeroComponents_ifEmitZeroValuesIsTrue() {
        let dateComponents = DateComponents(
            year: 0,
            month: 1,
            day: 1,
            hour: 1,
            minute: 1,
            second: 1,
            weekOfYear: 1
        )
        let ISO8601DurationStr = dateComponents.toISO8601Duration(emitZeroOrNilValues: true)
        
        XCTAssertEqual(ISO8601DurationStr, "P1M1W1DT1H1M1S")
    }
    
    func test_toISO8601Duration_shouldDropZeroComponents_ifEmitZeroValuesIsTrueAndAComponentIsNil() {
        let dateComponents = DateComponents(
            year: nil,
            month: 1,
            day: 1,
            hour: 1,
            minute: 1,
            second: 1,
            weekOfYear: 1
        )
        let ISO8601DurationStr = dateComponents.toISO8601Duration(emitZeroOrNilValues: true)
        
        XCTAssertEqual(ISO8601DurationStr, "P1M1W1DT1H1M1S")
    }
    
    func test_toISO8601Duration_shouldDropTimeComponents_ifEmitZeroValuesIsTrueAndAllTimeComponentsAreZero() {
        let dateComponents = DateComponents(
            year: 1,
            month: 1,
            day: 1,
            hour: 0,
            minute: 0,
            second: 0,
            weekOfYear: 1
        )
        let ISO8601DurationStr = dateComponents.toISO8601Duration(emitZeroOrNilValues: true)
        
        XCTAssertEqual(ISO8601DurationStr, "P1Y1M1W1D")
    }
    
    func test_toISO8601Duration_shouldDropTimeComponents_ifEmitZeroValuesIsTrueAndAllTimeComponentsAreNil() {
        let dateComponents = DateComponents(
            year: 1,
            month: 1,
            day: 1,
            hour: nil,
            minute: nil,
            second: nil,
            weekOfYear: 1
        )
        let ISO8601DurationStr = dateComponents.toISO8601Duration(emitZeroOrNilValues: true)
        
        XCTAssertEqual(ISO8601DurationStr, "P1Y1M1W1D")
    }
    
    // MARK: init
    func test_init_parseSecond() throws {
        let input = "PT5S"
        let dateComponents = try DateComponents(iso8601DurationString: input)

        XCTAssertEqual(5, dateComponents.second)
    }
    
    func test_init_parseMinute() throws {
        let input = "PT40M"
        let dateComponents = try DateComponents(iso8601DurationString: input)

        XCTAssertEqual(40, dateComponents.minute)
    }
    
    func test_init_parseHour() throws {
        let input = "PT1H"
        let dateComponents = try DateComponents(iso8601DurationString: input)

        XCTAssertEqual(1, dateComponents.hour)
    }
    
    func test_init_parseTime() throws {
        let input = "PT1H40M45S"
        let dateComponents = try DateComponents(iso8601DurationString: input)

        XCTAssertEqual(1, dateComponents.hour)
        XCTAssertEqual(40, dateComponents.minute)
        XCTAssertEqual(45, dateComponents.second)
    }
    
    func test_init_parseDay() throws {
        let input = "P20D"
        let dateComponents = try DateComponents(iso8601DurationString: input)

        XCTAssertEqual(20, dateComponents.day)
    }
    
    func test_init_parseWeek() throws {
        let input = "P1W"
        let dateComponents = try DateComponents(iso8601DurationString: input)

        XCTAssertEqual(1, dateComponents.weekOfYear)
    }
    
    func test_init_parseMonth() throws {
        let input = "P3M"
        let dateComponents = try DateComponents(iso8601DurationString: input)

        XCTAssertEqual(3, dateComponents.month)
    }
    
    func test_init_parseYear() throws {
        let input = "P6Y"
        let dateComponents = try DateComponents(iso8601DurationString: input)

        XCTAssertEqual(6, dateComponents.year)
    }
    
    func test_init_parseDate() throws {
        let input = "P6Y3M1W20D"
        let dateComponents = try DateComponents(iso8601DurationString: input)

        XCTAssertEqual(6, dateComponents.year)
        XCTAssertEqual(3, dateComponents.month)
        XCTAssertEqual(1, dateComponents.weekOfYear)
        XCTAssertEqual(20, dateComponents.day)
    }
    
    func test_init_parseComplete() throws {
        let input = "P6Y3M1W20DT3H40M3S"
        let dateComponents = try DateComponents(iso8601DurationString: input)

        XCTAssertEqual(6, dateComponents.year)
        XCTAssertEqual(3, dateComponents.month)
        XCTAssertEqual(1, dateComponents.weekOfYear)
        XCTAssertEqual(20, dateComponents.day)
        XCTAssertEqual(3, dateComponents.hour)
        XCTAssertEqual(40, dateComponents.minute)
        XCTAssertEqual(3, dateComponents.second)
    }

    func test_init_parseNegative() throws {
        let input = "-P6Y3M1W20DT3H40M3S"
        let dateComponents = try DateComponents(iso8601DurationString: input)

        XCTAssertEqual(-6, dateComponents.year)
        XCTAssertEqual(-3, dateComponents.month)
        XCTAssertEqual(-1, dateComponents.weekOfYear)
        XCTAssertEqual(-20, dateComponents.day)
        XCTAssertEqual(-3, dateComponents.hour)
        XCTAssertEqual(-40, dateComponents.minute)
        XCTAssertEqual(-3, dateComponents.second)
    }

    func test_init_parseFractionFail() {
        let input = "P1.5M22S"
        do {
            _ = try DateComponents(iso8601DurationString: input)
            XCTFail("Method did not fail")
        } catch let error as DateComponents.ISO8601ConversionErrors where error == .fractionalValuesNotSupported {
            // Test succeeds
        } catch {
            XCTFail("The thrown error does not match the expected error")
        }
    }

    func test_init_parsingMissingPrefix() {
        let input = "6Y3M1W20DT3H40M3S"
        do {
            _ = try DateComponents(iso8601DurationString: input)
            XCTFail("Method did not fail")
        } catch let error as DateComponents.ISO8601ConversionErrors where error == .prefixMissing {
            // Test succeeds
        } catch {
            XCTFail("The thrown error does not match the expected error")
        }
    }
    
    func test_init_parsingInvalidString() {
        let input = "PSomethingElse"
        do {
            _ = try DateComponents(iso8601DurationString: input)
            XCTFail("Method did not fail")
        } catch DateComponents.ISO8601ConversionErrors.invalidCharacter(_, let index) {
            print("\(input.distance(from: input.startIndex, to: index))")
            XCTAssertEqual("S", input[index])
        } catch {
            XCTFail("The thrown error does not match the expected error")
        }
    }
    
    func test_init_parsingInvalidStringAtEnd() {
        let input = "P5MG"
        do {
            _ = try DateComponents(iso8601DurationString: input)
            XCTFail("Method did not fail")
        } catch DateComponents.ISO8601ConversionErrors.invalidCharacter(_, let index) {
            XCTAssertEqual("G", input[index])
        } catch {
            XCTFail("The thrown error does not match the expected error")
        }
    }
}
