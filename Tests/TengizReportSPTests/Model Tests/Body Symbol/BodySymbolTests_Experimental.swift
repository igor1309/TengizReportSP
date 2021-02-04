//
//  BodySymbolTests_Experimental.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 03.02.2021.
//

import XCTest
@testable import TengizReportSP

extension String {
    func bodySymbol(for pattern: String) -> BodySymbol? {
        guard firstMatch(for: pattern) != nil else { return nil }

        guard let title = replaceFirstMatch(for: pattern, withGroup: "title")?
                .trimmingCharacters(in: .whitespaces) else { return nil }
        guard let valueStr = replaceFirstMatch(for: pattern, withGroup: "value")?
                .trimmingCharacters(in: .whitespaces),
              let value = valueStr.numberWithSign() else { return nil }

        let comment = replaceFirstMatch(for: pattern, withGroup: "comment")?
            .trimmingCharacters(in: .whitespaces) ?? ""

        return .item(title: title, value: value, comment: comment.isEmpty ? nil : comment)
    }
}

extension RegexStringExtTests {
    func test_replaceFirstMatch_withGroup() {
        let input = "1. Аренда торгового помещения\t46.667 (за июнь)"

        XCTAssertEqual(input.replaceFirstMatch(for: #"(?<title>\w{6})"#, withGroup: "title"),
                       "Аренда")
        XCTAssertEqual(input.replaceFirstMatch(for: #"^\d+\.\D+(?<number>\d{1,3}(?:\.\d{3})*)\D*$"#, withGroup: "number"),
                       "46.667")
        XCTAssertEqual(input.replaceFirstMatch(for: #"(?<number>мещен)"#, withGroup: "number"),
                       "мещен")

        XCTAssertNil(input.replaceFirstMatch(for: #"(?<number>мещен)"#, withGroup: "title"),
                     "Matching to non-existing group 'title'")
    }
}

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
    }

    func testRegexGroupName() {
        let input = "1. Аренда торгового помещения\t46.667 (за июнь)"
        let pattern = #"(?<title>^\d+\.\D+)(?<value>\d{1,3}(?:\.\d{3})*)(?<comment>.*)$"#

        XCTAssertEqual(input.replaceFirstMatch(for: pattern, withGroup: "title")?
                        .trimmingCharacters(in: .whitespaces),
                       "1. Аренда торгового помещения")
        XCTAssertEqual(input.replaceFirstMatch(for: pattern, withGroup: "value"),
                       "46.667")
        XCTAssertEqual(input.replaceFirstMatch(for: pattern, withGroup: "comment")?
                        .trimmingCharacters(in: .whitespaces),
                       "(за июнь)")
    }
}
