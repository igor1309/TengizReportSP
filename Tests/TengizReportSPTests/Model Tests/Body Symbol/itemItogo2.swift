//
//  itemItogo2.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 04.02.2021.
//

import XCTest
@testable import TengizReportSP

extension Patterns {
    /// also `itogo`
    static let itemItogo2 = #"(?<title>\#(bodyItemStart)\D+(?=\t))(?<comment>.*(?<value>(?<=Итого|фактический)\s*\#(Patterns.itemNumber)).*)"#
}

extension RegexPatternsTests {
    func test_itemItogo2() {
        XCTAssertEqual(Patterns.itemItogo2, "")

        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: Patterns.itemItogo2) }.count,
                       2, "Should be exactly 2 matches")

        XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе\t КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого 23.600".firstMatch(for: Patterns.itemItogo2),
                       "2. Предоплаченный товар, но не отраженный в приходе\t КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого 23.600")
        XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе\tБейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400".firstMatch(for: Patterns.itemItogo2),
                       "2. Предоплаченный товар, но не отраженный в приходе\tБейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400")
    }
}

extension BodySymbolFuncTests {
    func test_itemItogo2() {
        XCTAssertEqual(selectedBodyItems.compactMap { $0.bodySymbol(for: Patterns.itemItogo2) }.count,
                       2, "Should be exactly 2 matches")

        XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе\t КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого 23.600".bodySymbol(for: Patterns.itemItogo2),
                       .item(title: "2. Предоплаченный товар, но не отраженный в приходе", value: 23_600, comment: "КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого 23.600"))
        XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе\tБейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400".bodySymbol(for: Patterns.itemItogo2),
                       .item(title: "2. Предоплаченный товар, но не отраженный в приходе", value: 40_400, comment: "Бейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400"))
    }
}
