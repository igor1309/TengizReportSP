//
//  FooterSymbolTests.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 29.01.2021.
//

import XCTest
@testable import TengizReportSP

extension FooterSymbol {
    init(_ string: String) {
        self.init(stringLiteral: string)
    }
}

final class FooterSymbolTests: XCTestCase {
    func test_expensesTotal() {
        XCTAssertEqual(FooterSymbol("ИТОГ всех расходов за месяц:\t92.531р 15к"),
                       .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 92_531.15))
        XCTAssertEqual(FooterSymbol("ИТОГ всех расходов за месяц:\t1.677.077р 46к"),
                       .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 1_677_077.46))
        XCTAssertEqual(FooterSymbol("ИТОГ всех расходов за месяц:\t2.094.271р 36к"),
                       .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 2_094_271.36))
        XCTAssertEqual(FooterSymbol("ИТОГ всех расходов за месяц:\t2.343.392р 37к"),
                       .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 2_343_392.37))
        XCTAssertEqual(FooterSymbol("ИТОГ всех расходов за месяц:\t2.865.042р 74к"),
                       .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 2_865_042.74))
        XCTAssertEqual(FooterSymbol("ИТОГ всех расходов за месяц:\t2.030.572р 59к"),
                       .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 2_030_572.59))
        XCTAssertEqual(FooterSymbol("ИТОГ всех расходов за месяц:\t2.432.175р 89к"),
                       .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 2_432_175.89))
        XCTAssertEqual(FooterSymbol("ИТОГ всех расходов за месяц:\t695.836р 15к"),
                       .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 695_836.15))
        XCTAssertEqual(FooterSymbol("ИТОГ всех расходов за месяц:\t920.954р 54к"),
                       .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 920_954.54))
    }

    func test_balance() {
        XCTAssertEqual(FooterSymbol("Фактический остаток:\t173.753 \t20%"),
                       .balance(title: "Фактический остаток", value: 173_753, percentage: 0.2))
        XCTAssertEqual(FooterSymbol("Фактический остаток:\t-609.230р 46к\t20%"),
                       .balance(title: "Фактический остаток", value: -609_230.46, percentage: 0.2))
        XCTAssertEqual(FooterSymbol("Фактический остаток:\t-355.483р 36к\t20%"),
                       .balance(title: "Фактический остаток", value: -355_483.36, percentage: 0.2))
        XCTAssertEqual(FooterSymbol("Фактический остаток:\t96.628р 63к\t20%"),
                       .balance(title: "Фактический остаток", value: 96_628.63, percentage: 0.2))
        XCTAssertEqual(FooterSymbol("Фактический остаток:\tМинус 277.306р 74к\t20%"),
                       .balance(title: "Фактический остаток", value: -277_306.74, percentage: 0.2))
        XCTAssertEqual(FooterSymbol("Фактический остаток:\tМинус 145.292р 59к\t20%"),
                       .balance(title: "Фактический остаток", value: -145_292.59, percentage: 0.2))
        XCTAssertEqual(FooterSymbol("Фактический остаток:\tМинус 113.901р 89к\t20%"),
                       .balance(title: "Фактический остаток", value: -113_901.89, percentage: 0.2))
        XCTAssertEqual(FooterSymbol("Фактический остаток:\t684.753р 85к"),
                       .balance(title: "Фактический остаток", value: 684_753.85, percentage: nil))
        XCTAssertEqual(FooterSymbol("Фактический остаток:\t8.670р 46к"),
                       .balance(title: "Фактический остаток", value: 8_670.46, percentage: nil))
    }

    func test_openingBalance() {
        XCTAssertEqual(FooterSymbol("-173.753 остаток с июня"),
                       .openingBalance(title: "-173.753 остаток с июня", value: -173753.0))
        XCTAssertEqual(FooterSymbol("Минус с июля 407.477р 46к, переходит"),
                       .openingBalance(title: "Минус с июля 407.477р 46к, переходит", value: -407_477.46))
        XCTAssertEqual(FooterSymbol("Минус с августа переходит 739.626р 06к"),
                       .openingBalance(title: "Минус с августа переходит 739.626р 06к", value: -739_626.06))
        XCTAssertEqual(FooterSymbol("Переходит минус с сентября 642.997р 43к"),
                       .openingBalance(title: "Переходит минус с сентября 642.997р 43к", value: -642_997.43))
        XCTAssertEqual(FooterSymbol("Переходящий минус 920.304р 17к"),
                       .openingBalance(title: "Переходящий минус 920.304р 17к", value: -920_304.17))
        XCTAssertEqual(FooterSymbol("Переходящий минус 1.065.596р 76к"),
                       .openingBalance(title: "Переходящий минус 1.065.596р 76к", value: -1_065_596.76))

        XCTAssertEqual(FooterSymbol("Остаток с ноября \t684.753р 85к"),
                       .openingBalance(title: "Остаток с ноября \t684.753р 85к", value: 684_753.85))
    }

    func test_extraIncomeExpenses() {
        XCTAssertEqual(FooterSymbol("-28.000 субсидия, поступила в июле"),
                       .extraIncomeExpenses(title: "-28.000 субсидия, поступила в июле", value: -28_000))
        XCTAssertEqual(FooterSymbol("+23.334р 76к остаток с инвестиций"),
                       .extraIncomeExpenses(title: "+23.334р 76к остаток с инвестиций", value: 23_334.76))
    }

    func test_runningBalance() {
        XCTAssertEqual(FooterSymbol("ИТОГ:\t-407.477р46к"),
                       .runningBalance(title: "ИТОГ", value: -407_477.46))
        XCTAssertEqual(FooterSymbol("ИТОГ:\t-407.477р 46к"),
                       .runningBalance(title: "ИТОГ", value: -407_477.46))

        XCTAssertEqual(FooterSymbol("ИТОГ:\t-739.626р 06к"),
                       .runningBalance(title: "ИТОГ", value: -739_626.06))
        XCTAssertEqual(FooterSymbol("ИТОГ:\tМинус 642.997р 43к"),
                       .runningBalance(title: "ИТОГ", value: -642_997.43))
        XCTAssertEqual(FooterSymbol("ИТОГ:\tМинус 920.304р 17к"),
                       .runningBalance(title: "ИТОГ", value: -920_304.17))
        XCTAssertEqual(FooterSymbol("ИТОГ:\tМинус 1.065.596р 76к"),
                       .runningBalance(title: "ИТОГ", value: -1_065_596.76))
        XCTAssertEqual(FooterSymbol("ИТОГ:\tМинус 1.179.498р 65к"),
                       .runningBalance(title: "ИТОГ", value: -1_179_498.65))
        XCTAssertEqual(FooterSymbol("ИТОГ:\t684.753р 85к переносится на декабрь месяц"),
                       .runningBalance(title: "ИТОГ", value: 684_753.85))
        XCTAssertEqual(FooterSymbol("ИТОГ:\t693.424р 31к переносим на январь"),
                       .runningBalance(title: "ИТОГ", value: 693_424.31))
    }
}
