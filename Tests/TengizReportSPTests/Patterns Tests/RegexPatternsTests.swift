//
//  RegexPatternsTests.swift
//  
//
//  Created by Igor Malyarov on 28.01.2021.
//

import XCTest
@testable import TengizReportSP

final class RegexPatternsTests: XCTestCase {
    func testPatterns() {

        XCTAssertNotNil("Основные расходы:\t\t25%\t\n1. Аренда торгового помещения\t-----------------------------\t\t\n2. Эксплуатационные расходы\t-----------------------------\t\t\n3. Электричество\t-----------------------------\t\t\n4. Водоснабжение\t-----------------------------\t\t\n5. Аренда головного офиса\t11.500\t\t\n6. Аренда головного склада\t-----------------------------\t\t\n7.Вывоз мусора\t-----------------------------\t\t\nИТОГ:\t11.500\t\t"
                            .firstMatch(for:Patterns.body))

        XCTAssertNotNil("Фактический приход товара и оплата товара:\t\t25%\t\n1. Приход товара по накладным\t 739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого-437.474р 47к)\t\t\n2. Предоплаченный товар, но не отраженный в приходе\t--------------\t\t\nИТОГ:\t437.474р47к\t\t"
                            .firstMatch(for:Patterns.body))

        //private static
        let bodyHeader = #"^[А-Яа-я][^\n]*\n"#
        XCTAssertNotNil("Основные расходы:\t\t20%\t\n1".firstMatch(for: bodyHeader))
        XCTAssertNil("14. Вышивка на одежде\t2.836\t\t\n".firstMatch(for: bodyHeader))

        XCTAssertNotNil("Название объекта: Саперави Аминьевка\n"
                            .firstMatch(for:Patterns.bodyHeaderFooterTitle))

        XCTAssertNotNil("Фактический приход товара и оплата товара:\t\t25%\t\n"
                            .firstMatch(for:Patterns.bodyHeaderFooterTitle))

        XCTAssertNotNil("ИТОГ:\t437.474р47к\t\t"
                            .firstMatch(for:Patterns.bodyHeaderFooterTitle))

        //private static
        let itemLine = #"(^\d\d?\..*\n+)"#
        XCTAssertNotNil("1. Аренда торгового помещения\t500.000 (за ноябрь)\t\n"
                            .firstMatch(for: itemLine))

        XCTAssertNotNil("-10.000 за перерасход питание персонала в июле"
                            .firstMatch(for:Patterns.itemCorrectionLine))

        XCTAssertNotNil("1.ФОТ    595.360 ( за первую часть ноября)\t"
                            .firstMatch(for:Patterns.itemTitle))

        XCTAssertNil("5. Аренда головного офиса\t".firstMatch(for:Patterns.itemFullLineWithDigits))
        XCTAssertNotNil("5. Аренда головного офиса\t11.500\t".firstMatch(for:Patterns.itemFullLineWithDigits))

        XCTAssertNotNil("3. Электричество    -----------------------------\t"
                            .firstMatch(for:Patterns.itemFullLineWithoutDigits))

        XCTAssertNotNil("4.Банковская комиссия 1.6% за эквайринг\t\n"
                            .firstMatch(for:Patterns.itemTitleWithPercentage))

        let itemTitleWithPercentagePattern =  #"^[1-9]\d?\.[\D]*\d+(\.\d+)?%[\D]*"#
        XCTAssertNotNil("4.Банковская комиссия 1.6% за эквайринг\t26.915\t"
                            .firstMatch(for: itemTitleWithPercentagePattern))

        XCTAssertNotNil("22. Хэдхантер (подбор пероснала)\t"
                            .firstMatch(for: Patterns.itemTitleWithParentheses))

        XCTAssertNotNil("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)\t\t\n"
                            .firstMatch(for:Patterns.itemWithPlus))

        /// pattern to match `"200.000 (за август) +400.000 (за сентябрь)"` or `"7.701+4.500"`
        XCTAssertNotNil("200.000 (за август) +400.000 (за сентябрь)"
                            .firstMatch(for:Patterns.numbersWithPlus))
        XCTAssertNotNil("7.701+4.500"
                            .firstMatch(for:Patterns.numbersWithPlus))
        XCTAssertNotNil("7.701+4.500+12.400"
                            .firstMatch(for:Patterns.numbersWithPlus))

        XCTAssertNotNil("4.Банковская комиссия 1.6% за эквайринг\t12.111\t\t\n"
                            .firstMatch(for:Patterns.percentage))

        // pattern to match numbers without rubliKopeiki
        XCTAssertNotNil("23. Аудит кантора (Бухуслуги)\t60.000\t\t\n".firstMatch(for:Patterns.itemNumber))
        XCTAssertNotNil("\tПереходит минус с сентября 642.997р 43к\t\t\n".firstMatch(for:Patterns.rubliKopeiki))
        XCTAssertNotNil("\tПереходит минус с сентября 642.997р 43к\t\t\n".firstMatch(for:Patterns.kopeiki))

        XCTAssertNotNil("Минус".firstMatch(for:Patterns.minus))
        XCTAssertNotNil("минус".firstMatch(for:Patterns.minus))
        XCTAssertNotNil("-2".firstMatch(for:Patterns.minus))
        XCTAssertNil("- ".firstMatch(for:Patterns.minus))

    }
}
