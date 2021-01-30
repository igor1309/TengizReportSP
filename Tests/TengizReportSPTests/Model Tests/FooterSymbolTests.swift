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
    func testSpecialFuncToGetAllFooters() throws {
        let footers = try filenames
            .flatMap { filename in
                ReportContent(
                    stringLiteral: try filename
                        .contentsOfFile()
                        .clearReport()
                )
                .footer
            }
        XCTAssertNil(footers)
    }

    func testExpensesTotal() {
        XCTAssertEqual("ИТОГ всех расходов за месяц:\t92.531р 15к".footerSymbol(),
                       .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 92531.15))
        XCTAssertEqual("ИТОГ всех расходов за месяц:\t1.677.077р 46к".footerSymbol(),
                       .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 1677077.46))
        XCTAssertEqual("ИТОГ всех расходов за месяц:\t2.094.271р 36к".footerSymbol(),
                       .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 2_094_271.36))
        XCTAssertEqual("ИТОГ всех расходов за месяц:\t2.343.392р 37к".footerSymbol(),
                       .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 2_343_392.37))
        XCTAssertEqual("ИТОГ всех расходов за месяц:\t2.865.042р 74к".footerSymbol(),
                       .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 2_865_042.74))
        XCTAssertEqual("ИТОГ всех расходов за месяц:\t2.030.572р 59к".footerSymbol(),
                       .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 2_030_572.59))
        XCTAssertEqual("ИТОГ всех расходов за месяц:\t2.432.175р 89к".footerSymbol(),
                       .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 2_432_175.89))
        XCTAssertEqual("ИТОГ всех расходов за месяц:\t695.836р 15к".footerSymbol(),
                       .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 695_836.15))
        XCTAssertEqual("ИТОГ всех расходов за месяц:\t920.954р 54к".footerSymbol(),
                       .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 920_954.54))
    }

    func testTotal() {
        XCTAssertEqual("Фактический остаток:\t-609.230р 46к\t20%".footerSymbol(),
                       .total(title: "Фактический остаток", value: -609230.46, percentage: 0.2))
        XCTAssertEqual("Фактический остаток:\t-355.483р 36к\t20%".footerSymbol(),
                       .total(title: "Фактический остаток", value: -355_483.36, percentage: 0.2))
        XCTAssertEqual("Фактический остаток:\t96.628р 63к\t20%".footerSymbol(),
                       .total(title: "Фактический остаток", value: 96_628.63, percentage: 0.2))
        XCTAssertEqual("Фактический остаток:\tМинус 277.306р 74к\t20%".footerSymbol(),
                       .total(title: "Фактический остаток", value: -277_306.74, percentage: 0.2))
        XCTAssertEqual("Фактический остаток:\tМинус 145.292р 59к\t20%".footerSymbol(),
                       .total(title: "Фактический остаток", value: -145_292.59, percentage: 0.2))
        XCTAssertEqual("Фактический остаток:\tМинус 113.901р 89к\t20%".footerSymbol(),
                       .total(title: "Фактический остаток", value: -113_901.89, percentage: 0.2))
        XCTAssertEqual("Фактический остаток:\t684.753р 85к".footerSymbol(),
                       .total(title: "Фактический остаток", value: 684_753.85, percentage: 0.2))
        XCTAssertEqual("Фактический остаток:\t8.670р 46к".footerSymbol(),
                       .total(title: "Фактический остаток", value: 8_670.46, percentage: 0.2))
    }

    func testExtraIncomeExpenses() {
        XCTAssertEqual("-28.000 субсидия, поступила в июле".footerSymbol(),
                       .extraIncomeExpenses(title: "-28.000 субсидия, поступила в июле", value: -28_000))
        XCTAssertEqual("+23.334р 76к остаток с инвестиций".footerSymbol(),
                       .extraIncomeExpenses(title: "+23.334р 76к остаток с инвестиций", value: 23_334.76))
    }

    func testOpeningBalance() {
        XCTAssertEqual("-173.753 переходит остаток с июня".footerSymbol(),
                       .openingBalance(title: "-173.753 переходит остаток с июня", value: -173753.0))
        XCTAssertEqual("Минус с июля 407.477р 46к, переходит".footerSymbol(),
                       .openingBalance(title: "Минус с июля 407.477р 46к, переходит", value: -407_477.46))
        XCTAssertEqual("Минус с августа переходит 739.626р 06к".footerSymbol(),
                       .openingBalance(title: "Минус с августа переходит 739.626р 06к", value: -739_626.06))
        XCTAssertEqual("Переходит минус с сентября 642.997р 43к".footerSymbol(),
                       .openingBalance(title: "Переходит минус с сентября 642.997р 43к", value: -642_997.43))
        XCTAssertEqual("Переходящий минус 920.304р 17к".footerSymbol(),
                       .openingBalance(title: "Переходящий минус 920.304р 17к", value: -920_304.17))
        XCTAssertEqual("Переходящий минус 1.065.596р 76к".footerSymbol(),
                       .openingBalance(title: "Переходящий минус 1.065.596р 76к", value: -1_065_596.76))
        XCTAssertEqual("Переходит остаток с ноября \t684.753р 85к".footerSymbol(),
                       .openingBalance(title: "Переходит остаток с ноября \t684.753р 85к", value: 684_753.85))
    }
}
