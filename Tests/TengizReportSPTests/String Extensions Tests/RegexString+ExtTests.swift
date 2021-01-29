//
//  RegexString+ExtTests.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 28.01.2021.
//

import XCTest
@testable import TengizReportSP

final class RegexStringExtTests: XCTestCase {
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
