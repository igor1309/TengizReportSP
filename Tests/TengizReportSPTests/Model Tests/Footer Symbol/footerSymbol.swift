//
//  footerSymbol.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 06.02.2021.
//

import XCTest
@testable import TengizReportSP

final class GetFooterSourcesTests: XCTestCase {
    func testSpecialFuncToGetAllFooters() throws {
        let footers = try filenames
            .compactMap { filename in
                ReportContent(
                    stringLiteral: try filename
                        .contentsOfFile()
                        .clearReport()
                )
                .footer
            }
        XCTAssertNotNil(footers)
    }

    func testGeFootersFromtSamples() {
        let footers = ReportContent.sampleContents
            .compactMap { $0.footer.last }
        XCTAssertNotNil(footers)
    }

    func test_GetSources() {
        let sourses = try? filenames
            .flatMap { filename in
                ReportContent(
                    stringLiteral: try filename
                        .contentsOfFile()
                        //.clearReport()
                )
                //.body
                .footer
                .flatMap { $0.components(separatedBy: "\n") }
               // .flatMap { $0.components(separatedBy: "\t") }
                //.filter { nil != $0.firstMatch(for: "Приход") }
            }
        XCTAssertNotEqual(sourses, [])
        XCTAssertNotEqual(sourses?.joined(separator: "\n"), "")

        _ = [
            // Saperavi 06.2020
            "ИТОГ всех расходов за месяц:\t92.531р15к",     // expensesTotal
            "Фактический остаток:\t173.753 \t20%",         // balance = revenue - expensesTotal

            // Saperavi 07.2020
            "ИТОГ всех расходов за месяц:\t1.677.077р46к", // expensesTotal
            "Фактический остаток:\t-609.230р46к\t20%",     // balance = revenue - expensesTotal
            "-173.753 остаток с июня",                     // openningBalance // !! написан с минусом, по факту плюс
            "-28.000 субсидия, поступила в июле",          // extra+/- // !! написан с минусом, по факту плюс
            "ИТОГ:\t-407.477р46к",                         // runningBalance

            "ИТОГ всех расходов за месяц:\t2.094.271р 36к",
            "Фактический остаток:\t-355.483р 36к\t20%",
            "Минус с июля 407.477р 46 к., переходит",
            "+23.334р 76к остаток с инвестиций",
            "ИТОГ:\t-739.626р 06к",

            "ИТОГ всех расходов за месяц:\t2.343.392р 37к",
            "Фактический остаток:\t96.628р 63к\t20%",
            "Минус с августа переходит 739.626р 06к",
            "ИТОГ:\tМинус 642.997р 43к",

            "ИТОГ всех расходов за месяц:\t2.865.042р 74к",
            "Фактический остаток:\tМинус 277.306р 74к\t20%",
            "Переходит минус с сентября 642.997р 43к",
            "ИТОГ:\tМинус 920.304р 17к",

            "ИТОГ всех расходов за месяц:\t2.030.572р59к",
            "Фактический остаток:\tМинус 145.292р59к\t20%",
            "Переходящий минус 920.304р 17к",
            "ИТОГ:\tМинус 1.065.596р 76к",

            "ИТОГ всех расходов за месяц:\t2.432.175р89к",
            "Фактический остаток:\tМинус 113.901р89к\t20%",
            "Переходящий минус 1.065.596р 76к",
            "ИТОГ:\tМинус 1.179.498р65к",

            "ИТОГ всех расходов за месяц:\t695.836р15к",
            "Фактический остаток:\t684.753р85к",
            "ИТОГ:\t684.753р85к переносится на декабрь месяц",

            "ИТОГ всех расходов за месяц:\t920.954р54к",
            "Фактический остаток:\t8.670р46к",
            "Остаток с ноября \t684.753р85к",
            "ИТОГ:\t693.424р31к переносим на январь"]

        /*
        let allFooters = """
ИТОГ всех расходов за месяц:\t92.531р15к
Фактический остаток:\t173.753 \t20%
ИТОГ всех расходов за месяц:\t1.677.077р46к
Фактический остаток:\t-609.230р46к\t20%
-173.753 остаток с июня
-28.000 субсидия, поступила в июле
ИТОГ:\t-407.477р46к
ИТОГ всех расходов за месяц:\t2.094.271р 36к
Фактический остаток:\t-355.483р 36к\t20%
Минус с июля 407.477р 46 к., переходит
+23.334р 76к остаток с инвестиций
ИТОГ:\t-739.626р 06к
ИТОГ всех расходов за месяц:\t2.343.392р 37к
Фактический остаток:\t96.628р 63к\t20%
Минус с августа переходит 739.626р 06к
ИТОГ:\tМинус 642.997р 43к
ИТОГ всех расходов за месяц:\t2.865.042р 74к
Фактический остаток:\tМинус 277.306р 74к\t20%
Переходит минус с сентября 642.997р 43к
ИТОГ:\tМинус 920.304р 17к
ИТОГ всех расходов за месяц:\t2.030.572р59к
Фактический остаток:\tМинус 145.292р59к\t20%
Переходящий минус 920.304р 17к
ИТОГ:\tМинус 1.065.596р 76к
ИТОГ всех расходов за месяц:\t2.432.175р89к
Фактический остаток:\tМинус 113.901р89к\t20%
Переходящий минус 1.065.596р 76к
ИТОГ:\tМинус 1.179.498р65к
ИТОГ всех расходов за месяц:\t695.836р15к
Фактический остаток:\t684.753р85к
ИТОГ:\t684.753р85к переносится на декабрь месяц
ИТОГ всех расходов за месяц:\t920.954р54к
Фактический остаток:\t8.670р46к
Остаток с ноября \t684.753р85к
ИТОГ:\t693.424р31к переносим на январь
            """
*/
    }

