//
//  itemNumberInsideParentheses.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 04.02.2021.
//

import XCTest
@testable import TengizReportSP

extension RegexPatternsTests {
    func test_itemNumberInsideParentheses() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.itemNumberInsideParentheses,
                       #"(?<title>^\d+\.\D+\(.*\d.*\))\s*(?<value>\d{1,3}(?:\.\d{3})*)$"#)

        // MARK: exceptions
        XCTAssertNil("27. Сервис Гуру (система аттестации, год)\t12.655".firstMatch(for: Patterns.itemNumberInsideParentheses))
        XCTAssertNil("27. Сервис Гуру \t12.655".firstMatch(for: Patterns.itemNumberInsideParentheses))

        // MARK: count in selectedBodyItems
        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: Patterns.itemNumberInsideParentheses) }.count,
                       1, "Should be exactly 1 match")

        // MARK: match
        XCTAssertEqual("27. Сервис Гуру (система аттестации, за 1 год)\t12.655"
                        .firstMatch(for: Patterns.itemNumberInsideParentheses),
                       "27. Сервис Гуру (система аттестации, за 1 год)\t12.655")

        // MARK: regex structure
        XCTAssertEqual("27. Сервис Гуру (система аттестации, за 1 год)\t12.655"
                        .replaceFirstMatch(for: Patterns.itemNumberInsideParentheses, withGroup: "title"),
                       "27. Сервис Гуру (система аттестации, за 1 год)")
        XCTAssertEqual("27. Сервис Гуру (система аттестации, за 1 год)\t12.655"
                        .replaceFirstMatch(for: Patterns.itemNumberInsideParentheses, withGroup: "value"),
                       "12.655")
        XCTAssertNil("27. Сервис Гуру (система аттестации, за 1 год)\t12.655"
                        .replaceFirstMatch(for: Patterns.itemNumberInsideParentheses, withGroup: "comment"))
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
