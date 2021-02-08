//
//  BodySymbolFuncTests.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 03.02.2021.
//

import XCTest
@testable import TengizReportSP

final class BodySymbolFuncTests: XCTestCase {
    func test_func_bodySymbol() {
        var input = "1. Аренда торгового помещения\t46.667 (за июнь)"
        let pattern = #"(?<title>^\d+\.\D+)(?<value>\d{1,3}(?:\.\d{3})*)(?<comment>.*)$"#

        XCTAssertEqual(input.replaceFirstMatch(for: pattern, withString: "$1")?
                        .trimmingCharacters(in: .whitespaces),
                       "1. Аренда торгового помещения")
        XCTAssertEqual(input.replaceFirstMatch(for: pattern, withString: "$2"),
                       "46.667")
        XCTAssertEqual(input.replaceFirstMatch(for: pattern, withString: "$3")?
                        .trimmingCharacters(in: .whitespaces),
                       "(за июнь)")

        XCTAssertEqual(input.bodySymbol(for: pattern),
                       .item(title: "1. Аренда торгового помещения", value: 46_667, comment: "(за июнь)"))

        let pattern2 = #"(?<title>^\d+\.\D+)(?<value>\d{1,3}(?:\.\d{3})*).*$"#
        XCTAssertEqual(input.replaceFirstMatch(for: pattern2, withString: "$3")?
                        .trimmingCharacters(in: .whitespaces),
                       "", "Capturing non-existing group (just 2 groups in regex '\(pattern2)')")

        XCTAssertEqual(input.bodySymbol(for: pattern2),
                       .item(title: "1. Аренда торгового помещения", value: 46_667, comment: nil),
                       "Comment group is nil")

        // no match
        input = "1. Приход товара по накладным\t922.936р37к (оплаты фактические: 313.570р26к-переводы; 87.091р20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р46к)"
        XCTAssertNotEqual(input.bodySymbol(for: pattern),
                          .item(title: "1. Приход товара по накладным", value: 498_373.46, comment: "922.936р37к (оплаты фактические: 313.570р26к-переводы; 87.091р20к-корпоративная карта; 97.712-наличные из кассы; Итого-498.373р46к)"))
        XCTAssertNotEqual(input.bodySymbol(for: pattern2),
                          .item(title: "1. Приход товара по накладным", value: 498_373.46, comment: "922.936р37к (оплаты фактические: 313.570р26к-переводы; 87.091р20к-корпоративная карта; 97.712-наличные из кассы; Итого-498.373р46к)"))


        #warning("need more tests here + negative tests")
    }
}
