//
//  FooterSymbolSequenceTests.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 10.02.2021.
//

import XCTest
import Model

final class FooterSymbolSequenceTests: XCTestCase {
    let footer = [
        Token<FooterSymbol>(source: "ИТОГ всех расходов за месяц:\t2.343.392р 37к",
                            symbol: .totalExpenses(title: "ИТОГ всех расходов за месяц", value: 2_343_392.37)),
        Token<FooterSymbol>(source: "Фактический остаток:\t96.628р 63к\t20%",
                            symbol: .balance(title: "Фактический остаток", value: 96_628.63, percentage: 0.2)),
        Token<FooterSymbol>(source: "Минус с августа переходит 739.626р 06к",
                            symbol: .openingBalance(title: "Минус с августа переходит 739.626р 06к", value: -739_626.06)),
        Token<FooterSymbol>(source: "ИТОГ:\tМинус 642.997р 43к",
                            symbol: .runningBalance(title: "ИТОГ", value: -642_997.43))]

    func test_footer() {
        footer.forEach {
            XCTAssertEqual($0.symbol, FooterSymbol(stringLiteral: $0.source))
        }
    }

    func test_openingBalance() {
        // MARK: match
        XCTAssertEqual(-739_626.06, footer.openingBalance())

        // MARK: no match
        XCTAssertNil([Token<FooterSymbol>(stringLiteral: "ИТОГ всех расходов за месяц:\t2.343.392р 37к")].openingBalance())
    }
    func test_balance() {
        // MARK: match
        XCTAssertEqual(96_628.63, footer.balance() )

        // MARK: no match
        XCTAssertNil([Token<FooterSymbol>(stringLiteral: "ИТОГ всех расходов за месяц:\t2.343.392р 37к")].balance() )
    }
    func test_runningBalance() {
        // MARK: match
        XCTAssertEqual(-642_997.43, footer.runningBalance())

        // MARK: no match
        XCTAssertNil([Token<FooterSymbol>(stringLiteral: "ИТОГ всех расходов за месяц:\t2.343.392р 37к")].runningBalance())
    }
    func test_totalExpenses() {
        // MARK: match
        XCTAssertEqual(2_343_392.37, footer.totalExpenses() )

        // MARK: no match
        XCTAssertNil([Token<FooterSymbol>(stringLiteral: "Фактический остаток:\t96.628р 63к\t20%")].totalExpenses() )
    }
}

