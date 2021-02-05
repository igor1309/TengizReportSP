//
//  itemNoNumber.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 04.02.2021.
//

import XCTest
@testable import TengizReportSP

extension RegexPatternsTests {
    func test_itemNoNumber() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.itemNoNumber, #"(?<title>^\d+\.\D+)((?!\d).)*$"#)

        // MARK: exceptions
        XCTAssertNil("1. Аренда торгового помещения\t-----------------------------"
                        .replaceFirstMatch(for: Patterns.itemNoNumber, withGroup: "value"))
        XCTAssertNil("2. Предоплаченный товар, но не отраженный в приходе"
                        .replaceFirstMatch(for: Patterns.itemNoNumber, withGroup: "value"))

        XCTAssertNil("5. Аренда головного офиса\t11.500".firstMatch(for: Patterns.itemNoNumber))
        XCTAssertNil("4. Банковская комиссия 1.6% за эквайринг\t2.120".firstMatch(for: Patterns.itemNoNumber))
        XCTAssertNil("-10.000 за перерасход питание персонала в июле".firstMatch(for: Patterns.itemNoNumber))
        XCTAssertNil("12. Интернет\t7.701+4.500".firstMatch(for: Patterns.itemNoNumber))
        XCTAssertNil("27. Сервис Гуру (система аттестации, за 1 год)\t12.655".firstMatch(for: Patterns.itemNoNumber))

        // MARK: count in selectedBodyItems
        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: Patterns.itemNoNumber) }.count,
                       2, "Should be exactly 2 matches")

        // MARK: usage
        XCTAssertEqual("1. Аренда торгового помещения\t-----------------------------".firstMatch(for: Patterns.itemNoNumber),
                       "1. Аренда торгового помещения\t-----------------------------")
        XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе".firstMatch(for: Patterns.itemNoNumber),
                       "2. Предоплаченный товар, но не отраженный в приходе")

        // MARK: regex structure
        XCTAssertEqual("1. Аренда торгового помещения\t-----------------------------"
                        .replaceFirstMatch(for: Patterns.itemNoNumber, withGroup: "title"),
                       "1. Аренда торгового помещения\t-----------------------------")
        XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе"
                        .replaceFirstMatch(for: Patterns.itemNoNumber, withGroup: "title"),
                       "2. Предоплаченный товар, но не отраженный в приходе")
        XCTAssertNil("2. Предоплаченный товар, но не отраженный в приходе"
                        .replaceFirstMatch(for: Patterns.itemNoNumber, withGroup: "value"))
    }
}

extension BodySymbolFuncTests {
    func test_itemNoNumber() {
        XCTAssertNil("1. Аренда торгового помещения\t----------".bodySymbol(for: Patterns.itemNoNumber))
        XCTAssertNil("2. Предоплаченный товар, но не отраженный в приходе".bodySymbol(for: Patterns.itemNoNumber))
        XCTAssertNil("5. Аренда головного офиса\t11.500".bodySymbol(for: Patterns.itemNoNumber))
        XCTAssertNil("4. Банковская комиссия 1.6% за эквайринг\t2.120".bodySymbol(for: Patterns.itemNoNumber))
        XCTAssertNil("-10.000 за перерасход питание персонала в июле".bodySymbol(for: Patterns.itemNoNumber))
        XCTAssertNil("12. Интернет\t7.701+4.500".bodySymbol(for: Patterns.itemNoNumber))
        XCTAssertNil("27. Сервис Гуру (система аттестации, за 1 год)\t12.655".bodySymbol(for: Patterns.itemNoNumber))
    }
}
