//
//  BodySymbolTests_Experimental.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 03.02.2021.
//

import XCTest
@testable import TengizReportSP

#warning("move to it's file")
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
