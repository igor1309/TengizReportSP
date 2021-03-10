//
//  FooterItemTests.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 07.02.2021.
//

import XCTest
@testable import TengizReportModel

final class FooterSymbolStringExtTests: XCTestCase {
    func test_openingBalance() {
        XCTAssertNil("ИТОГ всех расходов за месяц:\t92.531р 15к".openingBalance())
        XCTAssertNil("Фактический остаток:\t173.753 \t20%".openingBalance())
        XCTAssertNil("-28.000 субсидия, поступила в июле".openingBalance())
        XCTAssertNil("+23.334р 76к остаток с инвестиций".openingBalance())
        XCTAssertNil("ИТОГ:\t-407.477р 46к".openingBalance())

        XCTAssertEqual("-173.753 остаток с июня".openingBalance(),
                       .openingBalance(title: "-173.753 остаток с июня", value: -173753.0))
        XCTAssertEqual("Минус с июля 407.477р 46к, переходит".openingBalance(),
                       .openingBalance(title: "Минус с июля 407.477р 46к, переходит", value: -407_477.46))
        XCTAssertEqual("Минус с августа переходит 739.626р 06к".openingBalance(),
                       .openingBalance(title: "Минус с августа переходит 739.626р 06к", value: -739_626.06))
        XCTAssertEqual("Переходит минус с сентября 642.997р 43к".openingBalance(),
                       .openingBalance(title: "Переходит минус с сентября 642.997р 43к", value: -642_997.43))
        XCTAssertEqual("Переходящий минус 920.304р 17к".openingBalance(),
                       .openingBalance(title: "Переходящий минус 920.304р 17к", value: -920_304.17))
        XCTAssertEqual("Переходящий минус 1.065.596р 76к".openingBalance(),
                       .openingBalance(title: "Переходящий минус 1.065.596р 76к", value: -1_065_596.76))

        XCTAssertEqual("Остаток с ноября \t684.753р 85к".openingBalance(),
                       .openingBalance(title: "Остаток с ноября \t684.753р 85к", value: 684_753.85))
    }
}

final class FooterItemTests: XCTestCase {
    func test_balance() throws {
        XCTAssertNil(try XCTUnwrap("ИТОГ всех расходов за месяц:\t920.954р 54к".footerItem())
                        .balance(), "Process by totalExpenses()'")
        XCTAssertNil(try XCTUnwrap("ИТОГ:\t-407.477р 46к".footerItem())
                        .balance(), "Process by 'runningBalance()'")
        XCTAssertNil(try XCTUnwrap("-28.000 субсидия, поступила в июле".footerItem())
                        .balance(), "Process by 'extraIncomeExpenses()'")
        XCTAssertNil(try XCTUnwrap("+23.334р 76к остаток с инвестиций".footerItem())
                        .balance(), "Process by 'extraIncomeExpenses()'")

        XCTAssertEqual(try XCTUnwrap("Фактический остаток:\t173.753 \t20%".footerItem())
                        .balance(),
                       .balance(title: "Фактический остаток", value: 173_753, percentage: 0.2))
        XCTAssertEqual(try XCTUnwrap("Фактический остаток:\t-609.230р 46к\t20%".footerItem())
                        .balance(),
                       .balance(title: "Фактический остаток", value: -609230.46, percentage: 0.2))
        XCTAssertEqual(try XCTUnwrap("Фактический остаток:\t-355.483р 36к\t20%".footerItem())
                        .balance(),
                       .balance(title: "Фактический остаток", value: -355_483.36, percentage: 0.2))
        XCTAssertEqual(try XCTUnwrap("Фактический остаток:\t96.628р 63к\t20%".footerItem())
                        .balance(),
                       .balance(title: "Фактический остаток", value: 96_628.63, percentage: 0.2))
        XCTAssertEqual(try XCTUnwrap("Фактический остаток:\tМинус 277.306р 74к\t20%".footerItem())
                        .balance(),
                       .balance(title: "Фактический остаток", value: -277_306.74, percentage: 0.2))
        XCTAssertEqual(try XCTUnwrap("Фактический остаток:\tМинус 145.292р 59к\t20%".footerItem())
                        .balance(),
                       .balance(title: "Фактический остаток", value: -145_292.59, percentage: 0.2))
        XCTAssertEqual(try XCTUnwrap("Фактический остаток:\tМинус 113.901р 89к\t20%".footerItem())
                        .balance(),
                       .balance(title: "Фактический остаток", value: -113_901.89, percentage: 0.2))
        XCTAssertEqual(try XCTUnwrap("Фактический остаток:\t684.753р 85к".footerItem())
                        .balance(),
                       .balance(title: "Фактический остаток", value: 684_753.85, percentage: nil))
        XCTAssertEqual(try XCTUnwrap("Фактический остаток:\t8.670р 46к".footerItem())
                        .balance(),
                       .balance(title: "Фактический остаток", value: 8_670.46, percentage: nil))
    }

