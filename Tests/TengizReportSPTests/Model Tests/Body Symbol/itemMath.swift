//
//  itemMath.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 04.02.2021.
//

import XCTest
@testable import TengizReportSP

extension RegexPatternsTests {
    func test_math() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.math,
                       #"\d{1,3}(?:\.\d{3})*(?:\s*\+\s*\d{1,3}(?:\.\d{3})*)+"#)

        // MARK: exceptions
        XCTAssertNil("12. Интернет\t7.701".firstMatch(for: Patterns.math))
        XCTAssertNil("12. Интернет + internet".firstMatch(for: Patterns.math))

        // MARK: count in selectedBodyItems
        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: Patterns.math) }.count,
                       2, "Should be exactly 2 matches")

        // MARK: usage
        XCTAssertEqual("12. Интернет\t7.701+4.500".firstMatch(for: Patterns.math),
                       "7.701+4.500")
        XCTAssertEqual("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995"
                        .firstMatch(for: Patterns.math),
                       "4.500+8.700+15.995")
    }

    func test_itemMath() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.itemMath,
                       #"(?<title>^\d+\.\D+)(?:\t)(?<comment>(?<value>\d{1,3}(?:\.\d{3})*(?:\s*\+\s*\d{1,3}(?:\.\d{3})*)+))$"#)

        // MARK: exceptions
        XCTAssertNil("12. Интернет\t7.701+".firstMatch(for: Patterns.itemMath))
        XCTAssertNil("6. Обслуживание кассовой программы Айко\t4.500+ item".firstMatch(for: Patterns.itemMath))


        // MARK: count in selectedBodyItems
        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: Patterns.itemMath) }.count,
                       2, "Should be exactly 2 matches")

        // MARK: usage
        XCTAssertEqual("12. Интернет\t7.701+4.500".firstMatch(for: Patterns.itemMath),
                       "12. Интернет\t7.701+4.500")
        XCTAssertEqual("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995".firstMatch(for: Patterns.itemMath),
                       "6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995")

        // MARK: regex structure
        XCTAssertEqual("12. Интернет\t7.701+4.500"
                        .replaceFirstMatch(for: Patterns.itemMath, withGroup: "title"),
                       "12. Интернет")
        XCTAssertEqual("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995"
                        .replaceFirstMatch(for: Patterns.itemMath, withGroup: "title"),
                       "6. Обслуживание кассовой программы Айко")

        XCTAssertEqual("12. Интернет\t7.701+4.500"
                        .replaceFirstMatch(for: Patterns.itemMath, withGroup: "value"),
                       "7.701+4.500")
        XCTAssertEqual("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995"
                        .replaceFirstMatch(for: Patterns.itemMath, withGroup: "value"),
                       "4.500+8.700+15.995")

        XCTAssertEqual("12. Интернет\t7.701+4.500"
                        .replaceFirstMatch(for: Patterns.itemMath, withGroup: "comment"),
                       "7.701+4.500")
        XCTAssertEqual("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995"
                        .replaceFirstMatch(for: Patterns.itemMath, withGroup: "comment"),
                       "4.500+8.700+15.995")
    }
}

extension BodySymbolFuncTests {
    func test_itemMath() {
        XCTAssertEqual(selectedBodyItems.compactMap { $0.bodySymbol(for: Patterns.itemMath) }.count,
                       2, "Should be exactly 2 matches")

        XCTAssertEqual("12. Интернет\t7.701+4.500".bodySymbol(for: Patterns.itemMath),
                       .item(title: "12. Интернет", value: 12_201, comment: "7.701+4.500"))
        XCTAssertEqual("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995".bodySymbol(for: Patterns.itemMath),
                       .item(title: "6. Обслуживание кассовой программы Айко", value: 4_500+8_700+15_995, comment: "4.500+8.700+15.995"))
    }
}
