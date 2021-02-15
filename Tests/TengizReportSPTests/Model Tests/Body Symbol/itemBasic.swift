//
//  itemBasic.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 04.02.2021.
//

import XCTest
@testable import Model

extension RegexPatternsTests {
    func test_itemBasic() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.itemBasic, #"^(?<itemNo>\d\d?)\.\s*(?<title>.+?)(?:\t\s*)(?:\t\t)?(?<value>(?<integer>\d{1,3}(?:\.\d{3})*)(?:\s*р\s*(?<decimal>\d\d?) ?к)?)(?<note>\s*\((?:(?!Итого|фактический|\+).)*\))?(?: ?\t\t)?$"#)

        // MARK: no match
        XCTAssertNil("1. Приход товара по накладным\t 753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)".firstMatch(for: Patterns.itemBasic))
        /// item with `math` and `note` after number
        XCTAssertNil("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)"
                        .firstMatch(for: Patterns.itemBasic),
                     "This input should be matched by 'itemMath'")
        XCTAssertNil("2. Эксплуатационные расходы\t-----------------------------\t\t"
                        .firstMatch(for: Patterns.itemBasic),
                     "No number")


        // MARK: count in selectedBodyItems
        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: Patterns.itemBasic) }.count,
                       16, "Should be exactly 16 matchs")

        // MARK: match
        XCTAssertEqual("1.Налоговые платежи \t13.318р93к\t\t".firstMatch(for: Patterns.itemBasic),
                       "1.Налоговые платежи \t13.318р93к\t\t")
        XCTAssertEqual("5. Аренда головного офиса\t11.500".firstMatch(for: Patterns.itemBasic),
                       "5. Аренда головного офиса\t11.500")
        XCTAssertEqual("5. Аренда головного офиса\t11.500\t\t".firstMatch(for: Patterns.itemBasic),
                       "5. Аренда головного офиса\t11.500\t\t")
        XCTAssertEqual("12.Интернет\t3.500\t\t".firstMatch(for: Patterns.itemBasic),
                       "12.Интернет\t3.500\t\t")
        XCTAssertEqual("16. Текущие мелкие расходы \t1.200".firstMatch(for: Patterns.itemBasic),
                       "16. Текущие мелкие расходы \t1.200")
        XCTAssertEqual("14. Контур (эл.отчетность)\t3.000".firstMatch(for: Patterns.itemBasic),
                       "14. Контур (эл.отчетность)\t3.000")
        XCTAssertEqual("14. Контур (эл.отчетность)\t3.000\t\t".firstMatch(for: Patterns.itemBasic),
                       "14. Контур (эл.отчетность)\t3.000\t\t")
        XCTAssertEqual("22. Хэдхантер (подбор пероснала)\t3.240".firstMatch(for: Patterns.itemBasic),
                       "22. Хэдхантер (подбор пероснала)\t3.240")
        XCTAssertEqual("23. Аудит кантора (Бухуслуги)\t60.000".firstMatch(for: Patterns.itemBasic),
                       "23. Аудит кантора (Бухуслуги)\t60.000")
        XCTAssertEqual("14. РПК Ника (крепления д/телевизоров и монтаж)\t30.000".firstMatch(for: Patterns.itemBasic),
                       "14. РПК Ника (крепления д/телевизоров и монтаж)\t30.000")
        XCTAssertEqual("14. РПК Ника (крепления д/телевизоров и монтаж)\t30.000\t\t".firstMatch(for: Patterns.itemBasic),
                       "14. РПК Ника (крепления д/телевизоров и монтаж)\t30.000\t\t")

        XCTAssertEqual("4. Банковская комиссия 1.6% за эквайринг\t2.120".firstMatch(for: Patterns.itemBasic),
                       "4. Банковская комиссия 1.6% за эквайринг\t2.120")
        XCTAssertEqual("4. Банковская комиссия 1.6% за эквайринг\t2.120\t\t".firstMatch(for: Patterns.itemBasic),
                       "4. Банковская комиссия 1.6% за эквайринг\t2.120\t\t")
        XCTAssertEqual("27. Сервис Гуру (система аттестации, за 1 год)\t12.655".firstMatch(for: Patterns.itemBasic),
                       "27. Сервис Гуру (система аттестации, за 1 год)\t12.655")
        XCTAssertEqual("27. Сервис Гуру (система аттестации, за 1 год)\t12.655\t\t".firstMatch(for: Patterns.itemBasic),
                       "27. Сервис Гуру (система аттестации, за 1 год)\t12.655\t\t")
        /// with note
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
        /// have `numbers` inside parentheses (inside note)
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

        /// `ФОТ`
        XCTAssertEqual("1.ФОТ\t 1.064.769( за вторую  часть ноября и первую часть декабря) \t\t"
                        .firstMatch(for: Patterns.itemBasic),
                       "1.ФОТ\t 1.064.769( за вторую  часть ноября и первую часть декабря) \t\t")

        XCTAssertEqual("1.ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)\t\t"
                        .firstMatch(for: Patterns.itemBasic),
                       "1.ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)\t\t")

        XCTAssertEqual("1. ФОТ\t 564.678( за вторую часть октября)"
                        .firstMatch(for: Patterns.itemBasic),
                       "1. ФОТ\t 564.678( за вторую часть октября)")
        XCTAssertEqual("1.ФОТ\t 564.678( за вторую часть октября) \t\t"
                        .firstMatch(for: Patterns.itemBasic),
                       "1.ФОТ\t 564.678( за вторую часть октября) \t\t")

        XCTAssertEqual("1.ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)\t\t"
                        .firstMatch(for: Patterns.itemBasic),
                       "1.ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)\t\t")
        XCTAssertEqual("1.ФОТ\t 894.510( за вторую часть июля и первая часть августа)\t\t"
                        .firstMatch(for: Patterns.itemBasic),
                       "1.ФОТ\t 894.510( за вторую часть июля и первая часть августа)\t\t")
        XCTAssertEqual("1.ФОТ\t 960.056( за вторую часть августа и первую  часть сентября)\t\t"
                        .firstMatch(for: Patterns.itemBasic),
                       "1.ФОТ\t 960.056( за вторую часть августа и первую  часть сентября)\t\t")
        XCTAssertEqual("1.ФОТ\t19.721 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)\t\t"
                        .firstMatch(for: Patterns.itemBasic),
                       "1.ФОТ\t19.721 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)\t\t")

        XCTAssertEqual("1. ФОТ\t595.360 ( за первую часть ноября)"
                        .firstMatch(for: Patterns.itemBasic),
                       "1. ФОТ\t595.360 ( за первую часть ноября)")
        XCTAssertEqual("1.ФОТ\t595.360 ( за первую часть ноября) \t\t"
                        .firstMatch(for: Patterns.itemBasic),
                       "1.ФОТ\t595.360 ( за первую часть ноября) \t\t")

        XCTAssertEqual("1.ФОТ общий\t261.978\t\t"
                        .firstMatch(for: Patterns.itemBasic),
                       "1.ФОТ общий\t261.978\t\t")

        // MARK: regex structure
        XCTAssertEqual("23. Аудит кантора (Бухуслуги)\t60.000"
                        .replaceFirstMatch(for: Patterns.itemBasic, withGroup: "itemNo"), "23")
        XCTAssertEqual("23. Аудит кантора (Бухуслуги)\t60.000"
                        .replaceFirstMatch(for: Patterns.itemBasic, withGroup: "title"), "Аудит кантора (Бухуслуги)")
        XCTAssertEqual("23. Аудит кантора (Бухуслуги)\t60.000"
                        .replaceFirstMatch(for: Patterns.itemBasic, withGroup: "value"), "60.000")
        XCTAssertNil("23. Аудит кантора (Бухуслуги)\t60.000"
                        .replaceFirstMatch(for: Patterns.itemBasic, withGroup: ""))

        XCTAssertEqual("1. ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)"
                        .replaceFirstMatch(for: Patterns.itemBasic, withGroup: "itemNo"), "1")
        XCTAssertEqual("1. ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)"
                        .replaceFirstMatch(for: Patterns.itemBasic, withGroup: "title"), "ФОТ")
        XCTAssertEqual("1. ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)"
                        .replaceFirstMatch(for: Patterns.itemBasic, withGroup: "value"), "1.147.085")
        XCTAssertEqual("1. ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)"
                        .replaceFirstMatch(for: Patterns.itemBasic, withGroup: "note"), "( за вторую часть сентября и первую  часть октября)")

    }
}

