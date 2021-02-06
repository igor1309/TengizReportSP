//
//  itemBasic.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 04.02.2021.
//

import XCTest
@testable import TengizReportSP

extension RegexPatternsTests {
    func test_itemBasic() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.itemBasic, #"^(?<title>^.*?)(?:\t\s*)(?<value>\d{1,3}(?:\.\d{3})*)(?<comment>\s*\((?:(?!Итого|фактический|\+).)*\))?$"#)

        // MARK: exceptions
        XCTAssertNil("1. Приход товара по накладным\t 753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)".firstMatch(for: Patterns.itemBasic))
        /// item with `math` and `comment` after number
        XCTAssertNil("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)"
                        .firstMatch(for: Patterns.itemBasic),
                     "This input should be matched by 'itemMath'")


        // MARK: count in selectedBodyItems
        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: Patterns.itemBasic) }.count,
                       16, "Should be exactly 16 matchs")

        // MARK: match
        XCTAssertEqual("5. Аренда головного офиса\t11.500".firstMatch(for: Patterns.itemBasic),
                       "5. Аренда головного офиса\t11.500")
        XCTAssertEqual("16. Текущие мелкие расходы \t1.200".firstMatch(for: Patterns.itemBasic),
                       "16. Текущие мелкие расходы \t1.200")
        XCTAssertEqual("14. Контур (эл.отчетность)\t3.000".firstMatch(for: Patterns.itemBasic),
                       "14. Контур (эл.отчетность)\t3.000")
        XCTAssertEqual("22. Хэдхантер (подбор пероснала)\t3.240".firstMatch(for: Patterns.itemBasic),
                       "22. Хэдхантер (подбор пероснала)\t3.240")
        XCTAssertEqual("23. Аудит кантора (Бухуслуги)\t60.000".firstMatch(for: Patterns.itemBasic),
                       "23. Аудит кантора (Бухуслуги)\t60.000")
        XCTAssertEqual("14. РПК Ника (крепления д/телевизоров и монтаж)\t30.000".firstMatch(for: Patterns.itemBasic),
                       "14. РПК Ника (крепления д/телевизоров и монтаж)\t30.000")

        XCTAssertEqual("4. Банковская комиссия 1.6% за эквайринг\t2.120".firstMatch(for: Patterns.itemBasic),
                       "4. Банковская комиссия 1.6% за эквайринг\t2.120")
        XCTAssertEqual("27. Сервис Гуру (система аттестации, за 1 год)\t12.655".firstMatch(for: Patterns.itemBasic),
                       "27. Сервис Гуру (система аттестации, за 1 год)\t12.655")
        /// with comment
        XCTAssertEqual("1. Аренда торгового помещения\t46.667 (за июнь)"
                        .firstMatch(for: Patterns.itemBasic),
                       "1. Аренда торгового помещения\t46.667 (за июнь)")
        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за июль)"
                        .firstMatch(for: Patterns.itemBasic),
                       "1. Аренда торгового помещения\t 200.000 (за июль)")
        XCTAssertEqual("1. ФОТ\t 564.678( за вторую часть октября)"
                        .firstMatch(for: Patterns.itemBasic),
                       "1. ФОТ\t 564.678( за вторую часть октября)")
        XCTAssertEqual("1. ФОТ\t595.360 ( за первую часть ноября)"
                        .firstMatch(for: Patterns.itemBasic),
                       "1. ФОТ\t595.360 ( за первую часть ноября)")
        /// have `numbers` inside parentheses (inside comment)
        XCTAssertEqual("1. ФОТ\t19.721 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"
                        .firstMatch(for: Patterns.itemBasic),
                       "1. ФОТ\t19.721 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)")
        XCTAssertEqual("1. ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"
                        .firstMatch(for: Patterns.itemBasic),
                       "1. ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)")
        XCTAssertEqual("1. ФОТ\t 894.510( за вторую часть июля и первая часть августа)"
                        .firstMatch(for: Patterns.itemBasic),
                       "1. ФОТ\t 894.510( за вторую часть июля и первая часть августа)")
        XCTAssertEqual("1. ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)"
                        .firstMatch(for: Patterns.itemBasic),
                       "1. ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)")


        // MARK: regex structure
        XCTAssertEqual("23. Аудит кантора (Бухуслуги)\t60.000"
                        .replaceFirstMatch(for: Patterns.itemBasic, withGroup: "title"),
                       "23. Аудит кантора (Бухуслуги)")
        XCTAssertEqual("23. Аудит кантора (Бухуслуги)\t60.000"
                        .replaceFirstMatch(for: Patterns.itemBasic, withGroup: "value"),
                       "60.000")
        XCTAssertNil("23. Аудит кантора (Бухуслуги)\t60.000"
                        .replaceFirstMatch(for: Patterns.itemBasic, withGroup: ""))

        XCTAssertEqual("1. ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)"
                        .replaceFirstMatch(for: Patterns.itemBasic, withGroup: "title"),
                       "1. ФОТ")
        XCTAssertEqual("1. ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)"
                        .replaceFirstMatch(for: Patterns.itemBasic, withGroup: "value"),
                       "1.147.085")
        XCTAssertEqual("1. ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)"
                        .replaceFirstMatch(for: Patterns.itemBasic, withGroup: "comment"),
                       "( за вторую часть сентября и первую  часть октября)")

    }
}

