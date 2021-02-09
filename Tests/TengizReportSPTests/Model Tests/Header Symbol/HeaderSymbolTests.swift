//
//  HeaderSymbolTests.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 29.01.2021.
//

import XCTest
@testable import TengizReportSP

extension HeaderSymbol {
    init(_ string: String) {
        self.init(stringLiteral: string)
    }
}

final class HeaderSymbolTests: XCTestCase {
    func testHeaderSymbolExpressibleByStringLiteral() {
        XCTAssertEqual(HeaderSymbol("Название объекта: Саперави Аминьевка"), .company(name: "Саперави Аминьевка"))
        XCTAssertEqual(HeaderSymbol("Месяц: июнь2020 (с 24 по 30 июня)"), .month(monthStr: "июнь2020"))
        XCTAssertEqual(HeaderSymbol("Месяц: июль2020"), .month(monthStr: "июль2020"))
        XCTAssertEqual(HeaderSymbol("Оборот:266.285\tСредний показатель: 38.040\n\n"), .revenue(266_285))
        XCTAssertEqual(HeaderSymbol("Средний показатель: 38.040\n\n"), .dailyAverage(38_040))
    }

    func testHeaderSymbol_company() {
        XCTAssertEqual("Название объекта: Саперави Аминьевка".company(), .company(name: "Саперави Аминьевка"))
        XCTAssertEqual("Название объекта: Вай Мэ! Щелково".company(), .company(name: "Вай Мэ! Щелково"))

        XCTAssertEqual(HeaderSymbol("Название объекта: Саперави Аминьевка"), .company(name: "Саперави Аминьевка"))
        XCTAssertEqual(HeaderSymbol("Название объекта: Вай Мэ! Щелково"), .company(name: "Вай Мэ! Щелково"))
    }

    func testHeaderSymbol_month() {
        XCTAssertEqual("Месяц: июнь2020 (с 24 по 30 июня)".month(), .month(monthStr: "июнь2020"))
        XCTAssertEqual("Месяц: июль2020".month(), .month(monthStr: "июль2020"))
        XCTAssertEqual("Месяц: август2020".month(), .month(monthStr: "август2020"))
        XCTAssertEqual("Месяц: сентябрь2020".month(), .month(monthStr: "сентябрь2020"))
        XCTAssertEqual("Октябрь2020".month(), .month(monthStr: "Октябрь2020"))
        XCTAssertEqual("Ноябрь2020".month(), .month(monthStr: "Ноябрь2020"))
        XCTAssertEqual("Декабрь2020".month(), .month(monthStr: "Декабрь2020"))
        XCTAssertEqual("Октябрь+Ноябрь2020".month(), .month(monthStr: "Ноябрь2020"))
        XCTAssertEqual("Декабрь2020".month(), .month(monthStr: "Декабрь2020"))

        XCTAssertEqual(HeaderSymbol("Месяц: июнь2020 (с 24 по 30 июня)"), .month(monthStr: "июнь2020"))
        XCTAssertEqual(HeaderSymbol("Месяц: июль2020"), .month(monthStr: "июль2020"))
        XCTAssertEqual(HeaderSymbol("Месяц: август2020"), .month(monthStr: "август2020"))
        XCTAssertEqual(HeaderSymbol("Месяц: сентябрь2020"), .month(monthStr: "сентябрь2020"))
        XCTAssertEqual(HeaderSymbol("Октябрь2020"), .month(monthStr: "Октябрь2020"))
        XCTAssertEqual(HeaderSymbol("Ноябрь2020"), .month(monthStr: "Ноябрь2020"))
        XCTAssertEqual(HeaderSymbol("Декабрь2020"), .month(monthStr: "Декабрь2020"))
        XCTAssertEqual(HeaderSymbol("Октябрь+Ноябрь2020"), .month(monthStr: "Ноябрь2020"))
        XCTAssertEqual(HeaderSymbol("Декабрь2020"), .month(monthStr: "Декабрь2020"))
    }

