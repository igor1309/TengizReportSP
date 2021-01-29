//
//  HeaderSymbolTests.swift
//  TengizReportSPM
//
//  Created by Igor Malyarov on 29.01.2021.
//

import XCTest
@testable import TengizReportSP

final class HeaderSymbolTests: XCTestCase {
    func testHeaderSymbolExpressibleByStringLiteral() {
        XCTAssertEqual(HeaderSymbol(stringLiteral: "Название объекта: Саперави Аминьевка"),
                       .company(name: "Саперави Аминьевка"))

        XCTAssertEqual(HeaderSymbol(stringLiteral: "Месяц: июнь2020 (с 24 по 30 июня)"),
                       .month(monthStr: "июнь2020"))

        XCTAssertEqual(HeaderSymbol(stringLiteral: "Месяц: июль2020"),
                       .month(monthStr: "июль2020"))

        XCTAssertEqual(HeaderSymbol(stringLiteral: "Оборот:266.285\tСредний показатель: 38.040\n\n"),
                       .item(title: "Оборот", value: 266_285))

        XCTAssertEqual(HeaderSymbol(stringLiteral: "Средний показатель: 38.040\n\n"),
                       .item(title: "Средний показатель", value: 38_040))
    }

    func testHeaderSymbolFunc() {
        XCTAssertEqual("Название объекта: Саперави Аминьевка".headerSymbol(),
                       .company(name: "Саперави Аминьевка"))
        XCTAssertEqual("Месяц: июнь2020 (с 24 по 30 июня)".headerSymbol(),
                       .month(monthStr: "июнь2020"))
        XCTAssertEqual("Месяц: июль2020".headerSymbol(),
                       .month(monthStr: "июль2020"))
        XCTAssertEqual("Оборот:266.285\tСредний показатель: 38.040\n\n".headerSymbol(),
                       .item(title: "Оборот", value: 266_285))
        XCTAssertEqual("Средний показатель: 38.040\n\n".headerSymbol(),
                       .item(title: "Средний показатель", value: 38_040))

    }
}
