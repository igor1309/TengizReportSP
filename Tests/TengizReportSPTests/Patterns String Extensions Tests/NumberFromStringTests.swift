//
//  NumberFromStringTests.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 29.01.2021.
//

import XCTest
@testable import TengizReportSP

final class NumberFromStringTests: XCTestCase {
    func test_numberWithSign() {
        XCTAssertEqual("141.690+1.238.900=1.380.590".numberWithSign(), 141_690 + 1_238_900)
        XCTAssertEqual("Оборот факт:141.690+1.238.900=1.380.590".numberWithSign(), 141_690 + 1_238_900)

        XCTAssertEqual("7.701+4.500".numberWithSign(), 7_701 + 4_500)
        XCTAssertEqual("7.701 + 4.500".numberWithSign(), 7_701 + 4_500)
        XCTAssertEqual("4.500+8.700+15.995".numberWithSign(), 4_500 + 8_700 + 15_995)
        XCTAssertEqual("4.500  + 8.700 +  15.995".numberWithSign(), 4_500 + 8_700 + 15_995)

        XCTAssertEqual("Минус 123".numberWithSign(), -123)
        XCTAssertEqual("минус 123".numberWithSign(), -123)
        XCTAssertEqual("-123".numberWithSign(), -123)
        XCTAssertNotEqual("- 123".numberWithSign(), -123, "Whitespace after minus")

        XCTAssertEqual("Минус 1.002".numberWithSign(), -1_002)
        XCTAssertEqual("минус 1.001".numberWithSign(), -1_001)
        XCTAssertEqual("-1.004".numberWithSign(), -1_004)
        XCTAssertNotEqual("- 1.003".numberWithSign(), -1_003, "Whitespace after minus")

        XCTAssertEqual("Минус 123.456".numberWithSign(), -123_456)
        XCTAssertEqual("минус 123.456".numberWithSign(), -123_456)
        XCTAssertEqual("-123.456".numberWithSign(), -123_456)
        XCTAssertNotEqual("- 123.456".numberWithSign(), -123_456, "Whitespace after minus")

        XCTAssertEqual("Минус 123.456р 78к".numberWithSign(), -123_456.78)
        XCTAssertEqual("минус 123.456р 78к".numberWithSign(), -123_456.78)
        XCTAssertEqual("-123.456р 78к".numberWithSign(), -123_456.78)
        XCTAssertNotEqual("- 123.456р 78к".numberWithSign(), -123_456.78, "Whitespace after minus")
    }

    func test_percentageStringToDouble() {
        XCTAssertNil("Основные расходы:\t\t20%\t".percentageStringToDouble())
        XCTAssertNil("20% ".percentageStringToDouble())
        XCTAssertNil("20 %".percentageStringToDouble())
        XCTAssertNil(" 20%".percentageStringToDouble())

        XCTAssertEqual("2%".percentageStringToDouble(), 0.02)
        XCTAssertEqual("20%".percentageStringToDouble(), 0.2)
        XCTAssertEqual("200%".percentageStringToDouble(), 2)
    }

}
