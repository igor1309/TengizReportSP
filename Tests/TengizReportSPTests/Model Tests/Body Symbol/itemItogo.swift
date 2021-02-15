//
//  itemItogo.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 04.02.2021.
//

import XCTest
@testable import Model

extension RegexPatternsTests {
    func test_itemItogo() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.itemItogo, #"^(?<itemNo>\d\d?)\.\s*(?<title>.+?)(?:\t\s*)(?:\t\t)?(?<note>.*(?<value>(?<=Итого|фактический)\s*\d{1,3}(?:\.\d{3})*(?:р ?\d\d?к)?).*)"#)

        // MARK: count in selectedBodyItems
        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: Patterns.itemItogo) }.count,
                       12, "Should be exactly 12 matches")

        // MARK: match
        XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе\tСтудиопак Итого 12.500 (влажные салфетки);".firstMatch(for: Patterns.itemItogo),
                       "2. Предоплаченный товар, но не отраженный в приходе\tСтудиопак Итого 12.500 (влажные салфетки);")

        XCTAssertEqual("1. Приход товара по накладным\t922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)".firstMatch(for: Patterns.itemItogo),
                       "1. Приход товара по накладным\t922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)",
                       "test differ in '498.373р 46к' vs '498.373р46к'")
        XCTAssertEqual("1. Приход товара по накладным\t922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р46к)".firstMatch(for: Patterns.itemItogo),
                       "1. Приход товара по накладным\t922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р46к)",
                       "test differ in '498.373р 46к' vs '498.373р46к'")

        XCTAssertEqual("1. Приход товара по накладным\t 753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)".firstMatch(for: Patterns.itemItogo),
                       "1. Приход товара по накладным\t 753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)")
        XCTAssertEqual("1. Приход товара по накладным\t 946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)".firstMatch(for: Patterns.itemItogo),
                       "1. Приход товара по накладным\t 946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)")
        XCTAssertEqual("1. Приход товара по накладным\t 907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)".firstMatch(for: Patterns.itemItogo),
                       "1. Приход товара по накладным\t 907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)")
        XCTAssertEqual("1. Приход товара по накладным\t 739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого 437.474р 47к)".firstMatch(for: Patterns.itemItogo),
                       "1. Приход товара по накладным\t 739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого 437.474р 47к)")
        XCTAssertEqual("1. Приход товара по накладным\t 997.446р; (оплаты фактические: 491.114р 65к -переводы; 114.589 -корпоративная карта; 12.170 -наличные из кассы; Итого 617.873р 65к)".firstMatch(for: Patterns.itemItogo),
                       "1. Приход товара по накладным\t 997.446р; (оплаты фактические: 491.114р 65к -переводы; 114.589 -корпоративная карта; 12.170 -наличные из кассы; Итого 617.873р 65к)")
        XCTAssertEqual("1. Приход товара по накладным\t179.108р 89к+512.293р(оплаты фактические:199.803р 80к-переводы;81.225р 35к-корпоративная карта;34.202р-наличные из кассы; Итого 315.231р 15к)".firstMatch(for: Patterns.itemItogo),
                       "1. Приход товара по накладным\t179.108р 89к+512.293р(оплаты фактические:199.803р 80к-переводы;81.225р 35к-корпоративная карта;34.202р-наличные из кассы; Итого 315.231р 15к)")
        XCTAssertEqual("1. Приход товара по накладным\t473.128р 43к(оплаты фактические:231.572р 46к-переводы;51.104р 93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р 39к)".firstMatch(for: Patterns.itemItogo),
                       "1. Приход товара по накладным\t473.128р 43к(оплаты фактические:231.572р 46к-переводы;51.104р 93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р 39к)")
        /// regex: `фактический` or `Итого`
        XCTAssertEqual("1. Приход товара по накладным\t451.198р 41к (из них у нас оплачено фактический 21.346р 15к)".firstMatch(for: Patterns.itemItogo),
                       "1. Приход товара по накладным\t451.198р 41к (из них у нас оплачено фактический 21.346р 15к)")

        XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе\t КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого 23.600".firstMatch(for: Patterns.itemItogo),
                       "2. Предоплаченный товар, но не отраженный в приходе\t КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого 23.600")
        XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе\tБейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400".firstMatch(for: Patterns.itemItogo),
                       "2. Предоплаченный товар, но не отраженный в приходе\tБейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400")

        // MARK: regex structure
        XCTAssertEqual("1. Приход товара по накладным\t922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)"
                        .replaceFirstMatch(for: Patterns.itemItogo, withGroup: "itemNo"),
                       "1")
        XCTAssertEqual("1. Приход товара по накладным\t922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)"
                        .replaceFirstMatch(for: Patterns.itemItogo, withGroup: "title"),
                       "Приход товара по накладным")
        XCTAssertEqual("1. Приход товара по накладным\t922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)"
                        .replaceFirstMatch(for: Patterns.itemItogo, withGroup: "value"),
                       " 498.373р 46к")
        XCTAssertEqual("1. Приход товара по накладным\t922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)"
                        .replaceFirstMatch(for: Patterns.itemItogo, withGroup: "value")?
                        .rubliKopeikiToDouble(),
                       498_373.46)
        XCTAssertEqual("1. Приход товара по накладным\t922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)"
                        .replaceFirstMatch(for: Patterns.itemItogo, withGroup: "value")?
                        .numberWithSign(),
                       498_373.46)
        XCTAssertEqual("1. Приход товара по накладным\t922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)"
                        .replaceFirstMatch(for: Patterns.itemItogo, withGroup: "note"),
                       "922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)")
    }
}

