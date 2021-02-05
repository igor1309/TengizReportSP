//
//  itemNumberInsideParentheses.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 04.02.2021.
//

import XCTest
@testable import TengizReportSP

extension Patterns {
    /// `itemNumberInsideParentheses`: item with number inside parentheses
    static let itemNumberInsideParentheses = #"(?<title>\#(bodyItemStart).*\(.*\d.*\))\s*(?<value>\#(Patterns.itemNumber))$"#
}

extension RegexPatternsTests {
    func test_itemNumberInsideParentheses() {
        XCTAssertEqual(Patterns.itemNumberInsideParentheses, #"(?<title>^\d+\..*\(.*\d.*\))\s*(?<value>\d{1,3}(?:\.\d{3})*)$"#)

        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: Patterns.itemNumberInsideParentheses) }.count,
                       1, "Should be exactly 1 match")

        XCTAssertEqual("27. Сервис Гуру (система аттестации, за 1 год)\t12.655".firstMatch(for: Patterns.itemNumberInsideParentheses),
                       "27. Сервис Гуру (система аттестации, за 1 год)\t12.655")

        XCTAssertNil("27. Сервис Гуру (система аттестации, год)\t12.655".firstMatch(for: Patterns.itemNumberInsideParentheses))
        XCTAssertNil("27. Сервис Гуру \t12.655".firstMatch(for: Patterns.itemNumberInsideParentheses))
    }
}

extension BodySymbolFuncTests {
    func test_itemNumberInsideParentheses() {
        XCTAssertEqual(selectedBodyItems.compactMap { $0.bodySymbol(for: Patterns.itemNumberInsideParentheses) }.count,
                       1, "Should be exactly 1 match")

        XCTAssertEqual("27. Сервис Гуру (система аттестации, за 1 год)\t12.655".bodySymbol(for: Patterns.itemNumberInsideParentheses),
                       .item(title: "27. Сервис Гуру (система аттестации, за 1 год)", value: 12_655, comment: nil))

        XCTAssertNil("27. Сервис Гуру (система аттестации, год)\t12.655".bodySymbol(for: Patterns.itemNumberInsideParentheses))
        XCTAssertNil("27. Сервис Гуру \t12.655".bodySymbol(for: Patterns.itemNumberInsideParentheses))
    }
}
