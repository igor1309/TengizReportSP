//
//  itemWithComment.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 04.02.2021.
//

import XCTest
@testable import TengizReportSP

extension RegexPatternsTests {
    func test_itemWithComment() {
        XCTAssertEqual(Patterns.itemWithComment, #"^(?<title>^\d+\.\D+)(?<value>\d{1,3}(?:\.\d{3})*)(?<comment>\s*\((?:(?!Итого|фактический).)*\))$"#)
        
        XCTAssertNil("1. Приход товара по накладным\t 946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)".firstMatch(for: Patterns.itemWithComment), "This input should be matched by 'itemItogo'")

        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: Patterns.itemWithComment) }.count,
                       9, "Should be exactly 9 matches")

        XCTAssertEqual("1. Аренда торгового помещения\t46.667 (за июнь)".firstMatch(for: Patterns.itemWithComment),
                       "1. Аренда торгового помещения\t46.667 (за июнь)")
        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за июль)".firstMatch(for: Patterns.itemWithComment),
                       "1. Аренда торгового помещения\t 200.000 (за июль)")
        XCTAssertEqual("1. ФОТ\t 564.678( за вторую часть октября)".firstMatch(for: Patterns.itemWithComment),
                       "1. ФОТ\t 564.678( за вторую часть октября)")
        XCTAssertEqual("1. ФОТ\t595.360 ( за первую часть ноября)".firstMatch(for: Patterns.itemWithComment),
                       "1. ФОТ\t595.360 ( за первую часть ноября)")
        /// have `numbers` inside parentheses (inside comment)
        XCTAssertEqual("1. ФОТ\t19.721 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)".firstMatch(for: Patterns.itemWithComment),
                       "1. ФОТ\t19.721 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)")
        XCTAssertEqual("1. ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)".firstMatch(for: Patterns.itemWithComment),
                       "1. ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)")
        XCTAssertEqual("1. ФОТ\t 894.510( за вторую часть июля и первая часть августа)".firstMatch(for: Patterns.itemWithComment),
                       "1. ФОТ\t 894.510( за вторую часть июля и первая часть августа)")
        XCTAssertEqual("1. ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)".firstMatch(for: Patterns.itemWithComment),
                       "1. ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)")
        /// item with `math` and `comment` after number
        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)".firstMatch(for: Patterns.itemWithComment),
                       "1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)")
    }
}

extension BodySymbolFuncTests {
    func test_itemWithComment() {
        XCTAssertEqual(selectedBodyItems.compactMap { $0.bodySymbol(for: Patterns.itemWithComment) }.count,
                       9, "Should be exactly 9 matches")

        XCTAssertEqual("1. Аренда торгового помещения\t46.667 (за июнь)".bodySymbol(for: Patterns.itemWithComment),
                       .item(title: "1. Аренда торгового помещения", value: 46_667, comment: "(за июнь)"))
        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за июль)".bodySymbol(for: Patterns.itemWithComment),
                       .item(title: "1. Аренда торгового помещения", value: 200_000, comment: "(за июль)"))
        XCTAssertEqual("1. ФОТ\t 564.678( за вторую часть октября)".bodySymbol(for: Patterns.itemWithComment),
                       .item(title: "1. ФОТ", value: 564_678, comment: "( за вторую часть октября)"))
        XCTAssertEqual("1. ФОТ\t595.360 ( за первую часть ноября)".bodySymbol(for: Patterns.itemWithComment),
                       .item(title: "1. ФОТ", value: 595_360, comment: "( за первую часть ноября)"))
        /// have `numbers` inside parentheses (inside comment)
        XCTAssertEqual("1. ФОТ\t19.721 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)".bodySymbol(for: Patterns.itemWithComment),
                       .item(title: "1. ФОТ", value: 19_721, comment: "( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"))
        XCTAssertEqual("1. ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)".bodySymbol(for: Patterns.itemWithComment),
                       .item(title: "1. ФОТ", value: 704_848, comment: "( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"))
        XCTAssertEqual("1. ФОТ\t 894.510( за вторую часть июля и первая часть августа)".bodySymbol(for: Patterns.itemWithComment),
                       .item(title: "1. ФОТ", value: 894_510, comment: "( за вторую часть июля и первая часть августа)"))
        XCTAssertEqual("1. ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)".bodySymbol(for: Patterns.itemWithComment),
                       .item(title: "1. ФОТ", value: 1_147_085, comment: "( за вторую часть сентября и первую  часть октября)"))
        /// item with `math` and `comment` after number
        #warning("how to do this math?")
        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)".bodySymbol(for: Patterns.itemWithComment),
                       .item(title: "1. Аренда торгового помещения", value: 200_000+400_000, comment: "200.000 (за август) +400.000 (за сентябрь)"))
    }
}

