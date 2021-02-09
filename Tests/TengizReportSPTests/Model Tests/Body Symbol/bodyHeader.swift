//
//  bodyHeader.swift
//  TengizReportSPM
//
//  Created by Igor Malyarov on 09.02.2021.
//

import XCTest
@testable import TengizReportSP

extension BodySymbolPatternTests {
    func test_bodyHeader() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.bodyHeader, #"(?!ИТОГ)(?<title>^\D.*?):.*$"#)

        // MARK: match
        /*
         "Основные расходы:\t\t25%\t"
         "Основные расходы:\t\t25%\t8.95%"
         "Основные расходы:\t-----------------------------\t25%"
         "Зарплата:\t\t22%\t"
         "Фактический приход товара и оплата товара:\t\t25%\t"
         "Прочие расходы:\t\t8%\t"
         "Расходы на доставку:\t\t\t"
         */
        var input = "Основные расходы:\t\t25%\t"
        XCTAssertEqual(input.firstMatch(for: Patterns.bodyHeader), input)
        input = "Основные расходы:\t\t25%\t8.95%"
        XCTAssertEqual(input.firstMatch(for: Patterns.bodyHeader), input)
        input = "Основные расходы:\t-----------------------------\t25%"
        XCTAssertEqual(input.firstMatch(for: Patterns.bodyHeader), input)
        input = "Зарплата:\t\t22%\t"
        XCTAssertEqual(input.firstMatch(for: Patterns.bodyHeader), input)
        input = "Фактический приход товара и оплата товара:\t\t25%\t"
        XCTAssertEqual(input.firstMatch(for: Patterns.bodyHeader), input)
        input = "Прочие расходы:\t\t8%\t"
        XCTAssertEqual(input.firstMatch(for: Patterns.bodyHeader), input)
        input = "Расходы на доставку:\t\t\t"
        XCTAssertEqual(input.firstMatch(for: Patterns.bodyHeader), input)


        #warning("why next two do not fail???? but fail with 'bodyHeader()' func")
        input = "Основные расходы:        20%    8.95%"
        XCTAssertEqual(input.firstMatch(for: Patterns.bodyHeader),
                       input,
                       "Mind TAB and \t")
        input = "Основные расходы:    -----------------------------    25%"
        XCTAssertEqual(input.firstMatch(for: Patterns.bodyHeader),
                       input,
                       "Mind TAB and \t")

        // MARK: regex structure
        XCTAssertEqual(input.replaceFirstMatch(for: Patterns.bodyHeader, withGroup: "title"), "Основные расходы")
        XCTAssertNil(input.replaceFirstMatch(for: Patterns.bodyHeader, withGroup: "TITLE"), "No such group in pattern")

        // MARK: no match
        XCTAssertNil("ИТОГ:\t65.167".firstMatch(for: Patterns.bodyHeader),
                     "This is footer")
        XCTAssertNil("1.ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)\t\t".firstMatch(for: Patterns.bodyHeader),
                     "This is item")
    }
}

