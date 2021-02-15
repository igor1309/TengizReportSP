//
//  itemTitle.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 10.02.2021.
//

import XCTest
@testable import Model

extension RegexPatternsTests {
    func test_itemTitle() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.itemTitle, #"^(?<itemNo>\d\d?)\.\s*(?<title>.+?)(?:\t\s*)(?:\t\t)?"#)
        // MARK: no match
        XCTAssertNil("12. Интернет 323".firstMatch(for: Patterns.itemTitle), "Should have \t")
        XCTAssertNil("6. Обслуживание кассовой программы Айко 4.500+ item".firstMatch(for: Patterns.itemTitle), "Should have \t")
        XCTAssertNil("Оборот факт:141.690+1.238.900=1.380.590".firstMatch(for: Patterns.itemTitle), "Should have \t")

        // MARK: match
        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)"
                        .firstMatch(for: Patterns.itemTitle),
                       "1. Аренда торгового помещения\t ")
        XCTAssertEqual("5. Аренда головного офиса\t11.500\t\t"
                        .firstMatch(for: Patterns.itemTitle),
                       "5. Аренда головного офиса\t")
        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)"
                        .firstMatch(for: Patterns.itemTitle),
                       "1. Аренда торгового помещения\t ")
        XCTAssertEqual("12. Интернет\t7.701+4.500".firstMatch(for: Patterns.itemTitle),
                       "12. Интернет\t")
        XCTAssertEqual("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995".firstMatch(for: Patterns.itemTitle),
                       "6. Обслуживание кассовой программы Айко\t")

        // MARK: regex structure
        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)"
                        .replaceFirstMatch(for: Patterns.itemTitle, withGroup: "title"),
                       "Аренда торгового помещения")
        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)"
                        .replaceFirstMatch(for: Patterns.itemTitle, withGroup: "itemNo"),
                       "1")
        XCTAssertEqual("16. Текущие мелкие расходы \t1.200"
                        .replaceFirstMatch(for: Patterns.itemTitle, withGroup: "itemNo"),
                       "16")
        XCTAssertNil("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)"
                        .replaceFirstMatch(for: Patterns.itemTitle, withGroup: "TITLE"),
                     "No group 'TITLE'")
    }
}
