//
//  HeaderSymbolPatternsTests.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 29.01.2021.
//

import XCTest
@testable import Model

final class HeaderSymbolPatternsTests: XCTestCase {
    func test_headerItemTitle() {
        XCTAssertEqual("Название объекта: Саперави Аминьевка\nМесяц: июнь2020 (с 24 по 30 июня)\tОборот:266.285\tСредний показатель: 38.040\n\n"
                        .firstMatch(for: Patterns.headerItemTitle),
                       "Название объекта")
        XCTAssertEqual("Месяц: июнь2020 (с 24 по 30 июня)\tОборот:266.285\tСредний показатель: 38.040\n\n"
                        .firstMatch(for: Patterns.headerItemTitle),
                       "Месяц")
        XCTAssertEqual("Оборот:266.285\tСредний показатель: 38.040\n\n"
                        .firstMatch(for: Patterns.headerItemTitle),
                       "Оборот")
        XCTAssertEqual("Средний показатель: 38.040\n\n"
                        .firstMatch(for: Patterns.headerItemTitle),
                       "Средний показатель")
    }

    func test_headerItem() {
        XCTAssertEqual("Название объекта: Саперави Аминьевка\nМесяц: июнь2020 (с 24 по 30 июня)\tОборот:266.285\tСредний показатель: 38.040\n\n"
                        .firstMatch(for: Patterns.headerItem),
                       "Месяц: июнь2020")
        XCTAssertEqual("Месяц: июнь2020 (с 24 по 30 июня)\tОборот:266.285\tСредний показатель: 38.040\n\n"
                        .firstMatch(for: Patterns.headerItem),
                       "Месяц: июнь2020")
        XCTAssertEqual("Оборот:266.285\tСредний показатель: 38.040\n\n"
                        .firstMatch(for: Patterns.headerItem),
                       "Оборот:266.285")
        XCTAssertEqual("Средний показатель: 38.040\n\n"
                        .firstMatch(for: Patterns.headerItem),
                       "Средний показатель: 38.040")

    }

    func test_headerCompany() {
        XCTAssertEqual("Название объекта: Саперави Аминьевка\nМесяц: июнь2020 (с 24 по 30 июня)\tОборот:266.285\tСредний показатель: 38.040\n\n"
                        .firstMatch(for: Patterns.headerCompany),
                       "Саперави Аминьевка")
        XCTAssertEqual("Название объекта: Саперави Аминьевка\n"
                        .firstMatch(for: Patterns.headerCompany),
                       "Саперави Аминьевка")
        XCTAssertEqual("""
                     Название объекта: Вай Мэ! Щелково
            Декабрь2020    Оборот факт:929.625    Средний показатель:29.987

            Статья расхода:    Сумма расхода:    План %    Факт %
            """.firstMatch(for: Patterns.headerCompany),
                       "Вай Мэ! Щелково")
    }

    func test_headerMonth() {
        XCTAssertEqual("Месяц: июнь2020 (с 24 по"
                        .firstMatch(for: Patterns.headerMonth),
                       "Месяц: июнь2020 (с 24 по")
        XCTAssertEqual("июнь2020".firstMatch(for: Patterns.headerMonth),
                       "июнь2020")

        // fail
        XCTAssertNotEqual("Название объекта: Саперави Аминьевка\nМесяц: июнь2020 (с 24 по"
                        .firstMatch(for: Patterns.headerMonth),
                       "июнь2020 (с 24 по 30 июня)")

    }

    func test_revenue() {
        XCTAssertEqual("Оборот фактический".firstMatch(for: Patterns.revenue), "Оборот")
        XCTAssertEqual("Оборот факт:141.690+1.238.900=1.380.590".firstMatch(for: Patterns.revenue),
                       "Оборот")

        XCTAssertNil("Выручка".firstMatch(for: Patterns.revenue))
    }

    func test_dailyAverage() {
        XCTAssertEqual("Средний показатель за месяц".firstMatch(for: Patterns.dailyAverage), "Средний показатель")
        XCTAssertNil("Средний за месяц".firstMatch(for: Patterns.dailyAverage))
    }
}
