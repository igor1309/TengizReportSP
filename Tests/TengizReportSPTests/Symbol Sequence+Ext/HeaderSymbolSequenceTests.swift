//
//  HeaderSymbolSequenceTests.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 10.02.2021.
//

import XCTest
import Model

final class HeaderSymbolSequenceTests: XCTestCase {
    let header = [
        Token<HeaderSymbol>(source: "Название объекта: Саперави Аминьевка",
                            symbol: .company(name: "Саперави Аминьевка")),
        Token<HeaderSymbol>(source: "Месяц: сентябрь2020",
                            symbol: .month(monthStr: "сентябрь2020")),
        Token<HeaderSymbol>(source: "Оборот:2.440.021",
                            symbol: .revenue(2_440_021)),
        Token<HeaderSymbol>(source: "Средний показатель: 81.334",
                            symbol: .dailyAverage(81_334))]

    func test_header() {
        header.forEach {
            XCTAssertEqual($0.symbol, HeaderSymbol(stringLiteral: $0.source))
        }
    }

    func test_monthStr() {
        // MARK: match
        XCTAssertEqual("сентябрь2020", header.monthStr())

        // MARK: no match
        XCTAssertNotEqual("Декабрь2020", header.monthStr())
        XCTAssertNil([Token<HeaderSymbol>(stringLiteral: "Средний показатель: 81.334")].monthStr())
    }
    func test_company() {
        // MARK: match
        XCTAssertEqual("Саперави Аминьевка", header.company())

        // MARK: no match
        XCTAssertNil([Token<HeaderSymbol>(stringLiteral: "Средний показатель: 81.334")].company())
    }
    func test_revenue() {
        // MARK: match
        XCTAssertEqual(2_440_021, header.revenue())

        // MARK: no match
        XCTAssertNil([Token<HeaderSymbol>(stringLiteral: "Средний показатель: 81.334")].revenue())
    }
    func test_dailyAverage() {
        // MARK: match
        XCTAssertEqual(81_334, header.dailyAverage())

        // MARK: no match
        XCTAssertNil([Token<HeaderSymbol>(stringLiteral: "Оборот:2.440.021")].dailyAverage())
    }
}