extension BodySymbolFuncTests {
    func test_itemBasic() {
        XCTAssertEqual(selectedBodyItems.compactMap { $0.bodySymbol(for: Patterns.itemBasic) }.count,
                       16, "Should be exactly 16 matchs")

        XCTAssertEqual("1.Налоговые платежи \t13.318р93к\t\t".bodySymbol(for: Patterns.itemBasic),
                       .item(itemNumber: 1, title: "Налоговые платежи", value: 13_318.93, note: nil))
        XCTAssertEqual("5. Аренда головного офиса\t11.500".bodySymbol(for: Patterns.itemBasic),
                       .item(itemNumber: 5, title: "Аренда головного офиса", value: 11_500, note: nil))
        XCTAssertEqual("5. Аренда головного офиса\t11.500\t\t".bodySymbol(for: Patterns.itemBasic),
                       .item(itemNumber: 5, title: "Аренда головного офиса", value: 11_500, note: nil))
        XCTAssertEqual("16. Текущие мелкие расходы \t1.200".bodySymbol(for: Patterns.itemBasic),
                       .item(itemNumber: 16, title: "Текущие мелкие расходы", value: 1_200, note: nil))
        XCTAssertEqual("14. Контур (эл.отчетность)\t3.000".bodySymbol(for: Patterns.itemBasic),
                       .item(itemNumber: 14, title: "Контур (эл.отчетность)", value: 3_000, note: nil))
        XCTAssertEqual("22. Хэдхантер (подбор пероснала)\t3.240".bodySymbol(for: Patterns.itemBasic),
                       .item(itemNumber: 22, title: "Хэдхантер (подбор пероснала)", value: 3_240, note: nil))
        XCTAssertEqual("23. Аудит кантора (Бухуслуги)\t60.000".bodySymbol(for: Patterns.itemBasic),
                       .item(itemNumber: 23, title: "Аудит кантора (Бухуслуги)", value: 60_000, note: nil))
        XCTAssertEqual("14. РПК Ника (крепления д/телевизоров и монтаж)\t30.000".bodySymbol(for: Patterns.itemBasic),
                       .item(itemNumber: 14, title: "РПК Ника (крепления д/телевизоров и монтаж)", value: 30_000, note: nil))

        XCTAssertEqual("4. Банковская комиссия 1.6% за эквайринг\t2.120".bodySymbol(for: Patterns.itemBasic),
                       .item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", value: 2_120, note: nil))
        XCTAssertEqual("4. Банковская комиссия 1.6% за эквайринг\t2.120\t\t".bodySymbol(for: Patterns.itemBasic),
                       .item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", value: 2_120, note: nil))
        XCTAssertEqual("12.Интернет\t3.500\t\t".bodySymbol(for: Patterns.itemBasic),
                       .item(itemNumber: 12, title: "Интернет", value: 3_500, note: nil))
        XCTAssertEqual("27. Сервис Гуру (система аттестации, за 1 год)\t12.655".bodySymbol(for: Patterns.itemBasic),
                       .item(itemNumber: 27, title: "Сервис Гуру (система аттестации, за 1 год)", value: 12_655, note: nil))
        XCTAssertEqual("27. Сервис Гуру (система аттестации, за 1 год)\t12.655\t\t".bodySymbol(for: Patterns.itemBasic),
                       .item(itemNumber: 27, title: "Сервис Гуру (система аттестации, за 1 год)", value: 12_655, note: nil))

        /// with note
        XCTAssertEqual("1. Аренда торгового помещения\t46.667 (за июнь)".bodySymbol(for: Patterns.itemBasic),
                       .item(itemNumber: 1, title: "Аренда торгового помещения", value: 46_667, note: "(за июнь)"))
        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за июль)".bodySymbol(for: Patterns.itemBasic),
                       .item(itemNumber: 1, title: "Аренда торгового помещения", value: 200_000, note: "(за июль)"))
        XCTAssertEqual("1. ФОТ\t 564.678( за вторую часть октября)".bodySymbol(for: Patterns.itemBasic),
                       .item(itemNumber: 1, title: "ФОТ", value: 564_678, note: "( за вторую часть октября)"))
        XCTAssertEqual("1. ФОТ\t595.360 ( за первую часть ноября)".bodySymbol(for: Patterns.itemBasic),
                       .item(itemNumber: 1, title: "ФОТ", value: 595_360, note: "( за первую часть ноября)"))
        /// have `numbers` inside parentheses (inside note)
        XCTAssertEqual("1. ФОТ\t19.721 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)".bodySymbol(for: Patterns.itemBasic),
                       .item(itemNumber: 1, title: "ФОТ", value: 19_721, note: "( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"))
        XCTAssertEqual("1. ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)".bodySymbol(for: Patterns.itemBasic),
                       .item(itemNumber: 1, title: "ФОТ", value: 704_848, note: "( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"))
        XCTAssertEqual("1. ФОТ\t 894.510( за вторую часть июля и первая часть августа)".bodySymbol(for: Patterns.itemBasic),
                       .item(itemNumber: 1, title: "ФОТ", value: 894_510, note: "( за вторую часть июля и первая часть августа)"))
        XCTAssertEqual("1. ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)".bodySymbol(for: Patterns.itemBasic),
                       .item(itemNumber: 1, title: "ФОТ", value: 1_147_085, note: "( за вторую часть сентября и первую  часть октября)"))

        // no number
        XCTAssertNil("1. Аренда торгового помещения\t-----------------------------".bodySymbol(for: Patterns.itemBasic),
                       "1. Аренда торгового помещения\t-----------------------------")
        XCTAssertNil("2. Предоплаченный товар, но не отраженный в приходе".bodySymbol(for: Patterns.itemBasic),
                       "2. Предоплаченный товар, но не отраженный в приходе")

        // other
        XCTAssertNil("1. Приход товара по накладным\t 753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)".bodySymbol(for: Patterns.itemBasic))
    }
}