    func test_footerItem() {

        XCTAssertEqual("Фактический остаток:\t-609.230р 46к\t20%".components(separatedBy: "\t"),
                       ["Фактический остаток:", "-609.230р 46к", "20%"])

        XCTAssertEqual("ИТОГ всех расходов за месяц:\t1.677.077р 46к".footerItem(),
                       FooterItem(title: "ИТОГ всех расходов за месяц:", value: 1_677_077.46, percentage: nil))
        XCTAssertEqual("Фактический остаток:\t-609.230р 46к\t20%".footerItem(),
                       FooterItem(title: "Фактический остаток:", value: -609_230.46, percentage: 0.20))
        XCTAssertEqual("-173.753 остаток с июня".footerItem(),
                       FooterItem(title: "-173.753 остаток с июня", value: nil, percentage: nil))
        XCTAssertEqual("-28.000 субсидия, поступила в июле".footerItem(),
                       FooterItem(title: "-28.000 субсидия, поступила в июле", value: nil, percentage: nil))
        XCTAssertEqual("ИТОГ:\t-407.477р 46к".footerItem(),
                       FooterItem(title: "ИТОГ:", value: -407_477.46, percentage: nil))

    }

    func test_footerSymbol() {
        // MARK: - WHAT I WANT (reportContent202007)
        /*
         XCTAssertEqual(FooterSymbol("ИТОГ всех расходов за месяц:\t1.677.077р 46к"),
         .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 1_677_077.46))
         XCTAssertEqual(FooterSymbol("Фактический остаток:\t-609.230р 46к\t20%"),
         .balance(title: "Фактический остаток", value: -609_230.46, percentage: 0.2))
         XCTAssertEqual(FooterSymbol("-173.753 остаток с июня"),
         .openingBalance(title: "-173.753 остаток с июня", value: -173_753))
         XCTAssertEqual(FooterSymbol("-28.000 субсидия, поступила в июле"),
         .extraIncomeExpenses(title: "-28.000 субсидия, поступила в июле", value: -28_000))
         XCTAssertEqual(FooterSymbol("ИТОГ:\t-407.477р 46к"),
         .runningBalance(title: "ИТОГ", value: -407_477.46))
         */

        XCTAssertEqual("ИТОГ всех расходов за месяц:\t1.677.077р 46к".footerItem(),
                       FooterItem(title: "ИТОГ всех расходов за месяц:", value: 1_677_077.46, percentage: nil))
        XCTAssertEqual("Фактический остаток:\t-609.230р 46к\t20%".footerItem(),
                       FooterItem(title: "Фактический остаток:", value: -609_230.46, percentage: 0.20))
        XCTAssertEqual("-173.753 остаток с июня".footerItem(),
                       FooterItem(title: "-173.753 остаток с июня", value: nil, percentage: nil))
        XCTAssertEqual("-28.000 субсидия, поступила в июле".footerItem(),
                       FooterItem(title: "-28.000 субсидия, поступила в июле", value: nil, percentage: nil))
        XCTAssertEqual("ИТОГ:\t-407.477р 46к".footerItem(),
                       FooterItem(title: "ИТОГ:", value: -407_477.46, percentage: nil))

    }
}