    func test_totalExpenses() throws {
        XCTAssertNil(try XCTUnwrap("ИТОГ:\t-407.477р 46к".footerItem())
                        .totalExpenses(), "Process by 'runningBalance()'")
        XCTAssertNil(try XCTUnwrap("Фактический остаток:\t173.753 \t20%".footerItem())
                        .totalExpenses(), "Process by 'balance()'")
        XCTAssertNil(try XCTUnwrap("-28.000 субсидия, поступила в июле".footerItem())
                        .totalExpenses(), "Process by 'extraIncomeExpenses()'")
        XCTAssertNil(try XCTUnwrap("+23.334р 76к остаток с инвестиций".footerItem())
                        .totalExpenses(), "Process by 'extraIncomeExpenses()'")

        XCTAssertEqual(try XCTUnwrap("ИТОГ всех расходов за месяц:\t92.531р 15к".footerItem())
                        .totalExpenses(),
                       .totalExpenses(title: "ИТОГ всех расходов за месяц", value: 92531.15))
        XCTAssertEqual(try XCTUnwrap("ИТОГ всех расходов за месяц:\t1.677.077р 46к".footerItem())
                        .totalExpenses(),
                       .totalExpenses(title: "ИТОГ всех расходов за месяц", value: 1677077.46))
        XCTAssertEqual(try XCTUnwrap("ИТОГ всех расходов за месяц:\t2.094.271р 36к".footerItem())
                        .totalExpenses(),
                       .totalExpenses(title: "ИТОГ всех расходов за месяц", value: 2_094_271.36))
        XCTAssertEqual(try XCTUnwrap("ИТОГ всех расходов за месяц:\t2.343.392р 37к".footerItem())
                        .totalExpenses(),
                       .totalExpenses(title: "ИТОГ всех расходов за месяц", value: 2_343_392.37))
        XCTAssertEqual(try XCTUnwrap("ИТОГ всех расходов за месяц:\t2.865.042р 74к".footerItem())
                        .totalExpenses(),
                       .totalExpenses(title: "ИТОГ всех расходов за месяц", value: 2_865_042.74))
        XCTAssertEqual(try XCTUnwrap("ИТОГ всех расходов за месяц:\t2.030.572р 59к".footerItem())
                        .totalExpenses(),
                       .totalExpenses(title: "ИТОГ всех расходов за месяц", value: 2_030_572.59))
        XCTAssertEqual(try XCTUnwrap("ИТОГ всех расходов за месяц:\t2.432.175р 89к".footerItem())
                        .totalExpenses(),
                       .totalExpenses(title: "ИТОГ всех расходов за месяц", value: 2_432_175.89))
        XCTAssertEqual(try XCTUnwrap("ИТОГ всех расходов за месяц:\t695.836р 15к".footerItem())
                        .totalExpenses(),
                       .totalExpenses(title: "ИТОГ всех расходов за месяц", value: 695_836.15))
        XCTAssertEqual(try XCTUnwrap("ИТОГ всех расходов за месяц:\t920.954р 54к".footerItem())
                        .totalExpenses(),
                       .totalExpenses(title: "ИТОГ всех расходов за месяц", value: 920_954.54))
    }

