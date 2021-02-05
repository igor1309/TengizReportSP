//
//  itemSimple.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 04.02.2021.
//

import XCTest
@testable import TengizReportSP

extension RegexPatternsTests {
    func test_itemSimple() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.itemSimple, #"(?<title>^\d+\.\D+)(?:\t)(?<value>\d{1,3}(?:\.\d{3})*)$"#)

        // MARK: exceptions
        XCTAssertNil("27. Сервис Гуру (система аттестации, за 1 год)\t12.655".firstMatch(for: Patterns.itemSimple), "Match fail due to number inside parentheses")
        XCTAssertNil("1. ФОТ\t19.721 ( за вторую с 25 по 30 июля)".firstMatch(for: Patterns.itemSimple), "Match fail due to comment after value")
        XCTAssertNil("1. Приход товара по накладным\t 753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)".firstMatch(for: Patterns.itemSimple))

        // MARK: count in selectedBodyItems
        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: Patterns.itemSimple) }.count,
                       6, "Should be exactly 6 matchs")

        // MARK: match
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

        // MARK: regex structure
        XCTAssertEqual("23. Аудит кантора (Бухуслуги)\t60.000"
                        .replaceFirstMatch(for: Patterns.itemSimple, withGroup: "title"),
                       "23. Аудит кантора (Бухуслуги)")
        XCTAssertEqual("23. Аудит кантора (Бухуслуги)\t60.000"
                        .replaceFirstMatch(for: Patterns.itemSimple, withGroup: "value"),
                       "60.000")
        XCTAssertNil("23. Аудит кантора (Бухуслуги)\t60.000"
                        .replaceFirstMatch(for: Patterns.itemSimple, withGroup: ""))

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

        XCTAssertNil("27. Сервис Гуру (система аттестации, за 1 год)\t12.655".bodySymbol(for: Patterns.itemSimple), "Match fail due to number inside parentheses")
        XCTAssertNil("1. ФОТ\t19.721 ( за вторую с 25 по 30 июля)".bodySymbol(for: Patterns.itemSimple), "Match fail due to comment after value")
        XCTAssertNil("1. Приход товара по накладным\t 753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)".bodySymbol(for: Patterns.itemSimple))
    }
}
