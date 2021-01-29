//
//  HeaderSymbolTests.swift
//  TengizReportSPM
//
//  Created by Igor Malyarov on 29.01.2021.
//

import XCTest
@testable import TengizReportSP

extension HeaderSymbol {
    public init(_ string: String) {
        self.init(stringLiteral: string)
    }
}

final class HeaderSymbolTests: XCTestCase {
    func testHeaderSymbolFunc() {
        XCTAssertEqual("Название объекта: Саперави Аминьевка".headerSymbol(), .company(name: "Саперави Аминьевка"))
        XCTAssertEqual("Месяц: июнь2020 (с 24 по 30 июня)".headerSymbol(), .month(monthStr: "июнь2020"))
        XCTAssertEqual("Месяц: июль2020".headerSymbol(), .month(monthStr: "июль2020"))
        XCTAssertEqual("Оборот:266.285\tСредний показатель: 38.040\n\n".headerSymbol(), .item(title: "Оборот", value: 266_285))
        XCTAssertEqual("Средний показатель: 38.040\n\n".headerSymbol(), .item(title: "Средний показатель", value: 38_040))
    }

    func testHeaderSymbolExpressibleByStringLiteral() {
        XCTAssertEqual(HeaderSymbol("Название объекта: Саперави Аминьевка"), .company(name: "Саперави Аминьевка"))
        XCTAssertEqual(HeaderSymbol("Месяц: июнь2020 (с 24 по 30 июня)"), .month(monthStr: "июнь2020"))
        XCTAssertEqual(HeaderSymbol("Месяц: июль2020"), .month(monthStr: "июль2020"))
        XCTAssertEqual(HeaderSymbol("Оборот:266.285\tСредний показатель: 38.040\n\n"), .item(title: "Оборот", value: 266_285))
        XCTAssertEqual(HeaderSymbol("Средний показатель: 38.040\n\n"), .item(title: "Средний показатель", value: 38_040))
    }

    func testHeaderSymbolInit() {
        XCTAssertEqual(HeaderSymbol("Название объекта: Саперави Аминьевка"), .company(name: "Саперави Аминьевка"))
        XCTAssertEqual(HeaderSymbol("Название объекта: Вай Мэ! Щелково"), .company(name: "Вай Мэ! Щелково"))

        XCTAssertEqual(HeaderSymbol("Месяц: июнь2020 (с 24 по 30 июня)"), .month(monthStr: "июнь2020"))
        XCTAssertEqual(HeaderSymbol("Месяц: июль2020"), .month(monthStr: "июль2020"))
        XCTAssertEqual(HeaderSymbol("Месяц: август2020"), .month(monthStr: "август2020"))
        XCTAssertEqual(HeaderSymbol("Месяц: сентябрь2020"), .month(monthStr: "сентябрь2020"))
        XCTAssertEqual(HeaderSymbol("Октябрь2020"), .month(monthStr: "Октябрь2020"))
        XCTAssertEqual(HeaderSymbol("Ноябрь2020"), .month(monthStr: "Ноябрь2020"))
        XCTAssertEqual(HeaderSymbol("Декабрь2020"), .month(monthStr: "Декабрь2020"))
        XCTAssertEqual(HeaderSymbol("Октябрь+Ноябрь2020"), .month(monthStr: "Ноябрь2020"))
        XCTAssertEqual(HeaderSymbol("Декабрь2020"), .month(monthStr: "Декабрь2020"))

        XCTAssertEqual(HeaderSymbol("Оборот:266.285"), .item(title: "Оборот", value: 266_285))
        XCTAssertEqual(HeaderSymbol("Оборот:1.067.807"), .item(title: "Оборот", value: 1_067_807))
        XCTAssertEqual(HeaderSymbol("Оборот:1.738.788"), .item(title: "Оборот", value: 1_738_788))
        XCTAssertEqual(HeaderSymbol("Оборот:2.440.021"), .item(title: "Оборот", value: 2_440_021))
        XCTAssertEqual(HeaderSymbol("Оборот:2.587.735"), .item(title: "Оборот", value: 2_587_735))
        XCTAssertEqual(HeaderSymbol("Оборот:1.885.280"), .item(title: "Оборот", value: 1_885_280))
        XCTAssertEqual(HeaderSymbol("Оборот:2.318.274"), .item(title: "Оборот", value: 2_318_274))
        XCTAssertEqual(HeaderSymbol("Оборот факт:141.690+1.238.900=1.380.590"), .item(title: "Оборот факт", value: 1_380_590))
        XCTAssertEqual(HeaderSymbol("Оборот факт:929.625"), .item(title: "Оборот факт", value: 929_625))

        XCTAssertEqual(HeaderSymbol("Средний показатель: 38.040"), .item(title: "Средний показатель", value: 38_040))
        XCTAssertEqual(HeaderSymbol("Средний показатель: 34.445"), .item(title: "Средний показатель", value: 34_445))
        XCTAssertEqual(HeaderSymbol("Средний показатель: 56.089"), .item(title: "Средний показатель", value: 56_089))
        XCTAssertEqual(HeaderSymbol("Средний показатель: 81.334"), .item(title: "Средний показатель", value: 81_334))
        XCTAssertEqual(HeaderSymbol("Средний показатель: 83.475"), .item(title: "Средний показатель", value: 83_475))
        XCTAssertEqual(HeaderSymbol("Средний показатель: 62.842"), .item(title: "Средний показатель", value: 62_842))
        XCTAssertEqual(HeaderSymbol("Средний показатель: 74.783"), .item(title: "Средний показатель", value: 74_783))
        XCTAssertEqual(HeaderSymbol("Средний показатель:41.836"), .item(title: "Средний показатель",  value: 41_836))
        XCTAssertEqual(HeaderSymbol("Средний показатель:29.987"), .item(title: "Средний показатель", value: 29_987))

        if let content = try? filenames[2]
            .contentsOfFile()
            .clearReport() {
            let header = ReportContent(stringLiteral: content).header

            header.forEach { item in
                XCTAssertNil(item)
                XCTAssertEqual(HeaderSymbol(stringLiteral: item),
                               .company(name: ""))
            }
        }
    }
}

