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
        let input = "1. Аренда торгового помещения\t46.667 (за июнь)"
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

        #warning("need more tests here + failing tests")
    }
}
