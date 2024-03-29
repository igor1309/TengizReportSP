//
//  itemCorrection.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 05.02.2021.
//

import XCTest
@testable import TengizReportModel

extension Patterns {
}

extension RegexPatternsTests {
    func test_itemCorrection() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.itemCorrection,
                       #"^\s*(?<value>-\d{1,3}(?:\.\d{3})*)\s*(?<title>.*)$"#)

        // MARK: no match
        XCTAssertNil("4. Банковская комиссия 1.6 за эквайринг\t2.120".firstMatch(for: Patterns.itemCorrection))

        // MARK: count in selectedBodyItems
        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: Patterns.itemCorrection) }.count,
                       1, "Should be exactly 1 match")

        // MARK: match
        XCTAssertEqual("\t-10.000 за перерасход питание персонала в июле"
                        .firstMatch(for: Patterns.itemCorrection),
                       "\t-10.000 за перерасход питание персонала в июле")

        XCTAssertEqual("-10.000 за перерасход питание персонала в июле"
                        .firstMatch(for: Patterns.itemCorrection),
                       "-10.000 за перерасход питание персонала в июле")

        // MARK: regex structure
        XCTAssertEqual("-10.000 за перерасход питание персонала в июле"
                        .replaceFirstMatch(for: Patterns.itemCorrection, withGroup: "title"),
                       "за перерасход питание персонала в июле")
        XCTAssertEqual("\t-10.000 за перерасход питание персонала в июле"
                        .replaceFirstMatch(for: Patterns.itemCorrection, withGroup: "title"),
                       "за перерасход питание персонала в июле")

        XCTAssertEqual("-10.000 за перерасход питание персонала в июле"
                        .replaceFirstMatch(for: Patterns.itemCorrection, withGroup: "value"),
                       "-10.000")
        XCTAssertEqual("\t-10.000 за перерасход питание персонала в июле"
                        .replaceFirstMatch(for: Patterns.itemCorrection, withGroup: "value"),
                       "-10.000")

        XCTAssertNil("4. Банковская комиссия 1.6% за эквайринг\t2.120"
                        .replaceFirstMatch(for: Patterns.itemCorrection, withGroup: "commnemt"))
    }
}

extension BodySymbolFuncTests {
    func test_itemCorrection() {
        XCTAssertEqual(selectedBodyItems.compactMap { $0.bodySymbol(for: Patterns.itemCorrection) }.count,
                       1, "Should be exactly 1 match")

        XCTAssertEqual("-10.000 за перерасход питание персонала в июле".bodySymbol(for: Patterns.itemCorrection),
                       .item(itemNumber: 0, title: "Correction", value: -10_000, note: "-10.000 за перерасход питание персонала в июле"))

        XCTAssertNil("4. Банковская комиссия 1.6 за эквайринг\t2.120".bodySymbol(for: Patterns.itemCorrection))
    }
}