extension BodySymbolFuncTests {
    func test_itemBasic() {
        XCTAssertEqual(selectedBodyItems.compactMap { $0.bodySymbol(for: Patterns.itemBasic) }.count,
                       16, "Should be exactly 16 matchs")

        XCTAssertEqual("5. Аренда головного офиса\t11.500".bodySymbol(for: Patterns.itemBasic),
                       .item(title: "5. Аренда головного офиса", value: 11_500, comment: nil))
        XCTAssertEqual("16. Текущие мелкие расходы \t1.200".bodySymbol(for: Patterns.itemBasic),
                       .item(title: "16. Текущие мелкие расходы", value: 1_200, comment: nil))
        XCTAssertEqual("14. Контур (эл.отчетность)\t3.000".bodySymbol(for: Patterns.itemBasic),
                       .item(title: "14. Контур (эл.отчетность)", value: 3_000, comment: nil))
        XCTAssertEqual("22. Хэдхантер (подбор пероснала)\t3.240".bodySymbol(for: Patterns.itemBasic),
                       .item(title: "22. Хэдхантер (подбор пероснала)", value: 3_240, comment: nil))
        XCTAssertEqual("23. Аудит кантора (Бухуслуги)\t60.000".bodySymbol(for: Patterns.itemBasic),
                       .item(title: "23. Аудит кантора (Бухуслуги)", value: 60_000, comment: nil))
        XCTAssertEqual("14. РПК Ника (крепления д/телевизоров и монтаж)\t30.000".bodySymbol(for: Patterns.itemBasic),
                       .item(title: "14. РПК Ника (крепления д/телевизоров и монтаж)", value: 30_000, comment: nil))

        XCTAssertEqual("4. Банковская комиссия 1.6% за эквайринг\t2.120".bodySymbol(for: Patterns.itemBasic),
                       .item(title: "4. Банковская комиссия 1.6% за эквайринг", value: 2_120, comment: nil))
        XCTAssertEqual("27. Сервис Гуру (система аттестации, за 1 год)\t12.655".bodySymbol(for: Patterns.itemBasic),
                       .item(title: "27. Сервис Гуру (система аттестации, за 1 год)", value: 12_655, comment: nil))

        /// with comment
        XCTAssertEqual("1. Аренда торгового помещения\t46.667 (за июнь)".bodySymbol(for: Patterns.itemBasic),
                       .item(title: "1. Аренда торгового помещения", value: 46_667, comment: "(за июнь)"))
        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за июль)".bodySymbol(for: Patterns.itemBasic),
                       .item(title: "1. Аренда торгового помещения", value: 200_000, comment: "(за июль)"))
        XCTAssertEqual("1. ФОТ\t 564.678( за вторую часть октября)".bodySymbol(for: Patterns.itemBasic),
                       .item(title: "1. ФОТ", value: 564_678, comment: "( за вторую часть октября)"))
        XCTAssertEqual("1. ФОТ\t595.360 ( за первую часть ноября)".bodySymbol(for: Patterns.itemBasic),
                       .item(title: "1. ФОТ", value: 595_360, comment: "( за первую часть ноября)"))
        /// have `numbers` inside parentheses (inside comment)
        XCTAssertEqual("1. ФОТ\t19.721 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)".bodySymbol(for: Patterns.itemBasic),
                       .item(title: "1. ФОТ", value: 19_721, comment: "( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"))
        XCTAssertEqual("1. ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)".bodySymbol(for: Patterns.itemBasic),
                       .item(title: "1. ФОТ", value: 704_848, comment: "( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"))
        XCTAssertEqual("1. ФОТ\t 894.510( за вторую часть июля и первая часть августа)".bodySymbol(for: Patterns.itemBasic),
                       .item(title: "1. ФОТ", value: 894_510, comment: "( за вторую часть июля и первая часть августа)"))
        XCTAssertEqual("1. ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)".bodySymbol(for: Patterns.itemBasic),
                       .item(title: "1. ФОТ", value: 1_147_085, comment: "( за вторую часть сентября и первую  часть октября)"))

        // no number
        XCTAssertNil("1. Аренда торгового помещения\t-----------------------------".bodySymbol(for: Patterns.itemBasic),
                       "1. Аренда торгового помещения\t-----------------------------")
        XCTAssertNil("2. Предоплаченный товар, но не отраженный в приходе".bodySymbol(for: Patterns.itemBasic),
                       "2. Предоплаченный товар, но не отраженный в приходе")

        // other
        XCTAssertNil("1. Приход товара по накладным\t 753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)".bodySymbol(for: Patterns.itemBasic))
    }
}