    func testHeaderSymbol_revenue() {
        XCTAssertNil("Выручка:266.285".revenue(), "Match should be for '\(Patterns.revenue)'")

        XCTAssertEqual("Оборот:266.285".revenue(), .revenue(266_285))
        XCTAssertEqual("Оборот:1.067.807".revenue(), .revenue(1_067_807))
        XCTAssertEqual("Оборот:1.738.788".revenue(), .revenue(1_738_788))
        XCTAssertEqual("Оборот:2.440.021".revenue(), .revenue(2_440_021))
        XCTAssertEqual("Оборот:2.587.735".revenue(), .revenue(2_587_735))
        XCTAssertEqual("Оборот:1.885.280".revenue(), .revenue(1_885_280))
        XCTAssertEqual("Оборот:2.318.274".revenue(), .revenue(2_318_274))
        XCTAssertEqual("Оборот факт:141.690+1.238.900=1.380.590".revenue(), .revenue(1_380_590))
        XCTAssertEqual("Оборот факт:929.625".revenue(), .revenue(929_625))

        XCTAssertEqual(HeaderSymbol("Оборот:266.285"), .revenue(266_285))
        XCTAssertEqual(HeaderSymbol("Оборот:1.067.807"), .revenue(1_067_807))
        XCTAssertEqual(HeaderSymbol("Оборот:1.738.788"), .revenue(1_738_788))
        XCTAssertEqual(HeaderSymbol("Оборот:2.440.021"), .revenue(2_440_021))
        XCTAssertEqual(HeaderSymbol("Оборот:2.587.735"), .revenue(2_587_735))
        XCTAssertEqual(HeaderSymbol("Оборот:1.885.280"), .revenue(1_885_280))
        XCTAssertEqual(HeaderSymbol("Оборот:2.318.274"), .revenue(2_318_274))
        XCTAssertEqual(HeaderSymbol("Оборот факт:141.690+1.238.900=1.380.590"), .revenue(1_380_590))
        XCTAssertEqual(HeaderSymbol("Оборот факт:929.625"), .revenue(929_625))
    }

    func testHeaderSymbol_dailyAverage() {
        XCTAssertNil("Средний: 38.040".dailyAverage(), "Match should be for '\(Patterns.dailyAverage)'")

        XCTAssertEqual("Средний показатель: 38.040".dailyAverage(), .dailyAverage(38_040))
        XCTAssertEqual("Средний показатель: 34.445".dailyAverage(), .dailyAverage(34_445))
        XCTAssertEqual("Средний показатель: 56.089".dailyAverage(), .dailyAverage(56_089))
        XCTAssertEqual("Средний показатель: 81.334".dailyAverage(), .dailyAverage(81_334))
        XCTAssertEqual("Средний показатель: 83.475".dailyAverage(), .dailyAverage(83_475))
        XCTAssertEqual("Средний показатель: 62.842".dailyAverage(), .dailyAverage(62_842))
        XCTAssertEqual("Средний показатель: 74.783".dailyAverage(), .dailyAverage(74_783))
        XCTAssertEqual("Средний показатель:41.836".dailyAverage(), .dailyAverage(41_836))
        XCTAssertEqual("Средний показатель:29.987".dailyAverage(), .dailyAverage(29_987))

        XCTAssertEqual(HeaderSymbol("Средний показатель: 38.040"), .dailyAverage(38_040))
        XCTAssertEqual(HeaderSymbol("Средний показатель: 34.445"), .dailyAverage(34_445))
        XCTAssertEqual(HeaderSymbol("Средний показатель: 56.089"), .dailyAverage(56_089))
        XCTAssertEqual(HeaderSymbol("Средний показатель: 81.334"), .dailyAverage(81_334))
        XCTAssertEqual(HeaderSymbol("Средний показатель: 83.475"), .dailyAverage(83_475))
        XCTAssertEqual(HeaderSymbol("Средний показатель: 62.842"), .dailyAverage(62_842))
        XCTAssertEqual(HeaderSymbol("Средний показатель: 74.783"), .dailyAverage(74_783))
        XCTAssertEqual(HeaderSymbol("Средний показатель:41.836"), .dailyAverage(41_836))
        XCTAssertEqual(HeaderSymbol("Средний показатель:29.987"), .dailyAverage(29_987))
    }
}