extension BodySymbolTests {
    func test_bodyHeader() {
        // MARK: match
        /*
         "Основные расходы:\t\t25%\t"
         "Основные расходы:\t\t25%\t8.95%"
         "Основные расходы:\t-----------------------------\t25%"
         "Зарплата:\t\t22%\t"
         "Фактический приход товара и оплата товара:\t\t25%\t"
         "Прочие расходы:\t\t8%\t"
         "Расходы на доставку:\t\t\t"
         */
        XCTAssertEqual("Основные расходы:\t\t25%\t".bodyHeader(),
                       .header(title: "Основные расходы", plan: 0.25, fact: nil))
        XCTAssertEqual("Основные расходы:\t\t25%\t8.95%".bodyHeader(),
                       .header(title: "Основные расходы", plan: 0.25, fact: 0.0895))
        XCTAssertEqual("Основные расходы:\t-----------------------------\t25%".bodyHeader(),
                       .header(title: "Основные расходы", plan: 0.25, fact: nil))

        XCTAssertEqual("Зарплата:\t\t22%\t".bodyHeader(),
                       .header(title: "Зарплата", plan: 0.22, fact: nil))
        XCTAssertEqual("Фактический приход товара и оплата товара:\t\t25%\t".bodyHeader(),
                       .header(title: "Фактический приход товара и оплата товара", plan: 0.25, fact: nil))
        XCTAssertEqual("Прочие расходы:\t\t8%\t".bodyHeader(),
                       .header(title: "Прочие расходы", plan: 0.08, fact: nil))
        XCTAssertEqual("Расходы на доставку:\t\t\t".bodyHeader(),
                       .header(title: "Расходы на доставку", plan: nil, fact: nil))

        // MARK: no match
        XCTAssertNil("Основные расходы:        20%    8.95%".bodyHeader(),
                     "Mind TAB and \t")
        XCTAssertNil("Основные расходы:    -----------------------------    25%".bodyHeader(),
                     "Mind TAB and \t")
        XCTAssertNil("ИТОГ:\t65.167".bodyHeader(),
                     "This is footer")
        XCTAssertNil("1.ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)\t\t".bodyHeader(),
                     "This is item")

    }

    func test_BodySymbol_init_header() {
        // MARK: match
        /*
         "Основные расходы:\t\t25%\t"
         "Основные расходы:\t\t25%\t8.95%"
         "Основные расходы:\t-----------------------------\t25%"
         "Зарплата:\t\t22%\t"
         "Фактический приход товара и оплата товара:\t\t25%\t"
         "Прочие расходы:\t\t8%\t"
         "Расходы на доставку:\t\t\t"
         */
        XCTAssertEqual(BodySymbol("Основные расходы:\t\t25%\t"),
                       .header(title: "Основные расходы", plan: 0.25, fact: nil))
        XCTAssertEqual(BodySymbol("Основные расходы:\t\t25%\t8.95%"),
                                    .header(title: "Основные расходы", plan: 0.25, fact: 0.0895))
        XCTAssertEqual(BodySymbol("Зарплата:\t\t22%\t"),
                       .header(title: "Зарплата", plan: 0.22, fact: nil))
        XCTAssertEqual(BodySymbol("Фактический приход товара и оплата товара:\t\t25%\t"),
                       .header(title: "Фактический приход товара и оплата товара", plan: 0.25, fact: nil))
        XCTAssertEqual(BodySymbol("Прочие расходы:\t\t8%\t"),
                       .header(title: "Прочие расходы", plan: 0.08, fact: nil))
        XCTAssertEqual(BodySymbol("Расходы на доставку:\t\t\t"),
                       .header(title: "Расходы на доставку", plan: nil, fact: nil))

        XCTAssertEqual(BodySymbol("Зарплата:\t\t22%"),
                       .header(title: "Зарплата", plan: Optional(0.22), fact: nil))

        var input = "Основные расходы:\t\t25%"
        XCTAssertEqual(BodySymbol(stringLiteral: input),
                       .header(title: "Основные расходы", plan: 0.25, fact: nil))

        input = "Основные расходы:\t\t25%\t8.76%"
        XCTAssertEqual(BodySymbol(stringLiteral: input),
                       .header(title: "Основные расходы", plan: 0.25, fact: 0.0876))

        input = "1.ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)\t\t"
        XCTAssertEqual(BodySymbol(stringLiteral: input), .empty, "Mind the TABs at the end")

        input = "1.ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"
        XCTAssertEqual(BodySymbol(stringLiteral: input),
                       .item(title: "1.ФОТ", value: 704848.0, comment: "( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"))

        XCTAssertNotEqual(Token<BodySymbol>(stringLiteral: input),
                          Token<BodySymbol>(source: input, symbol: .empty))
    }

}
