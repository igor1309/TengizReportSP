//
//  BodySymbolTests.swift
//  TengizReportSPM
//
//  Created by Igor Malyarov on 30.01.2021.
//

import XCTest
@testable import TengizReportSP

extension BodySymbol {
    init(_ string: String) {
        self.init(stringLiteral: string)
    }
}

final class BodySymbolTests: XCTestCase {
    func testBodySymbolExpressibleByStringLiteral() {
        XCTAssertEqual(BodySymbol(""), .empty)
        XCTAssertEqual(BodySymbol("5. Аренда головного офиса\t11.500"),
                       .item(title: "5. Аренда головного офиса", value: 11500.0, comment: nil))
    }

    func test_BodySymbol_init() {
        XCTAssertEqual(BodySymbol("fhgsfdghb"), .empty)
        XCTAssertEqual(BodySymbol("62384"), .empty)
        XCTAssertEqual(BodySymbol("684"), .empty)
        XCTAssertEqual(BodySymbol("sdf684"), .empty)

        let symbols = selectedBodyItems.map { BodySymbol($0) }
        XCTAssertEqual(symbols.count, 34)
        let nonEmptySymbols = symbols.filter { $0 != .empty }
        XCTAssertEqual(nonEmptySymbols.count, 32, "selectedBodyItems count is 34, just 2 of them are empty")

        // selectedBodyItems
        /// `correction`, doesn't start with digits
        XCTAssertEqual(BodySymbol("-10.000 за перерасход питание персонала в июле"),
                       .item(title: "за перерасход питание персонала в июле", value: -10_000, comment: nil))

        /// `itemNoNumber`: title without number, should return .empty
        XCTAssertEqual(BodySymbol("1. Аренда торгового помещения\t-----------------------------"), .empty)
        XCTAssertEqual(BodySymbol("2. Предоплаченный товар, но не отраженный в приходе"), .empty)

        /// `itemBasic`: no itogo, no number inside parantheses, no %, no comment after number
        XCTAssertEqual(BodySymbol("5. Аренда головного офиса\t11.500"),
                       .item(title: "5. Аренда головного офиса", value: 11_500, comment: nil))
        XCTAssertEqual(BodySymbol("16. Текущие мелкие расходы \t1.200"),
                       .item(title: "16. Текущие мелкие расходы", value: 1_200, comment: nil))
        /// item with `parentheses` in item title
        XCTAssertEqual(BodySymbol("14. Контур (эл.отчетность)\t3.000"),
                       .item(title: "14. Контур (эл.отчетность)", value: 3_000, comment: nil))
        XCTAssertEqual(BodySymbol("22. Хэдхантер (подбор пероснала)\t3.240"),
                       .item(title: "22. Хэдхантер (подбор пероснала)", value: 3_240, comment: nil))
        XCTAssertEqual(BodySymbol("23. Аудит кантора (Бухуслуги)\t60.000"),
                       .item(title: "23. Аудит кантора (Бухуслуги)", value: 60_000, comment: nil))
        XCTAssertEqual(BodySymbol("14. РПК Ника (крепления д/телевизоров и монтаж)\t30.000"),
                       .item(title: "14. РПК Ника (крепления д/телевизоров и монтаж)", value: 30_000, comment: nil))

        /// `itemMath`
        XCTAssertEqual(BodySymbol("12. Интернет\t7.701+4.500"),
                       .item(title: "12. Интернет", value: 12_201, comment: "7.701+4.500"))
        XCTAssertEqual(BodySymbol("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995"),
                       .item(title: "6. Обслуживание кассовой программы Айко", value: 4_500 + 8_700 + 15_995, comment: "4.500+8.700+15.995"))
        /// item with `math` and `comment` after number
        XCTAssertEqual(BodySymbol("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)"),
                       .item(title: "1. Аренда торгового помещения", value: 600_000, comment: "200.000 (за август) +400.000 (за сентябрь)"))

        /// item with digits and `percentage` inside item title
        XCTAssertEqual(BodySymbol("4. Банковская комиссия 1.6% за эквайринг\t2.120"),
                       .item(title: "4. Банковская комиссия 1.6% за эквайринг", value: 2_120, comment: nil))

        /// `itemNumberInsideParentheses`: item with number inside parentheses
        XCTAssertEqual(BodySymbol("27. Сервис Гуру (система аттестации, за 1 год)\t12.655"),
                       .item(title: "27. Сервис Гуру (система аттестации, за 1 год)", value: 12_655, comment: nil))

        /// `itemWithComment` item with `comment` after number, floating whitespace
        XCTAssertEqual(BodySymbol("1. Аренда торгового помещения\t46.667 (за июнь)"),
                       .item(title: "1. Аренда торгового помещения", value: 46_667, comment: "(за июнь)"))
        XCTAssertEqual(BodySymbol("1. Аренда торгового помещения\t 200.000 (за июль)"),
                       .item(title: "1. Аренда торгового помещения", value: 200_000, comment: "(за июль)"))
        XCTAssertEqual(BodySymbol("1. ФОТ\t 564.678( за вторую часть октября)"),
                       .item(title: "1. ФОТ", value: 564_678, comment: "( за вторую часть октября)"))
        XCTAssertEqual(BodySymbol("1. ФОТ\t595.360 ( за первую часть ноября)"),
                       .item(title: "1. ФОТ", value: 595_360, comment: "( за первую часть ноября)"))
        /// have `numbers` inside parentheses (inside comment)
        XCTAssertEqual(BodySymbol("1. ФОТ\t19.721 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"),
                       .item(title: "1. ФОТ", value: 19_721, comment: "( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"))
        XCTAssertEqual(BodySymbol("1. ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"),
                       .item(title: "1. ФОТ", value: 704_848, comment: "( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"))
        XCTAssertEqual(BodySymbol("1. ФОТ\t 894.510( за вторую часть июля и первая часть августа)"),
                       .item(title: "1. ФОТ", value: 894_510, comment: "( за вторую часть июля и первая часть августа)"))
        XCTAssertEqual(BodySymbol("1. ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)"),
                       .item(title: "1. ФОТ", value: 1_147_085, comment: "( за вторую часть сентября и первую  часть октября)"))

        /// `itogo`
        /// due to .replaceMatches(for: "Студиопак-", withString: "Студиопак Итого ") in func clearReport()
        XCTAssertEqual(BodySymbol("2. Предоплаченный товар, но не отраженный в приходе\tСтудиопак Итого 12.500 (влажные салфетки);"),
                       .item(title: "2. Предоплаченный товар, но не отраженный в приходе", value: 12_500, comment: "Студиопак Итого 12.500 (влажные салфетки);"))
        XCTAssertEqual(BodySymbol("1. Приход товара по накладным\t922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)"),
                       .item(title: "1. Приход товара по накладным", value: 498_373.46, comment: "922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)"))
        XCTAssertEqual(BodySymbol("1. Приход товара по накладным\t 753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)"),
                       .item(title: "1. Приход товара по накладным", value: 521_519.36, comment: "753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)"))
        XCTAssertEqual(BodySymbol("1. Приход товара по накладным\t 946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)"),
                       .item(title: "1. Приход товара по накладным", value: 632_684.37, comment: "946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)"))
        XCTAssertEqual(BodySymbol("1. Приход товара по накладным\t 907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)"),
                       .item(title: "1. Приход товара по накладным", value: 628_215.74, comment: "907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)"))
        XCTAssertEqual(BodySymbol("1. Приход товара по накладным\t 739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого 437.474р 47к)"),
                       .item(title: "1. Приход товара по накладным", value: 437_474.47, comment: "739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого 437.474р 47к)"))
        XCTAssertEqual(BodySymbol("1. Приход товара по накладным\t 997.446р; (оплаты фактические: 491.114р 65к -переводы; 114.589 -корпоративная карта; 12.170 -наличные из кассы; Итого 617.873р 65к)"),
                       .item(title: "1. Приход товара по накладным", value: 617_873.65, comment: "997.446р; (оплаты фактические: 491.114р 65к -переводы; 114.589 -корпоративная карта; 12.170 -наличные из кассы; Итого 617.873р 65к)"))
        XCTAssertEqual(BodySymbol("1. Приход товара по накладным\t179.108р 89к+512.293р(оплаты фактические:199.803р 80к-переводы;81.225р 35к-корпоративная карта;34.202р-наличные из кассы; Итого 315.231р 15к)"),
                       .item(title: "1. Приход товара по накладным", value: 315_231.15, comment: "179.108р 89к+512.293р(оплаты фактические:199.803р 80к-переводы;81.225р 35к-корпоративная карта;34.202р-наличные из кассы; Итого 315.231р 15к)"))
        XCTAssertEqual(BodySymbol("1. Приход товара по накладным\t473.128р 43к(оплаты фактические:231.572р 46к-переводы;51.104р 93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р 39к)"),
                       .item(title: "1. Приход товара по накладным", value: 285_476.39, comment: "473.128р 43к(оплаты фактические:231.572р 46к-переводы;51.104р 93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р 39к)"))
        /// regex: `фактический` or `Итого`
        XCTAssertEqual(BodySymbol("1. Приход товара по накладным\t451.198р 41к (из них у нас оплачено фактический 21.346р 15к)"),
                       .item(title: "1. Приход товара по накладным", value: 21_346.15, comment: "451.198р 41к (из них у нас оплачено фактический 21.346р 15к)"))
        /// ex itogo2
        XCTAssertEqual(BodySymbol("2. Предоплаченный товар, но не отраженный в приходе\t КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого 23.600"),
                       .item(title: "2. Предоплаченный товар, но не отраженный в приходе", value: 23_600, comment: "КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого 23.600"))
        XCTAssertEqual(BodySymbol("2. Предоплаченный товар, но не отраженный в приходе\tБейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400"),
                       .item(title: "2. Предоплаченный товар, но не отраженный в приходе", value: 40_400, comment: "Бейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400"))
    }

}