    func test_extraIncomeExpenses() throws {
        XCTAssertNil(try XCTUnwrap("ИТОГ всех расходов за месяц:\t920.954р 54к".footerItem())
                        .extraIncomeExpenses(), "Process by totalExpenses()'")
        XCTAssertNil(try XCTUnwrap("Фактический остаток:\t173.753 \t20%".footerItem())
                        .extraIncomeExpenses(), "Process by 'balance()'")
        XCTAssertNil(try XCTUnwrap("ИТОГ:\t-407.477р 46к".footerItem())
                        .extraIncomeExpenses(), "Process by 'runningBalance()'")

        XCTAssertEqual(try XCTUnwrap("-28.000 субсидия, поступила в июле".footerItem())
                        .extraIncomeExpenses(),
                       .extraIncomeExpenses(title: "-28.000 субсидия, поступила в июле", value: -28_000))
        XCTAssertEqual(try XCTUnwrap("+23.334р 76к остаток с инвестиций".footerItem())
                        .extraIncomeExpenses(),
                       .extraIncomeExpenses(title: "+23.334р 76к остаток с инвестиций", value: 23_334.76))
    }

    func test_runningBalance() throws {
        XCTAssertNil(try XCTUnwrap("ИТОГ всех расходов за месяц:\t92.531р 15к".footerItem())
                        .runningBalance(), "Process by 'totalExpenses()'")
        XCTAssertNil(try XCTUnwrap("Фактический остаток:\t173.753 \t20%".footerItem())
                        .runningBalance(), "Process by 'balance()'")
        XCTAssertNil(try XCTUnwrap("-28.000 субсидия, поступила в июле".footerItem())
                        .runningBalance(), "Process by 'extraIncomeExpenses()'")
        XCTAssertNil(try XCTUnwrap("+23.334р 76к остаток с инвестиций".footerItem())
                        .runningBalance(), "Process by 'extraIncomeExpenses()'")


        XCTAssertEqual(try XCTUnwrap("ИТОГ:\t-407.477р 46к".footerItem())
                        .runningBalance(),
                       .runningBalance(title: "ИТОГ", value: -407_477.46))
        XCTAssertEqual(try XCTUnwrap("ИТОГ:\t-739.626р 06к".footerItem())
                        .runningBalance(),
                       .runningBalance(title: "ИТОГ", value: -739_626.06))
        XCTAssertEqual(try XCTUnwrap("ИТОГ:\tМинус 642.997р 43к".footerItem())
                        .runningBalance(),
                       .runningBalance(title: "ИТОГ", value: -642_997.43))
        XCTAssertEqual(try XCTUnwrap("ИТОГ:\tМинус 920.304р 17к".footerItem())
                        .runningBalance(),
                       .runningBalance(title: "ИТОГ", value: -920_304.17))
        XCTAssertEqual(try XCTUnwrap("ИТОГ:\tМинус 1.065.596р 76к".footerItem())
                        .runningBalance(),
                       .runningBalance(title: "ИТОГ", value: -1_065_596.76))
        XCTAssertEqual(try XCTUnwrap("ИТОГ:\tМинус 1.179.498р 65к".footerItem())
                        .runningBalance(),
                       .runningBalance(title: "ИТОГ", value: -1_179_498.65))
        XCTAssertEqual(try XCTUnwrap("ИТОГ:\t684.753р 85к переносится на декабрь месяц".footerItem())
                        .runningBalance(),
                       .runningBalance(title: "ИТОГ", value: 684_753.85))
        XCTAssertEqual(try XCTUnwrap("ИТОГ:\t693.424р 31к переносим на январь".footerItem())
                        .runningBalance(),
                       .runningBalance(title: "ИТОГ", value: 693_424.31))
    }
}
