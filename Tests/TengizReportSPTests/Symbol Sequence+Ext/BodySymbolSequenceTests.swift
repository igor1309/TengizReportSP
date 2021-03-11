//
//  BodySymbolSequenceTests.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 10.02.2021.
//

import XCTest
import TengizReportModel

final class BodySymbolSequenceTests: XCTestCase {
    let group = [
        Token<BodySymbol>(source: "\t-10.000 за перерасход питание персонала в июле",
                          symbol: .item(itemNumber: 0, title: "Correction", value: -10000.0, note: "-10.000 за перерасход питание персонала в июле")),
        Token<BodySymbol>(source: "Фактический приход товара и оплата товара:\t946.056р\t25%",
                          symbol: .header(title: "Фактический приход товара и оплата товара", plan: 0.25, fact: nil)),
        Token<BodySymbol>(source: "1. Приход товара по накладным\t 946.056р (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)",
                          symbol: .item(itemNumber: 1, title: "Приход товара по накладным", value: 632684.37, note: "946.056р (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)")),
        Token<BodySymbol>(source: "2. Предоплаченный товар, но не отраженный в приходе\tСтудиопак Итого 12.500 (влажные салфетки);",
                          symbol: .item(itemNumber: 2, title: "Предоплаченный товар, но не отраженный в приходе", value: 12_500, note: "Студиопак Итого 12.500 (влажные салфетки);")),
        Token<BodySymbol>(source: "ИТОГ:\t645.184р37к",
                          symbol: .footer(title: "ИТОГ:", value: 645184.37))
    ]

    func test_group() {
        group.forEach {
            XCTAssertEqual($0.symbol, BodySymbol(stringLiteral: $0.source))
        }
    }

    func test_title() {
        // MARK: match
        XCTAssertEqual("Фактический приход товара и оплата товара", group.title())

        // MARK: no match
        var token = Token<BodySymbol>(stringLiteral: "1. Аренда торгового помещения\t46.667 (за июнь)")
        XCTAssertEqual(token,
                       Token<BodySymbol>(source: "1. Аренда торгового помещения\t46.667 (за июнь)",
                                         symbol: .item(itemNumber: 1, title: "Аренда торгового помещения", value: 46667.0, note: "(за июнь)")))
        XCTAssertNil([token].title(), "This is '.item'")

        token = Token<BodySymbol>(stringLiteral: "ИТОГ всех расходов за месяц:\t2.343.392р 37к")
        XCTAssertNil([token].title(), "This is '.footer'")
    }

    func test_amount() {
        // MARK: match
        XCTAssertEqual(645_184.37, group.amount())

        // MARK: no match
        var token = Token<BodySymbol>(stringLiteral: "1. Аренда торгового помещения\t46.667 (за июнь)")
        XCTAssertEqual(token,
                       Token<BodySymbol>(source: "1. Аренда торгового помещения\t46.667 (за июнь)",
                                         symbol: .item(itemNumber: 1, title: "Аренда торгового помещения", value: 46667.0, note: "(за июнь)")))
        XCTAssertNil([token].amount(), "This is '.item'")

        token = Token<BodySymbol>(stringLiteral: "Фактический приход товара и оплата товара")
        XCTAssertNil([token].amount(), "This is '.header'")
    }

    func test_target() {
        // MARK: match
        XCTAssertEqual(0.25, group.target())

        // MARK: no match
        var token = Token<BodySymbol>(stringLiteral: "1. Аренда торгового помещения\t46.667 (за июнь)")
        XCTAssertEqual(token,
                       Token<BodySymbol>(source: "1. Аренда торгового помещения\t46.667 (за июнь)",
                                         symbol: .item(itemNumber: 1, title: "Аренда торгового помещения", value: 46667.0, note: "(за июнь)")))
        XCTAssertNil([token].target(), "This is '.item'")

        token = Token<BodySymbol>(stringLiteral: "ИТОГ всех расходов за месяц:\t2.343.392р 37к")
        XCTAssertNil([token].title(), "This is '.footer'")
    }

}
