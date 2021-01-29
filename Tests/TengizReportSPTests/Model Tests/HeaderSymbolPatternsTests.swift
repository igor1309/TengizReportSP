//
//  HeaderSymbolPatternsTests.swift
//  TengizReportSPM
//
//  Created by Igor Malyarov on 29.01.2021.
//

import XCTest
@testable import TengizReportSP

final class HeaderSymbolPatternsTests: XCTestCase {
    func testHeaderItemTitlePattern() {
        XCTAssertEqual("Название объекта: Саперави Аминьевка\nМесяц: июнь2020 (с 24 по 30 июня)\tОборот:266.285\tСредний показатель: 38.040\n\n"
                        .firstMatch(for: Patterns.headerItemTitlePattern),
                       "Название объекта")
        XCTAssertEqual("Месяц: июнь2020 (с 24 по 30 июня)\tОборот:266.285\tСредний показатель: 38.040\n\n"
                        .firstMatch(for: Patterns.headerItemTitlePattern),
                       "Месяц")
        XCTAssertEqual("Оборот:266.285\tСредний показатель: 38.040\n\n"
                        .firstMatch(for: Patterns.headerItemTitlePattern),
                       "Оборот")
        XCTAssertEqual("Средний показатель: 38.040\n\n"
                        .firstMatch(for: Patterns.headerItemTitlePattern),
                       "Средний показатель")
    }

    func testHeaderItemPattern() {
        XCTAssertEqual("Название объекта: Саперави Аминьевка\nМесяц: июнь2020 (с 24 по 30 июня)\tОборот:266.285\tСредний показатель: 38.040\n\n"
                        .firstMatch(for: Patterns.headerItemPattern),
                       "Месяц: июнь2020")
        XCTAssertEqual("Месяц: июнь2020 (с 24 по 30 июня)\tОборот:266.285\tСредний показатель: 38.040\n\n"
                        .firstMatch(for: Patterns.headerItemPattern),
                       "Месяц: июнь2020")
        XCTAssertEqual("Оборот:266.285\tСредний показатель: 38.040\n\n"
                        .firstMatch(for: Patterns.headerItemPattern),
                       "Оборот:266.285")
        XCTAssertEqual("Средний показатель: 38.040\n\n"
                        .firstMatch(for: Patterns.headerItemPattern),
                       "Средний показатель: 38.040")

    }

    func testHeaderCompanyPattern() {
        XCTAssertEqual("Название объекта: Саперави Аминьевка\nМесяц: июнь2020 (с 24 по 30 июня)\tОборот:266.285\tСредний показатель: 38.040\n\n"
                        .firstMatch(for: Patterns.headerCompanyPattern),
                       "Саперави Аминьевка")
        XCTAssertEqual("Название объекта: Саперави Аминьевка\n"
                        .firstMatch(for: Patterns.headerCompanyPattern),
                       "Саперави Аминьевка")
        XCTAssertEqual("""
                     Название объекта: Вай Мэ! Щелково
            Декабрь2020    Оборот факт:929.625    Средний показатель:29.987

            Статья расхода:    Сумма расхода:    План %    Факт %
            """.firstMatch(for: Patterns.headerCompanyPattern),
                       "Вай Мэ! Щелково")
    }

    func testHeaderMonthPattern() {
        XCTAssertEqual("Название объекта: Саперави Аминьевка\nМесяц: июнь2020 (с 24 по"
                        .firstMatch(for: Patterns.headerMonthPattern),
                       "июнь2020")
        XCTAssertEqual("Месяц: июнь2020 (с 24 по"
                        .firstMatch(for: Patterns.headerMonthPattern),
                       "июнь2020")
        XCTAssertEqual("июнь2020".firstMatch(for: Patterns.headerMonthPattern),
                       "июнь2020")

    }
}
