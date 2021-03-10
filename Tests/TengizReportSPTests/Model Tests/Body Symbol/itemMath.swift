//
//  itemMath.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 04.02.2021.
//

import XCTest
@testable import TengizReportModel

extension RegexPatternsTests {
    func test_itemMath() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.itemMath,
       #"^(?<itemNo>\d\d?)\.\s*(?<title>.+?)(?:\t\s*)(?:\t\t)?(?<note>(?<value>\d{1,3}(?:\.\d{3})*(?:\D*\s*\+\s*\d{1,3}(?:\.\d{3})*)+)\D*)$"#)

        // MARK: no match
        XCTAssertNil("12. Интернет\t7.701+".firstMatch(for: Patterns.itemMath))
        XCTAssertNil("6. Обслуживание кассовой программы Айко\t4.500+ item".firstMatch(for: Patterns.itemMath))

        XCTAssertNil("Оборот факт:141.690+1.238.900=1.380.590".firstMatch(for: Patterns.itemMath))

        // MARK: count in selectedBodyItems
        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: Patterns.itemMath) }.count,
                       3, "Should be exactly 3 matches")

        // MARK: match
        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)"
                        .firstMatch(for: Patterns.itemMath),
                       "1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)")
        XCTAssertEqual("12. Интернет\t7.701+4.500".firstMatch(for: Patterns.itemMath),
                       "12. Интернет\t7.701+4.500")
        XCTAssertEqual("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995".firstMatch(for: Patterns.itemMath),
                       "6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995")

        // MARK: regex structure
        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)"
                        .replaceFirstMatch(for: Patterns.itemMath, withGroup: "itemNo"),
                       "1")
        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)"
                        .replaceFirstMatch(for: Patterns.itemMath, withGroup: "title"),
                       "Аренда торгового помещения")
        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)"
                        .replaceFirstMatch(for: Patterns.itemMath, withGroup: "value"),
                       "200.000 (за август) +400.000")
        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)"
                        .replaceFirstMatch(for: Patterns.itemMath, withGroup: "note"),
                       "200.000 (за август) +400.000 (за сентябрь)")

        XCTAssertEqual("12. Интернет\t7.701+4.500"
                        .replaceFirstMatch(for: Patterns.itemMath, withGroup: "itemNo"),
                       "12")
        XCTAssertEqual("12. Интернет\t7.701+4.500"
                        .replaceFirstMatch(for: Patterns.itemMath, withGroup: "title"),
                       "Интернет")

        XCTAssertEqual("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995"
                        .replaceFirstMatch(for: Patterns.itemMath, withGroup: "itemNo"),
                       "6")
        XCTAssertEqual("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995"
                        .replaceFirstMatch(for: Patterns.itemMath, withGroup: "title"),
                       "Обслуживание кассовой программы Айко")

        XCTAssertEqual("12. Интернет\t7.701+4.500"
                        .replaceFirstMatch(for: Patterns.itemMath, withGroup: "value"),
                       "7.701+4.500")
        XCTAssertEqual("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995"
                        .replaceFirstMatch(for: Patterns.itemMath, withGroup: "value"),
                       "4.500+8.700+15.995")

        XCTAssertEqual("12. Интернет\t7.701+4.500"
                        .replaceFirstMatch(for: Patterns.itemMath, withGroup: "note"),
                       "7.701+4.500")
        XCTAssertEqual("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995"
                        .replaceFirstMatch(for: Patterns.itemMath, withGroup: "note"),
                       "4.500+8.700+15.995")
    }
}

extension BodySymbolFuncTests {
    func test_itemMath() {
        XCTAssertEqual(selectedBodyItems.compactMap { $0.bodySymbol(for: Patterns.itemMath) }.count,
                       3, "Should be exactly 3 matches")

        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)"
                        .bodySymbol(for: Patterns.itemMath),
                       .item(itemNumber: 1, title: "Аренда торгового помещения", value: 600_000, note: "200.000 (за август) +400.000 (за сентябрь)"))
        XCTAssertEqual("12. Интернет\t7.701+4.500"
                        .bodySymbol(for: Patterns.itemMath),
                       .item(itemNumber: 12, title: "Интернет", value: 12_201, note: "7.701+4.500"))
        XCTAssertEqual("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995"
                        .bodySymbol(for: Patterns.itemMath),
                       .item(itemNumber: 6, title: "Обслуживание кассовой программы Айко", value: 4_500+8_700+15_995, note: "4.500+8.700+15.995"))
    }
}
