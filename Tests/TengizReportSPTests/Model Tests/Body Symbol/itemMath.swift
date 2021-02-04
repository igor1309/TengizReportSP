//
//  itemMath.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 04.02.2021.
//

import XCTest
@testable import TengizReportSP

extension Patterns {
    /// `itemMath`
    static let itemMath = #"(?<title>\#(bodyItemStart)\D+)(?<value>\#(Patterns.itemNumber)(?:\+\#(Patterns.itemNumber))+)$"#
}

extension RegexPatternsTests {
    func test_itemMath() {
        #warning("add this kind of testing to 'numberWithSign' func tests")
        XCTAssertEqual("4.500+8.700+15.995".numberWithSign(), 4_500+8_700+15_995)

        XCTAssertEqual(Patterns.itemMath, #"(?<title>^\d+\.\D+)(?<value>\d{1,3}(?:\.\d{3})*(?:\+\d{1,3}(?:\.\d{3})*)+)$"#)

        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: Patterns.itemMath) }.count,
                       2, "Should be exactly 2 matches")
        
        XCTAssertEqual("12. Интернет\t7.701+4.500".firstMatch(for: Patterns.itemMath),
                       "12. Интернет\t7.701+4.500")
        XCTAssertEqual("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995".firstMatch(for: Patterns.itemMath),
                       "6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995")
    }
}

extension BodySymbolFuncTests {
    func test_itemMath() {
        XCTAssertEqual(selectedBodyItems.compactMap { $0.bodySymbol(for: Patterns.itemMath) }.count,
                       2, "Should be exactly 2 matches")

        XCTAssertEqual("12. Интернет\t7.701+4.500".bodySymbol(for: Patterns.itemMath),
                       .item(title: "12. Интернет", value: 12_201, comment: nil))
        XCTAssertEqual("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995".bodySymbol(for: Patterns.itemMath),
                       .item(title: "6. Обслуживание кассовой программы Айко", value: 4_500+8_700+15_995, comment: nil))
    }
}
