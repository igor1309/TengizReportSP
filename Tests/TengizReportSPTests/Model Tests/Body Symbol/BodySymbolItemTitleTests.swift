//
//  BodySymbolItemTitleTests.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 06.02.2021.
//

import XCTest
@testable import TengizReportSP

final class BodySymbolItemTitleTests: XCTestCase {
    func test_title() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.title, #"(?<title>^.*?)(?:\t\s*)"#)

        // MARK: match
        /// `correction`, doesn't start with digits
        XCTAssertEqual("-10.000 за перерасход питание персонала в июле"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "-10.000 за перерасход питание персонала в июле")

        /// `itemNoNumber`: title without number, should return .empty
        XCTAssertEqual("1. Аренда торгового помещения\t-----------------------------"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "1. Аренда торгового помещения")
        XCTAssertNil("2. Предоплаченный товар, но не отраженный в приходе"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"))

        /// `itemSimple`: no itogo, no number inside parantheses, no %, no comment after number
        XCTAssertEqual("5. Аренда головного офиса\t11.500"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "5. Аренда головного офиса")
        XCTAssertEqual("16. Текущие мелкие расходы \t1.200"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "16. Текущие мелкие расходы ")
        /// item with `parentheses` in item title
        XCTAssertEqual("14. Контур (эл.отчетность)\t3.000"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "14. Контур (эл.отчетность)")
        XCTAssertEqual("22. Хэдхантер (подбор пероснала)\t3.240"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "22. Хэдхантер (подбор пероснала)")
        XCTAssertEqual("23. Аудит кантора (Бухуслуги)\t60.000"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "23. Аудит кантора (Бухуслуги)")
        XCTAssertEqual("14. РПК Ника (крепления д/телевизоров и монтаж)\t30.000"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "14. РПК Ника (крепления д/телевизоров и монтаж)")

        /// `itemMath`
        XCTAssertEqual("12. Интернет\t7.701+4.500"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "12. Интернет")
        XCTAssertEqual("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "6. Обслуживание кассовой программы Айко")
        /// item with `math` and `comment` after number
        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "1. Аренда торгового помещения")

        /// item with digits and `percentage` inside item title
        XCTAssertEqual("4. Банковская комиссия 1.6% за эквайринг\t2.120"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "4. Банковская комиссия 1.6% за эквайринг")

        /// `itemNumberInsideParentheses`: item with number inside parentheses
        XCTAssertEqual("27. Сервис Гуру (система аттестации, за 1 год)\t12.655"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "27. Сервис Гуру (система аттестации, за 1 год)")

        /// `itemWithComment` 8 item with `comment` after number, floating whitespace
        XCTAssertEqual("1. Аренда торгового помещения\t46.667 (за июнь)"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "1. Аренда торгового помещения")
        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за июль)"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "1. Аренда торгового помещения")
        XCTAssertEqual("1. ФОТ\t 564.678( за вторую часть октября)"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "1. ФОТ")
        XCTAssertEqual("1. ФОТ\t595.360 ( за первую часть ноября)"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "1. ФОТ")
        /// have `numbers` inside parentheses (inside comment)
        XCTAssertEqual("1. ФОТ\t19.721 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "1. ФОТ")
        XCTAssertEqual("1. ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "1. ФОТ")
        XCTAssertEqual("1. ФОТ\t 894.510( за вторую часть июля и первая часть августа)"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "1. ФОТ")
        XCTAssertEqual("1. ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "1. ФОТ")

        /// `itogo` 12
        /// due to .replaceMatches(for: "Студиопак-", withString: "Студиопак Итого ") in func clearReport()
        XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе\tСтудиопак Итого 12.500 (влажные салфетки);"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "2. Предоплаченный товар, но не отраженный в приходе")
        XCTAssertEqual("1. Приход товара по накладным\t922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "1. Приход товара по накладным")
        XCTAssertEqual("1. Приход товара по накладным\t 753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "1. Приход товара по накладным")
        XCTAssertEqual("1. Приход товара по накладным\t 946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "1. Приход товара по накладным")
        XCTAssertEqual("1. Приход товара по накладным\t 907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "1. Приход товара по накладным")
        XCTAssertEqual("1. Приход товара по накладным\t 739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого 437.474р 47к)"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "1. Приход товара по накладным")
        XCTAssertEqual("1. Приход товара по накладным\t 997.446р; (оплаты фактические: 491.114р 65к -переводы; 114.589 -корпоративная карта; 12.170 -наличные из кассы; Итого 617.873р 65к)"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "1. Приход товара по накладным")
        XCTAssertEqual("1. Приход товара по накладным\t179.108р 89к+512.293р(оплаты фактические:199.803р 80к-переводы;81.225р 35к-корпоративная карта;34.202р-наличные из кассы; Итого 315.231р 15к)"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "1. Приход товара по накладным")
        XCTAssertEqual("1. Приход товара по накладным\t473.128р 43к(оплаты фактические:231.572р 46к-переводы;51.104р 93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р 39к)"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "1. Приход товара по накладным")
        /// regex: `фактический` or `Итого`
        XCTAssertEqual("1. Приход товара по накладным\t451.198р 41к (из них у нас оплачено фактический 21.346р 15к)"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "1. Приход товара по накладным")
        /// ex itogo2
        XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе\t КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого 23.600"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "2. Предоплаченный товар, но не отраженный в приходе")
        XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе\tБейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400"
                        .replaceFirstMatch(for: Patterns.title, withGroup: "title"),
                       "2. Предоплаченный товар, но не отраженный в приходе")
    }
}
