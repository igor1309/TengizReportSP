//
//  itemNumber.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 09.02.2021.
//

import XCTest
import RegexTools
@testable import Model

extension RegexPatternsTests {
    func test_itemNumber() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.integer, #"\d{1,3}(?:\.\d{3})*"#)

        // MARK: no match
        XCTAssertNil("- sdf".firstMatch(for:Patterns.integer), "No number")
        XCTAssertNil("- ".firstMatch(for:Patterns.integer), "No number")

        // MARK: match
        XCTAssertEqual("-. Обслуживание кассовой программы Айко 4.500+ item".firstMatch(for: Patterns.integer),
                       "4.500")
        XCTAssertEqual("Оборот факт:141.690+1.238.900=1.380.590".firstMatch(for: Patterns.integer),
                       "141.690", "This is not math")
        XCTAssertEqual("12. Интернет 323".firstMatch(for: Patterns.integer), "12")
        XCTAssertEqual("--. Интернет 323".firstMatch(for: Patterns.integer), "323")
        XCTAssertEqual("23. Аудит кантора (Бухуслуги)\t60.000\t\t\n".firstMatch(for:Patterns.integer), "23")
        XCTAssertEqual("--. Аудит кантора (Бухуслуги)\t60.000\t\t\n".firstMatch(for:Patterns.integer), "60.000")

        XCTAssertEqual("\tПереходит минус с сентября 642.997р 43к\t\t\n".firstMatch(for:Patterns.rubliKopeiki),
                       "642.997р 43к")
    }

    func testListMatchesWithNumbers() {
        XCTAssertEqual("7.701+4.500".listMatches(for: Patterns.integer),
                       ["7.701", "4.500"])

        XCTAssertEqual("12. Интернет\t7.701+4.500".listMatches(for: Patterns.integer),
                       ["12", "7.701", "4.500"])

        XCTAssertEqual("200.000 (за август) +400.000 (за сентябрь)".listMatches(for: Patterns.integer),
                       ["200.000", "400.000"])

        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)".listMatches(for: Patterns.integer),
                       ["1", "200.000", "400.000"])

        XCTAssertEqual("4.500+8.700+15.995".listMatches(for: Patterns.integer),
                       ["4.500", "8.700", "15.995"])

        XCTAssertEqual("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995".listMatches(for: Patterns.integer),
                       ["6", "4.500", "8.700", "15.995"])

        XCTAssertEqual("Оборот факт:141.690+1.238.900=1.380.590"
                        .listMatches(for: Patterns.integer),
                       ["141.690", "1.238.900", "1.380.590"])


        XCTAssertEqual("1. Приход товара по накладным\t179.108р 89к+512.293р(оплаты фактические:199.803р 80к-переводы;81.225р 35к-корпоративная карта;34.202р-наличные из кассы; Итого 315.231р 15к)".listMatches(for: Patterns.integer),
                       ["1", "179.108", "89", "512.293", "199.803", "80", "81.225", "35", "34.202", "315.231", "15"],
                       "This line with 'Итого' should be tokenized by 'prihodWithItogo()'")
    }

}
