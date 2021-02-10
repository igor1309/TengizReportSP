//
//  TokenTests.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 08.02.2021.
//

import XCTest
@testable import TengizReportSP


final class TokenTests: XCTestCase {
    func test_Token_BodySymbol() {
        var input = "Основные расходы:\t\t25%"
        XCTAssertEqual(Token<BodySymbol>(stringLiteral: input),
                       Token<BodySymbol>(source: input, symbol: .header(title: "Основные расходы", plan: 0.25, fact: nil)))

        input = "Основные расходы:\t\t25%\t8.76%"
        XCTAssertEqual(Token<BodySymbol>(stringLiteral: input),
                       Token<BodySymbol>(source: input, symbol: .header(title: "Основные расходы", plan: 0.25, fact: 0.0876)))

        input = "1.ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)\t\t"
        XCTAssertEqual(Token<BodySymbol>(stringLiteral: input),
                       Token<BodySymbol>(source: input, symbol: .empty))

        input = "1.ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"
        XCTAssertEqual(Token<BodySymbol>(stringLiteral: input),
                       Token<BodySymbol>(source: input, symbol: .item(itemNumber: 1, title: "ФОТ", value: 704848.0, note: "( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)")))

        XCTAssertNotEqual(Token<BodySymbol>(stringLiteral: input),
                          Token<BodySymbol>(source: input, symbol: .empty))

        input = "ИТОГ:\t65.167"
        XCTAssertEqual(Token<BodySymbol>(stringLiteral: input),
                       Token<BodySymbol>(source: input, symbol: .footer(title: "ИТОГ:", value: 65_167)))
        // no match
        input = "ИТОГ:\t65.167\t\t"
        XCTAssertEqual(Token<BodySymbol>(stringLiteral: input),
                       Token<BodySymbol>(source: input, symbol: .empty),
                       "Mind the TABs at the end")

    }
}
