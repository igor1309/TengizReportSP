//
//  math.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 05.02.2021.
//

import XCTest
@testable import TengizReportSP

extension RegexPatternsTests {
    func test_math() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.math, #"\d{1,3}(?:\.\d{3})*(?:\D*\s*\+\s*\d{1,3}(?:\.\d{3})*)+"#)

        // MARK: exceptions
        XCTAssertNil("12. Интернет\t7.701".firstMatch(for: Patterns.math))
        XCTAssertNil("12. Интернет + internet".firstMatch(for: Patterns.math))

        // MARK: count in selectedBodyItems
        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: Patterns.math) }.count,
                       4, "Should be exactly 4 matches")

        // MARK: match
        let inputNotUsedToBeTokenizedByItemMathPattern = "1. Приход товара по накладным\t179.108р 89к+512.293р(оплаты фактические:199.803р 80к-переводы;81.225р 35к-корпоративная карта;34.202р-наличные из кассы; Итого 315.231р 15к)"
        XCTAssertEqual(inputNotUsedToBeTokenizedByItemMathPattern
                        .firstMatch(for: Patterns.math),
                       "89к+512.293")
        
        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)"
                        .firstMatch(for: Patterns.math),
                       "200.000 (за август) +400.000")
        XCTAssertEqual("12. Интернет\t7.701+4.500".firstMatch(for: Patterns.math),
                       "7.701+4.500")
        XCTAssertEqual("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995"
                        .firstMatch(for: Patterns.math),
                       "4.500+8.700+15.995")

        XCTAssertEqual("Оборот факт:141.690+1.238.900=1.380.590"
                        .firstMatch(for: Patterns.math),
                       "141.690+1.238.900")
    }

}
