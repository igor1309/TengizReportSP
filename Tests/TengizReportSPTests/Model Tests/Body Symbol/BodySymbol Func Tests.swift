//
//  BodySymbolFuncTests.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 03.02.2021.
//

import XCTest
@testable import TengizReportModel

final class BodySymbolFuncTests: XCTestCase {
    #warning("what is this func for????")
    func test_func_bodySymbol() {
        var input = "1. Аренда торгового помещения\t46.667 (за июнь)"
        let pattern = Patterns.itemBasic//#"(?<title>^\d+\.\D+)(?<value>\d{1,3}(?:\.\d{3})*)(?<note>.*)$"#

        XCTAssertEqual(input.replaceFirstMatch(for: pattern, withString: "$1")?
                        .trimmingCharacters(in: .whitespaces),
                       "1")
        XCTAssertEqual(input.replaceFirstMatch(for: pattern, withString: "$2"),
                       "Аренда торгового помещения")
        XCTAssertEqual(input.replaceFirstMatch(for: pattern, withString: "$3")?
                        .trimmingCharacters(in: .whitespaces),
                       "46.667")
        XCTAssertEqual(input.replaceFirstMatch(for: pattern, withString: "$6")?
                        .trimmingCharacters(in: .whitespaces),
                       "(за июнь)",
                       "Multiple groups in pattern, better use group names")

        XCTAssertEqual(input.bodySymbol(for: pattern),
                       .item(itemNumber: 1, title: "Аренда торгового помещения", value: 46_667, note: "(за июнь)"))

        XCTAssertEqual(input.replaceFirstMatch(for: pattern, withString: "$5")?
                        .trimmingCharacters(in: .whitespaces),
                       "", "Capturing non-existing group (just 4 groups in regex '\(pattern)')")

        XCTAssertEqual(input.bodySymbol(for: pattern),
                       .item(itemNumber: 1, title: "Аренда торгового помещения", value: 46_667, note: "(за июнь)"),
                       "Comment group is nil")

        // no match
        input = "1. Приход товара по накладным\t922.936р37к (оплаты фактические: 313.570р26к-переводы; 87.091р20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р46к)"
        XCTAssertNotEqual(input.bodySymbol(for: pattern),
                          .item(itemNumber: 1, title: "Приход товара по накладным", value: 498_373.46, note: "922.936р37к (оплаты фактические: 313.570р26к-переводы; 87.091р20к-корпоративная карта; 97.712-наличные из кассы; Итого-498.373р46к)"))
        let pattern2 = #"(?<title>^\d+\.\D+)(?<value>\d{1,3}(?:\.\d{3})*).*$"#
        XCTAssertNotEqual(input.bodySymbol(for: pattern2),
                          .item(itemNumber: 1, title: "Приход товара по накладным", value: 498_373.46, note: "922.936р37к (оплаты фактические: 313.570р26к-переводы; 87.091р20к-корпоративная карта; 97.712-наличные из кассы; Итого-498.373р46к)"))


        #warning("need more tests here + negative tests")
    }
}
