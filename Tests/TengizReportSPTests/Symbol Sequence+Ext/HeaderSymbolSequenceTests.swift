//
//  HeaderSymbolSequenceTests.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 10.02.2021.
//

import XCTest
@testable import TengizReportModel

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

    #warning("need more test for this func, see prefixes @ FilesTests ")
    func test_month() {
        XCTAssertEqual(Patterns.monthWithoutYear, #"(?:Месяц: )?(?<month>\D+)(?:\d{4}).*\t?"#)

        XCTAssertEqual("Месяц: июнь2020 (с 24 по 30 июня)\t".replaceFirstMatch(for: Patterns.monthWithoutYear, withGroup: "month"), "июнь")
        XCTAssertEqual("Месяц: июль2020 \t".replaceFirstMatch(for: Patterns.monthWithoutYear, withGroup: "month"), "июль")
        XCTAssertEqual("Месяц: август2020 \t".replaceFirstMatch(for: Patterns.monthWithoutYear, withGroup: "month"), "август")
        XCTAssertEqual("Месяц: сентябрь2020 \t".replaceFirstMatch(for: Patterns.monthWithoutYear, withGroup: "month"), "сентябрь")
        XCTAssertEqual("Октябрь2020 \t".replaceFirstMatch(for: Patterns.monthWithoutYear, withGroup: "month"), "Октябрь")
        XCTAssertEqual("Ноябрь2020 \t".replaceFirstMatch(for: Patterns.monthWithoutYear, withGroup: "month"), "Ноябрь")
        XCTAssertEqual("Декабрь2020 \t".replaceFirstMatch(for: Patterns.monthWithoutYear, withGroup: "month"), "Декабрь")
        XCTAssertEqual("Январь2021 \t".replaceFirstMatch(for: Patterns.monthWithoutYear, withGroup: "month"), "Январь")
        XCTAssertEqual("Февраль2021\t".replaceFirstMatch(for: Patterns.monthWithoutYear, withGroup: "month"), "Февраль")
        XCTAssertEqual("Октябрь+Ноябрь2020\t".replaceFirstMatch(for: Patterns.monthWithoutYear, withGroup: "month"), "Октябрь+Ноябрь")
        XCTAssertEqual("Декабрь2020\t".replaceFirstMatch(for: Patterns.monthWithoutYear, withGroup: "month"), "Декабрь")
        XCTAssertEqual("Январь2021\t".replaceFirstMatch(for: Patterns.monthWithoutYear, withGroup: "month"), "Январь")

        XCTAssertEqual("Месяц: июнь2020 (с 24 по 30 июня)\t".monthInt(), 6)
        XCTAssertEqual("Месяц: июль2020 \t".monthInt(), 7)
        XCTAssertEqual("Месяц: август2020 \t".monthInt(), 8)
        XCTAssertEqual("Месяц: сентябрь2020 \t".monthInt(), 9)
        XCTAssertEqual("Октябрь2020 \t".monthInt(), 10)
        XCTAssertEqual("Ноябрь2020 \t".monthInt(), 11)
        XCTAssertEqual("Декабрь2020 \t".monthInt(), 12)
        XCTAssertEqual("Январь2021 \t".monthInt(), 01)
        XCTAssertEqual("Февраль2021\t".monthInt(), 02)
        XCTAssertEqual("Октябрь+Ноябрь2020\t".monthInt(), 11)
        XCTAssertEqual("Декабрь2020\t".monthInt(), 12)
        XCTAssertEqual("Январь2021\t".monthInt(), 01)
    }

    func test_year() {
        XCTAssertEqual("Месяц: июнь2020 (с 24 по 30 июня)\t".yearInt(), 2020)
        XCTAssertEqual("Месяц: июль2020 \t".yearInt(), 2020)
        XCTAssertEqual("Месяц: август2020 \t".yearInt(), 2020)
        XCTAssertEqual("Месяц: сентябрь2020 \t".yearInt(), 2020)
        XCTAssertEqual("Октябрь2020 \t".yearInt(), 2020)
        XCTAssertEqual("Ноябрь2020 \t".yearInt(), 2020)
        XCTAssertEqual("Декабрь2020 \t".yearInt(), 2020)
        XCTAssertEqual("Январь2021 \t".yearInt(), 2021)
        XCTAssertEqual("Февраль2021\t".yearInt(), 2021)
        XCTAssertEqual("Октябрь+Ноябрь2020\t".yearInt(), 2020)
        XCTAssertEqual("Декабрь2020\t".yearInt(), 2020)
        XCTAssertEqual("Январь2021\t".yearInt(), 2021)
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
