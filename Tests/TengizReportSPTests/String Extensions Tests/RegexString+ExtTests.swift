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

    func testListMatchesWithNumbers() {
        let sources = try? filenames
            .flatMap { filename -> [String] in
                let clear = try filename
                    .contentsOfFile()
                    .clearReport()
                let filtered = ReportContent(stringLiteral: clear)
                    .body
                    .flatMap { $0.components(separatedBy: "\n") }
                    .filter { $0.contains("+") }
                return filtered
            }
        XCTAssertNotNil(sources)

        XCTAssertEqual("7.701+4.500".listMatches(for: Patterns.itemNumber),
                       ["7.701", "4.500"])

        XCTAssertEqual("12. Интернет\t7.701+4.500".listMatches(for: Patterns.itemNumber),
                       ["12", "7.701", "4.500"])

        XCTAssertEqual("200.000 (за август) +400.000 (за сентябрь)".listMatches(for: Patterns.itemNumber),
                       ["200.000", "400.000"])

        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)".listMatches(for: Patterns.itemNumber),
                       ["1", "200.000", "400.000"])

        XCTAssertEqual("4.500+8.700+15.995".listMatches(for: Patterns.itemNumber),
                       ["4.500", "8.700", "15.995"])

        XCTAssertEqual("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995".listMatches(for: Patterns.itemNumber),
                       ["6", "4.500", "8.700", "15.995"])

        XCTAssertEqual("1. Приход товара по накладным\t179.108р 89к+512.293р(оплаты фактические:199.803р 80к-переводы;81.225р 35к-корпоративная карта;34.202р-наличные из кассы; Итого 315.231р 15к)".listMatches(for: Patterns.itemNumber),
                       ["1", "179.108", "89", "512.293", "199.803", "80", "81.225", "35", "34.202", "315.231", "15"],
                       "This line with 'Итого' should be tokenized by 'prihodWithItogo()'")
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
