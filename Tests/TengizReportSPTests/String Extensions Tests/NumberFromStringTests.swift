//
//  NumberFromStringTests.swift
//  TengizReportSPM
//
//  Created by Igor Malyarov on 29.01.2021.
//

import XCTest
@testable import TengizReportSP

final class NumberFromStringTests: XCTestCase {
    func testNumberAndRemains() {
        var input = "1. Приход товара по накладным\t946.056р"
        var (number, remains) = input.numberAndRemains()
        XCTAssertEqual(number, 946056)
        XCTAssertEqual(remains, "1. Приход товара по накладным\t")

        input = "1. Приход 123 товара 456 по накладным\t946.056р"
        (number, remains) = input.numberAndRemains()
        XCTAssertEqual(number, 946056, "First match is rubliKopeiki")
        XCTAssertEqual(remains, "1. Приход 123 товара 456 по накладным\t")

        input = "1. Приход 123р товара 456 по накладным\t946.056р"
        (number, remains) = input.numberAndRemains()
        XCTAssertEqual(number, 123, "First match is rubliKopeiki")
        XCTAssertEqual(remains, "1. Приход  товара 456 по накладным\t946.056р")

        input = "1. Приход товара  по накладным\t946.056"
        (number, remains) = input.numberAndRemains()
        XCTAssertEqual(number, 1)
        XCTAssertEqual(remains, ". Приход товара  по накладным\t946.056")

        input = "Приход товара 12.950 по накладным\t946.056"
        (number, remains) = input.numberAndRemains()
        XCTAssertEqual(number, 12_950)
        XCTAssertEqual(remains, "Приход товара  по накладным\t946.056")
    }

    func testNumberWithSign() {
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

    func testRubliIKopeikiToDouble() {
        XCTAssertNotEqual("74к".rubliKopeikiToDouble(), 0.74, "Doesn't work without rubles")

        XCTAssertEqual("3р 74к".rubliKopeikiToDouble(), 3.74)

        XCTAssertEqual("63р 74к".rubliKopeikiToDouble(), 63.74)

        XCTAssertEqual("863р 74к".rubliKopeikiToDouble(), 863.74)

        XCTAssertEqual("5.863р 74к".rubliKopeikiToDouble(), 5863.74)

        XCTAssertEqual("13.318р 93к".rubliKopeikiToDouble(), 13318.93)
        XCTAssertEqual("21.346р 15к".rubliKopeikiToDouble(), 21346.15)
        XCTAssertEqual("75.255р 20к".rubliKopeikiToDouble(), 75255.2)
        XCTAssertEqual("98.340р 24к".rubliKopeikiToDouble(), 98340.24)

        XCTAssertEqual("145.292р 59к".rubliKopeikiToDouble(), 145292.59)
        XCTAssertEqual("739.626р 06к".rubliKopeikiToDouble(), 739626.06)
        XCTAssertEqual("922.936р 30к".rubliKopeikiToDouble(), 922936.3)

        XCTAssertEqual("1.065.596р 76к".rubliKopeikiToDouble(), 1065596.76)
        XCTAssertEqual("1.677.077р 46к".rubliKopeikiToDouble(), 1677077.46)
        XCTAssertEqual("2.030.572р 59к".rubliKopeikiToDouble(), 2030572.59)
        XCTAssertEqual("2.094.271р 36к".rubliKopeikiToDouble(), 2094271.36)
        XCTAssertEqual("2.343.392р 37к".rubliKopeikiToDouble(), 2343392.37)
        XCTAssertEqual("2.865.042р 74к".rubliKopeikiToDouble(), 2865042.74)

        XCTAssertEqual("7.841р".rubliKopeikiToDouble(), 7841.0)
        XCTAssertEqual("90.841р".rubliKopeikiToDouble(), 90841.0)
        XCTAssertEqual("907.841р".rubliKopeikiToDouble(), 907841.0)
        XCTAssertEqual("946.056р".rubliKopeikiToDouble(), 946056.0)
    }

    func testPercentageStringToDouble() {
        XCTAssertNil("Основные расходы:\t\t20%\t".percentageStringToDouble())
        XCTAssertNil("20 %".percentageStringToDouble())
        XCTAssertNil(" 20%".percentageStringToDouble())

        XCTAssertEqual("2%".percentageStringToDouble(), 0.02)
        XCTAssertEqual("20%".percentageStringToDouble(), 0.2)
        XCTAssertEqual("200%".percentageStringToDouble(), 2)
    }

}
