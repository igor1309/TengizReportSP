//
//  BodySymbolTests.swift
//  TengizReportSPTests
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
                       .item(itemNumber: 5, title: "Аренда головного офиса", value: 11500.0, note: nil))
    }

    func test_BodySymbol_init_items() {
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
                       .item(itemNumber: 0, title: "Correction", value: -10_000, note: "-10.000 за перерасход питание персонала в июле"))

        /// `itemNoNumber`: title without number, should return .empty
        XCTAssertEqual(BodySymbol("1. Аренда торгового помещения\t-----------------------------"), .empty)
        XCTAssertEqual(BodySymbol("2. Эксплуатационные расходы\t-----------------------------\t\t"), .empty)
        XCTAssertEqual(BodySymbol("2. Предоплаченный товар, но не отраженный в приходе"), .empty)
        XCTAssertEqual(BodySymbol("2. Предоплаченный товар, но не отраженный в приходе\t\t\t"), .empty)

        /// `itemBasic`: no itogo, no number inside parantheses, no %, no note after number
        XCTAssertEqual(BodySymbol("1.Налоговые платежи \t13.318р93к\t\t"),
                       .item(itemNumber: 1, title: "Налоговые платежи", value: 13_318.93, note: nil))

        XCTAssertEqual(BodySymbol("5. Аренда головного офиса\t11.500"),
                       .item(itemNumber: 5, title: "Аренда головного офиса", value: 11_500, note: nil))
        XCTAssertEqual(BodySymbol("5. Аренда головного офиса\t11.500\t\t"),
                       .item(itemNumber: 5, title: "Аренда головного офиса", value: 11_500, note: nil))
        XCTAssertEqual(BodySymbol("16. Текущие мелкие расходы \t1.200"),
                       .item(itemNumber: 16, title: "Текущие мелкие расходы", value: 1_200, note: nil))
        /// item with `parentheses` in item title
        XCTAssertEqual(BodySymbol("14. Контур (эл.отчетность)\t3.000"),
                       .item(itemNumber: 14, title: "Контур (эл.отчетность)", value: 3_000, note: nil))
        XCTAssertEqual(BodySymbol("22. Хэдхантер (подбор пероснала)\t3.240"),
                       .item(itemNumber: 22, title: "Хэдхантер (подбор пероснала)", value: 3_240, note: nil))
        XCTAssertEqual(BodySymbol("23. Аудит кантора (Бухуслуги)\t60.000"),
                       .item(itemNumber: 23, title: "Аудит кантора (Бухуслуги)", value: 60_000, note: nil))
        XCTAssertEqual(BodySymbol("14. РПК Ника (крепления д/телевизоров и монтаж)\t30.000"),
                       .item(itemNumber: 14, title: "РПК Ника (крепления д/телевизоров и монтаж)", value: 30_000, note: nil))

        /// `itemMath`
        XCTAssertEqual(BodySymbol("12.Интернет\t7.701+4.500\t\t"),
                       .item(itemNumber: 12, title: "Интернет", value: 12_201, note: "7.701+4.500"))
        XCTAssertEqual(BodySymbol("12. Интернет\t7.701+4.500"),
                       .item(itemNumber: 12, title: "Интернет", value: 12_201, note: "7.701+4.500"))
        XCTAssertEqual(BodySymbol("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995"),
                       .item(itemNumber: 6, title: "Обслуживание кассовой программы Айко", value: 4_500 + 8_700 + 15_995, note: "4.500+8.700+15.995"))
        /// item with `math` and `note` after number
        XCTAssertEqual(BodySymbol("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)"),
                       .item(itemNumber: 1, title: "Аренда торгового помещения", value: 600_000, note: "200.000 (за август) +400.000 (за сентябрь)"))

        /// item with digits and `percentage` inside item title
        XCTAssertEqual(BodySymbol("4. Банковская комиссия 1.6% за эквайринг\t2.120"),
                       .item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", value: 2_120, note: nil))

        /// `itemNumberInsideParentheses`: item with number inside parentheses
        XCTAssertEqual(BodySymbol("27. Сервис Гуру (система аттестации, за 1 год)\t12.655"),
                       .item(itemNumber: 27, title: "Сервис Гуру (система аттестации, за 1 год)", value: 12_655, note: nil))

        /// `itemWithComment` item with `note` after number, floating whitespace
        XCTAssertEqual(BodySymbol("1. Аренда торгового помещения\t46.667 (за июнь)"),
                       .item(itemNumber: 1, title: "Аренда торгового помещения", value: 46_667, note: "(за июнь)"))
        XCTAssertEqual(BodySymbol("1. Аренда торгового помещения\t 200.000 (за июль)"),
                       .item(itemNumber: 1, title: "Аренда торгового помещения", value: 200_000, note: "(за июль)"))

        /// `ФОТ`
        XCTAssertEqual(BodySymbol("1.ФОТ\t 1.064.769( за вторую  часть ноября и первую часть декабря) \t\t"),
                       .item(itemNumber: 1, title: "ФОТ", value: 1_064_769, note: "( за вторую  часть ноября и первую часть декабря)"))

        XCTAssertEqual(BodySymbol("1.ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)\t\t"),
                       .item(itemNumber: 1, title: "ФОТ", value: 1_147_085, note: "( за вторую часть сентября и первую  часть октября)"))

        XCTAssertEqual(BodySymbol("1. ФОТ\t 564.678( за вторую часть октября)"),
                       .item(itemNumber: 1, title: "ФОТ", value: 564_678, note: "( за вторую часть октября)"))
        XCTAssertEqual(BodySymbol("1.ФОТ\t 564.678( за вторую часть октября) \t\t"),
                       .item(itemNumber: 1, title: "ФОТ", value: 564_678, note: "( за вторую часть октября)"))

        XCTAssertEqual(BodySymbol("1.ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)\t\t"),
                       .item(itemNumber: 1, title: "ФОТ", value: 704_848, note: "( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"))
        XCTAssertEqual(BodySymbol("1.ФОТ\t 894.510( за вторую часть июля и первая часть августа)\t\t"),
                       .item(itemNumber: 1, title: "ФОТ", value: 894_510, note: "( за вторую часть июля и первая часть августа)"))
        XCTAssertEqual(BodySymbol("1.ФОТ\t 960.056( за вторую часть августа и первую  часть сентября)\t\t"),
                       .item(itemNumber: 1, title: "ФОТ", value: 960_056, note: "( за вторую часть августа и первую  часть сентября)"))
        XCTAssertEqual(BodySymbol("1.ФОТ\t19.721 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)\t\t"),
                       .item(itemNumber: 1, title: "ФОТ", value: 19_721, note: "( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"))

        XCTAssertEqual(BodySymbol("1. ФОТ\t595.360 ( за первую часть ноября)"),
                       .item(itemNumber: 1, title: "ФОТ", value: 595_360, note: "( за первую часть ноября)"))
        XCTAssertEqual(BodySymbol("1.ФОТ\t595.360 ( за первую часть ноября) \t\t"),
                       .item(itemNumber: 1, title: "ФОТ", value: 595_360, note: "( за первую часть ноября)"))

        XCTAssertEqual(BodySymbol("1.ФОТ общий\t261.978\t\t"),
                       .item(itemNumber: 1, title: "ФОТ общий", value: 261_978, note: nil))



        /// have `numbers` inside parentheses (inside note)
        XCTAssertEqual(BodySymbol("1. ФОТ\t19.721 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"),
                       .item(itemNumber: 1, title: "ФОТ", value: 19_721, note: "( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"))
        XCTAssertEqual(BodySymbol("1. ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"),
                       .item(itemNumber: 1, title: "ФОТ", value: 704_848, note: "( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"))
        XCTAssertEqual(BodySymbol("1. ФОТ\t 894.510( за вторую часть июля и первая часть августа)"),
                       .item(itemNumber: 1, title: "ФОТ", value: 894_510, note: "( за вторую часть июля и первая часть августа)"))
        XCTAssertEqual(BodySymbol("1. ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)"),
                       .item(itemNumber: 1, title: "ФОТ", value: 1_147_085, note: "( за вторую часть сентября и первую  часть октября)"))

        /// `itogo`
        /// due to .replaceMatches(for: "Студиопак-", withString: "Студиопак Итого ") in func clearReport()
        XCTAssertEqual(BodySymbol("2. Предоплаченный товар, но не отраженный в приходе\tСтудиопак Итого 12.500 (влажные салфетки);"),
                       .item(itemNumber: 2, title: "Предоплаченный товар, но не отраженный в приходе", value: 12_500, note: "Студиопак Итого 12.500 (влажные салфетки);"))

        XCTAssertEqual(BodySymbol("1. Приход товара по накладным\t922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)"),
                       .item(itemNumber: 1, title: "Приход товара по накладным", value: 498_373.46, note: "922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)"))

        XCTAssertEqual(BodySymbol("1. Приход товара по накладным\t 753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)"),
                       .item(itemNumber: 1, title: "Приход товара по накладным", value: 521_519.36, note: "753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)"))
        XCTAssertEqual(BodySymbol("1. Приход товара по накладным\t 946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)"),
                       .item(itemNumber: 1, title: "Приход товара по накладным", value: 632_684.37, note: "946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)"))
        XCTAssertEqual(BodySymbol("1. Приход товара по накладным\t 907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)"),
                       .item(itemNumber: 1, title: "Приход товара по накладным", value: 628_215.74, note: "907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)"))
        XCTAssertEqual(BodySymbol("1. Приход товара по накладным\t 739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого 437.474р 47к)"),
                       .item(itemNumber: 1, title: "Приход товара по накладным", value: 437_474.47, note: "739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого 437.474р 47к)"))
        XCTAssertEqual(BodySymbol("1. Приход товара по накладным\t 997.446р; (оплаты фактические: 491.114р 65к -переводы; 114.589 -корпоративная карта; 12.170 -наличные из кассы; Итого 617.873р 65к)"),
                       .item(itemNumber: 1, title: "Приход товара по накладным", value: 617_873.65, note: "997.446р; (оплаты фактические: 491.114р 65к -переводы; 114.589 -корпоративная карта; 12.170 -наличные из кассы; Итого 617.873р 65к)"))
        XCTAssertEqual(BodySymbol("1. Приход товара по накладным\t179.108р 89к+512.293р(оплаты фактические:199.803р 80к-переводы;81.225р 35к-корпоративная карта;34.202р-наличные из кассы; Итого 315.231р 15к)"),
                       .item(itemNumber: 1, title: "Приход товара по накладным", value: 315_231.15, note: "179.108р 89к+512.293р(оплаты фактические:199.803р 80к-переводы;81.225р 35к-корпоративная карта;34.202р-наличные из кассы; Итого 315.231р 15к)"))
        XCTAssertEqual(BodySymbol("1. Приход товара по накладным\t473.128р 43к(оплаты фактические:231.572р 46к-переводы;51.104р 93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р 39к)"),
                       .item(itemNumber: 1, title: "Приход товара по накладным", value: 285_476.39, note: "473.128р 43к(оплаты фактические:231.572р 46к-переводы;51.104р 93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р 39к)"))
        /// regex: `фактический` or `Итого`
        XCTAssertEqual(BodySymbol("1. Приход товара по накладным\t451.198р 41к (из них у нас оплачено фактический 21.346р 15к)"),
                       .item(itemNumber: 1, title: "Приход товара по накладным", value: 21_346.15, note: "451.198р 41к (из них у нас оплачено фактический 21.346р 15к)"))
        /// ex itogo2
        XCTAssertEqual(BodySymbol("2. Предоплаченный товар, но не отраженный в приходе\t КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого 23.600"),
                       .item(itemNumber: 2, title: "Предоплаченный товар, но не отраженный в приходе", value: 23_600, note: "КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого 23.600"))
        XCTAssertEqual(BodySymbol("2. Предоплаченный товар, но не отраженный в приходе\tБейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400"),
                       .item(itemNumber: 2, title: "Предоплаченный товар, но не отраженный в приходе", value: 40_400, note: "Бейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400"))
    }

    func test_BodySymbol_init_items_special_cases() {
        XCTAssertEqual(BodySymbol("1. Приход товара по накладным\t922.936р37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р46к)"),
                       .item(itemNumber: 1, title: "Приход товара по накладным", value: 498_373.46, note: "922.936р37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р46к)"),
                        "498.373р46к should convert to 498_373.46, not to '498373.0'")

    }

}