extension BodySymbolFuncTests {
    func test_itemItogo() {
        XCTAssertEqual(selectedBodyItems.compactMap { $0.bodySymbol(for: Patterns.itemItogo) }.count,
                       12, "Should be exactly 12 matches")

        // due to .replaceMatches(for: "Студиопак-", withString: "Студиопак Итого ") in func clearReport()
        XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе\tСтудиопак Итого 12.500 (влажные салфетки);".bodySymbol(for: Patterns.itemItogo),
                       .item(itemNumber: 2, title: "Предоплаченный товар, но не отраженный в приходе", value: 12_500, note: "Студиопак Итого 12.500 (влажные салфетки);"))

        XCTAssertEqual("1. Приход товара по накладным\t922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)".bodySymbol(for: Patterns.itemItogo),
                       .item(itemNumber: 1, title: "Приход товара по накладным", value: 498_373.46, note: "922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)"))
        XCTAssertEqual("1. Приход товара по накладным\t 753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)".bodySymbol(for: Patterns.itemItogo),
                       .item(itemNumber: 1, title: "Приход товара по накладным", value: 521_519.36, note: "753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)"))
        XCTAssertEqual("1. Приход товара по накладным\t 946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)".bodySymbol(for: Patterns.itemItogo),
                       .item(itemNumber: 1, title: "Приход товара по накладным", value: 632_684.37, note: "946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)"))
        XCTAssertEqual("1. Приход товара по накладным\t 907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)".bodySymbol(for: Patterns.itemItogo),
                       .item(itemNumber: 1, title: "Приход товара по накладным", value: 628_215.74, note: "907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)"))
        XCTAssertEqual("1. Приход товара по накладным\t 739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого 437.474р 47к)".bodySymbol(for: Patterns.itemItogo),
                       .item(itemNumber: 1, title: "Приход товара по накладным", value: 437_474.47, note: "739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого 437.474р 47к)"))
        XCTAssertEqual("1. Приход товара по накладным\t 997.446р; (оплаты фактические: 491.114р 65к -переводы; 114.589 -корпоративная карта; 12.170 -наличные из кассы; Итого 617.873р 65к)".bodySymbol(for: Patterns.itemItogo),
                       .item(itemNumber: 1, title: "Приход товара по накладным", value: 617_873.65, note: "997.446р; (оплаты фактические: 491.114р 65к -переводы; 114.589 -корпоративная карта; 12.170 -наличные из кассы; Итого 617.873р 65к)"))
        XCTAssertEqual("1. Приход товара по накладным\t179.108р 89к+512.293р(оплаты фактические:199.803р 80к-переводы;81.225р 35к-корпоративная карта;34.202р-наличные из кассы; Итого 315.231р 15к)".bodySymbol(for: Patterns.itemItogo),
                       .item(itemNumber: 1, title: "Приход товара по накладным", value: 315_231.15, note: "179.108р 89к+512.293р(оплаты фактические:199.803р 80к-переводы;81.225р 35к-корпоративная карта;34.202р-наличные из кассы; Итого 315.231р 15к)"))
        XCTAssertEqual("1. Приход товара по накладным\t473.128р 43к(оплаты фактические:231.572р 46к-переводы;51.104р 93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р 39к)".bodySymbol(for: Patterns.itemItogo),
                       .item(itemNumber: 1, title: "Приход товара по накладным", value: 285_476.39, note: "473.128р 43к(оплаты фактические:231.572р 46к-переводы;51.104р 93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р 39к)"))

        /// regex: `фактический` or `Итого`
        XCTAssertEqual("1. Приход товара по накладным\t451.198р 41к (из них у нас оплачено фактический 21.346р 15к)".bodySymbol(for: Patterns.itemItogo),
                       .item(itemNumber: 1, title: "Приход товара по накладным", value: 21_346.15, note: "451.198р 41к (из них у нас оплачено фактический 21.346р 15к)"))

        /// also `itogo`
        XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе\t КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого 23.600".bodySymbol(for: Patterns.itemItogo),
                       .item(itemNumber: 2, title: "Предоплаченный товар, но не отраженный в приходе", value: 23_600, note: "КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого 23.600"))
        XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе\tБейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400".bodySymbol(for: Patterns.itemItogo),
                       .item(itemNumber: 2, title: "Предоплаченный товар, но не отраженный в приходе", value: 40_400, note: "Бейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400"))

    }
}
