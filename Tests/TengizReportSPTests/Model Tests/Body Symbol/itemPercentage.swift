//
//  itemPercentage.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 04.02.2021.
//

import XCTest
@testable import TengizReportSP

extension Patterns {
    /// item with digits and `percentage` inside item title
    static let itemPercentage = #"(?<title>\#(bodyItemStart)\D*\d{1,3}\.\d{1,2}\%\D+)(?<value>\#(Patterns.itemNumber))"#
}

extension RegexPatternsTests {
    func test_itemPercentage() {
        XCTAssertEqual(Patterns.itemPercentage, #"(?<title>^\d+\.\D*\d{1,3}\.\d{1,2}\%\D+)(?<value>\d{1,3}(?:\.\d{3})*)"#)

        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: Patterns.itemPercentage) }.count,
                       1, "Should be exactly 1 match")

        XCTAssertEqual("4. Банковская комиссия 1.6% за эквайринг\t2.120".firstMatch(for: Patterns.itemPercentage),
                       "4. Банковская комиссия 1.6% за эквайринг\t2.120")

        XCTAssertNil("4. Банковская комиссия 1.6 за эквайринг\t2.120".firstMatch(for: Patterns.itemPercentage))
    }
}

extension BodySymbolFuncTests {
    func test_itemPercentage() {
        XCTAssertEqual(selectedBodyItems.compactMap { $0.bodySymbol(for: Patterns.itemPercentage) }.count,
                       1, "Should be exactly 1 match")

        XCTAssertEqual("4. Банковская комиссия 1.6% за эквайринг\t2.120".bodySymbol(for: Patterns.itemPercentage),
                       .item(title: "4. Банковская комиссия 1.6% за эквайринг", value: 2_120, comment: nil))

        XCTAssertNil("4. Банковская комиссия 1.6 за эквайринг\t2.120".bodySymbol(for: Patterns.itemPercentage))
    }
}
