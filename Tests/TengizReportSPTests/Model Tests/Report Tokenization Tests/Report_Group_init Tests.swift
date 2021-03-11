//
//  Report_Group_init Tests.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 10.02.2021.
//

import XCTest
@testable import TengizReportModel

class TokenizedReportReportTests: XCTestCase {
    func test_report_func_dummy() throws {
        let tokenizedReport = TokenizedReport(stringLiteral: "")
        XCTAssertThrowsError(try tokenizedReport.report().get()) { error in
            XCTAssertEqual(.noMonth, error as! TokenizedReport.TransformationError,
                           "Expected to get error for no month")
        }
    }

    func test_TokenizedReport_Report_Group_init_1() {
        let tokens: [Token<BodySymbol>] = [
            Token<BodySymbol>(stringLiteral: "-10.000 за перерасход питание персонала в июле"),
            Token<BodySymbol>(stringLiteral: "Фактический приход товара и оплата товара:\t946.056р\t25%"),
            Token<BodySymbol>(stringLiteral: "1. Приход товара по накладным\t 946.056р (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)"),
            Token<BodySymbol>(stringLiteral: "2. Предоплаченный товар, но не отраженный в приходе\tСтудиопак Итого 12.500 (влажные салфетки);"),
            Token<BodySymbol>(stringLiteral: "ИТОГ:\t645.184р37к"),
        ]

        let group = TokenizedReport.Report.Group(groupNumber: 5, tokens: tokens)

        let sample = TokenizedReport.Report.Group(
            groupNumber: 5,
            title: "Фактический приход товара и оплата товара", amount: 645184.37, target: 0.25,
            items: [Item(itemNumber: 0, title: "Correction", amount: -10_000, note: "-10.000 за перерасход питание персонала в июле"),
                    Item(itemNumber: 1, title: "Приход товара по накладным", amount: 632_684.37, note: "946.056р (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)"),
                    Item(itemNumber: 2, title: "Предоплаченный товар, но не отраженный в приходе", amount: 12_500, note: "Студиопак Итого 12.500 (влажные салфетки);")]
        )

        XCTAssertEqual(group, sample)
    }

    func test_TokenizedReport_Report_Group_init_2() {
        let tokens0 = [Token<BodySymbol>(source: "Расходы на доставку:\t-----------------------------\t\t",
                                         symbol: .header(title: "Расходы на доставку", plan: nil, fact: nil)),
                       Token<BodySymbol>(source: "1. Курьеры\t-----------------------------",
                                         symbol: .empty),
                       Token<BodySymbol>(source: "2. Агрегаторы\t9.528",
                                         symbol: .item(itemNumber: 2, title: "Агрегаторы", value: 9_528, note: nil)),
                       Token<BodySymbol>(source: "ИТОГ:\t9.528",
                                         symbol: .footer(title: "ИТОГ:", value: 9_528))
        ]
        let tokens = [Token<BodySymbol>(stringLiteral: "Расходы на доставку:\t-----------------------------\t\t"),
                      Token<BodySymbol>(stringLiteral: "1. Курьеры\t-----------------------------"),
                      Token<BodySymbol>(stringLiteral: "2. Агрегаторы\t9.528"),
                      Token<BodySymbol>(stringLiteral: "ИТОГ:\t9.528"),
        ]

        // MARK: sample check
        zip(tokens0, tokens).forEach { XCTAssertEqual($0.0.symbol, $0.1.symbol) }
        tokens.forEach { XCTAssertEqual($0.symbol, BodySymbol(stringLiteral: $0.source)) }

        XCTAssertEqual(tokens.title(), "Расходы на доставку")
        XCTAssertEqual(tokens.amount(), 9_528)
        XCTAssertNil(tokens.target())

        let group = TokenizedReport.Report.Group(groupNumber: 5, tokens: tokens)

        let sample = TokenizedReport.Report.Group(
            groupNumber: 5,title: "Расходы на доставку", amount: 9_528, target: nil,
            items: [Item(itemNumber: 2, title: "Агрегаторы", amount: 9_528)]
        )

        XCTAssertEqual(group, sample)
    }

    func test_TokenizedReport_Report_Group_init_3() throws {
        let sampleTokenizedReport = TokenizedReport.saperavi_2020_07
        let bodyTokens = sampleTokenizedReport.body
        let groups = try bodyTokens.enumerated().compactMap {
            try XCTUnwrap(Group(groupNumber: $0.0 + 1, tokens: $0.1), "Testing Group 'init?(groupNumber:tokens:)'")
        }

        let reportSample = TokenizedReport.Report.saperavi_2020_07
        let samples = reportSample.groups

        XCTAssertEqual(groups.count, samples.count)

        zip(groups, samples).forEach { group, sample in
            XCTAssertEqual(group, sample)

            XCTAssertEqual(group.groupNumber, sample.groupNumber)
            XCTAssertEqual(group.title, sample.title)
            XCTAssertEqual(group.amount, sample.amount)
            XCTAssertEqual(group.target, sample.target)

            XCTAssertEqual(group.items, sample.items)
            zip(group.items, sample.items).forEach { item, sample in
                XCTAssertEqual(item, sample)

                XCTAssertEqual(item.itemNumber, sample.itemNumber)
                XCTAssertEqual(item.title, sample.title)
                XCTAssertEqual(item.amount, sample.amount)
                XCTAssertEqual(item.note, sample.note)
            }
        }
    }

}
