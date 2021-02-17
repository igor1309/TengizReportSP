//
//  RegexString+ExtTests.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 28.01.2021.
//

import XCTest
import RegexTools
@testable import Model

final class RegexStringExtTests: XCTestCase {
    func testRegexGroupName() {
        let input = "1. Аренда торгового помещения\t46.667 (за июнь)"
        let pattern = #"(?<title>^\d+\.\D+)(?<value>\d{1,3}(?:\.\d{3})*)(?<note>.*)$"#

        XCTAssertEqual(input.replaceFirstMatch(for: pattern, withGroup: "title")?
                        .trimmingCharacters(in: .whitespaces),
                       "1. Аренда торгового помещения")
        XCTAssertEqual(input.replaceFirstMatch(for: pattern, withGroup: "value"),
                       "46.667")
        XCTAssertEqual(input.replaceFirstMatch(for: pattern, withGroup: "note")?
                        .trimmingCharacters(in: .whitespaces),
                       "(за июнь)")
    }

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


    func testReplaceMatches() {
        XCTAssertEqual("ababbcadbbcd".replaceMatches(for: "bb", withString: " "),
                       "aba cad cd",
                       "Strings should be equal")
        XCTAssertEqual("aba 23 b5666bc ad8888bbcd".replaceMatches(for: #"\d"#, withString: ""),
                       "aba  bbc adbbcd",
                       "Strings should be equal")
        XCTAssertEqual("ab      a   bcd".replaceMatches(for: #" +"#, withString: " "),
                       "ab a bcd",
                       "Strings should be equal")
    }

    func testListMatches() {
        XCTAssertEqual("aba 23 b5666bc ad8888bbcd".listMatches(for: #"\d+"#),
                       ["23", "5666", "8888"])
    }


    func testFirstMatch() {
        XCTAssertNil("aaa".firstMatch(for: "AAA"))
        XCTAssertEqual("aaa".firstMatch(for: "aa"), "aa")
        XCTAssertEqual("aaddddaaaaa".firstMatch(for: #"a{3}"#), "aaa")
        XCTAssertEqual("slkj34 sldjfh 344".firstMatch(for: #"\d+"#), "34")
    }

    func testReplaceFirstMatch() {
        XCTAssertNil("aaa".replaceFirstMatch(for: "AAA", withString: "BB"))
        XCTAssertEqual("aaa".replaceFirstMatch(for: "aa", withString: "BB"), "BBa")
    }

}
