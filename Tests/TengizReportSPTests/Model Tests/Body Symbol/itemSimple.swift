//
//  itemSimple.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 04.02.2021.
//

import XCTest
@testable import TengizReportSP

extension Patterns {
    /// `itemSimple`: item title and number, no itogo, no number inside parantheses, no %, no comment after number
    static let itemSimple = #"(?<title>\#(bodyItemStart)\D+)(?<value>\#(Patterns.itemNumber))$"#
}

extension RegexPatternsTests {
    func test_itemSimple() {
        //XCTAssertEqual(itemSimple, "")
        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: Patterns.itemSimple) }.count,
                       6, "Should be exactly 6 matchs")

        XCTAssertEqual("5. Аренда головного офиса\t11.500".firstMatch(for: Patterns.itemSimple),
                       "5. Аренда головного офиса\t11.500")
        XCTAssertEqual("16. Текущие мелкие расходы \t1.200".firstMatch(for: Patterns.itemSimple),
                       "16. Текущие мелкие расходы \t1.200")
        XCTAssertEqual("14. Контур (эл.отчетность)\t3.000".firstMatch(for: Patterns.itemSimple),
                       "14. Контур (эл.отчетность)\t3.000")
        XCTAssertEqual("22. Хэдхантер (подбор пероснала)\t3.240".firstMatch(for: Patterns.itemSimple),
                       "22. Хэдхантер (подбор пероснала)\t3.240")
        XCTAssertEqual("23. Аудит кантора (Бухуслуги)\t60.000".firstMatch(for: Patterns.itemSimple),
                       "23. Аудит кантора (Бухуслуги)\t60.000")
        XCTAssertEqual("14. РПК Ника (крепления д/телевизоров и монтаж)\t30.000".firstMatch(for: Patterns.itemSimple),
                       "14. РПК Ника (крепления д/телевизоров и монтаж)\t30.000")

        XCTAssertNil("27. Сервис Гуру (система аттестации, за 1 год)\t12.655".firstMatch(for: Patterns.itemSimple), "Number match fail due to number inside parentheses")
    }
}

extension BodySymbolFuncTests {
    func test_itemSimple() {
        XCTAssertEqual(selectedBodyItems.compactMap { $0.bodySymbol(for: Patterns.itemSimple) }.count,
                       6, "Should be exactly 6 matchs")

        XCTAssertEqual("5. Аренда головного офиса\t11.500".bodySymbol(for: Patterns.itemSimple),
                       .item(title: "5. Аренда головного офиса", value: 11_500, comment: nil))
        XCTAssertEqual("16. Текущие мелкие расходы \t1.200".bodySymbol(for: Patterns.itemSimple),
                       .item(title: "16. Текущие мелкие расходы", value: 1_200, comment: nil))
        XCTAssertEqual("14. Контур (эл.отчетность)\t3.000".bodySymbol(for: Patterns.itemSimple),
                       .item(title: "14. Контур (эл.отчетность)", value: 3_000, comment: nil))
        XCTAssertEqual("22. Хэдхантер (подбор пероснала)\t3.240".bodySymbol(for: Patterns.itemSimple),
                       .item(title: "22. Хэдхантер (подбор пероснала)", value: 3_240, comment: nil))
        XCTAssertEqual("23. Аудит кантора (Бухуслуги)\t60.000".bodySymbol(for: Patterns.itemSimple),
                       .item(title: "23. Аудит кантора (Бухуслуги)", value: 60_000, comment: nil))
        XCTAssertEqual("14. РПК Ника (крепления д/телевизоров и монтаж)\t30.000".bodySymbol(for: Patterns.itemSimple),
                       .item(title: "14. РПК Ника (крепления д/телевизоров и монтаж)", value: 30_000, comment: nil))
    }
}
