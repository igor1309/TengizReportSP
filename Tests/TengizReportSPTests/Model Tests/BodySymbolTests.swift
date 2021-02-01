//
//  BodySymbolTests.swift
//  TengizReportSPM
//
//  Created by Igor Malyarov on 30.01.2021.
//

import XCTest
@testable import TengizReportSP

extension BodySymbol {
    init(_ string: String) {
        self.init(stringLiteral: string)
    }
}

final class BodySymbolTests: XCTestCase {
    func testBodySymbolExpressibleByStringLiteral() {
        XCTAssertEqual(BodySymbol(""), .empty)
        XCTAssertEqual(BodySymbol("5. Аренда головного офиса\t11.500\t\t\n"), .item(title: "5. Аренда головного офиса", value: 11500.0, comment: nil))
    }

    func testBodySymbol_correction() {
        XCTAssertNil("6.Обслуживание кассовой программы Айко\t16.336".correction())

        XCTAssertEqual("-10.000 за перерасход питание персонала в июле".correction(),
                       .item(title: "Correction", value: -10_000, comment: "-10.000 за перерасход питание персонала в июле"))

        XCTAssertEqual(BodySymbol("-10.000 за перерасход питание персонала в июле"),
                       .item(title: "Correction", value: -10_000, comment: "-10.000 за перерасход питание персонала в июле"))
    }

    func testBodySymbol_withPlus() {
        XCTAssertNil("6.Обслуживание кассовой программы Айко\t16.336".withPlus())

        XCTAssertEqual("12.Интернет\t7.701+4.500".withPlus(),
                       .item(title: "12.Интернет", value: 12_201, comment: "7.701+4.500"))
        XCTAssertEqual("1. Аренда торгового помещения\t200.000 (за август) +400.000 (за сентябрь)\t".withPlus(),
                       .item(title: "1. Аренда торгового помещения", value: 600_000, comment: "200.000 (за август) +400.000 (за сентябрь)"))

        XCTAssertEqual(BodySymbol("12.Интернет\t7.701+4.500"),
                       .item(title: "12.Интернет", value: 12_201, comment: "7.701+4.500"))
        XCTAssertEqual(BodySymbol("1. Аренда торгового помещения\t200.000 (за август) +400.000 (за сентябрь)\t"),
                       .item(title: "1. Аренда торгового помещения", value: 600_000, comment: "200.000 (за август) +400.000 (за сентябрь)"))
    }

    func testBodySymbol_prihodWithItogo() {
        /// get sources
        let sourses = try? filenames
            .flatMap { filename in
                ReportContent(
                    stringLiteral: try filename
                        .contentsOfFile()
                        .clearReport()
                )
                .body
                .flatMap { $0.components(separatedBy: "\n") }
                .filter { nil != $0.firstMatch(for: "Приход") }
            }
        XCTAssertNotNil(sourses)

        XCTAssertNil("1. Приход товара по накладным\t451.198р41к (из них у нас оплачено фактический 21.346р15к)\t\t".prihodWithItogo())
        XCTAssertNil("6.Обслуживание кассовой программы Айко\t16.336".prihodWithItogo())

        XCTAssertEqual("1. Приход товара по накладным\t922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)".prihodWithItogo(),
                       .item(title: "1. Приход товара по накладным", value: 498_373.46, comment: "922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)"))
        XCTAssertEqual("1. Приход товара по накладным\t 753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)".prihodWithItogo(),
                       .item(title: "1. Приход товара по накладным", value: 521_519.36, comment: "753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)"))
        XCTAssertEqual("1. Приход товара по накладным\t 946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)".prihodWithItogo(),
                       .item(title: "1. Приход товара по накладным", value: 632_684.37, comment: "946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)"))
        XCTAssertEqual("1. Приход товара по накладным\t 907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)".prihodWithItogo(),
                       .item(title: "1. Приход товара по накладным", value: 628_215.74, comment: "907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)"))
        XCTAssertEqual("1. Приход товара по накладным\t 739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого 437.474р 47к)".prihodWithItogo(),
                       .item(title: "1. Приход товара по накладным", value: 437_474.47, comment: "739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого 437.474р 47к)"))
        XCTAssertEqual("1. Приход товара по накладным\t 997.446р; (оплаты фактические: 491.114р 65к -переводы; 114.589 -корпоративная карта; 12.170 -наличные из кассы; Итого 617.873р 65к)".prihodWithItogo(),
                       .item(title: "1. Приход товара по накладным", value: 617_873.65, comment: "997.446р; (оплаты фактические: 491.114р 65к -переводы; 114.589 -корпоративная карта; 12.170 -наличные из кассы; Итого 617.873р 65к)"))
        XCTAssertEqual("1. Приход товара по накладным\t179.108р 89к+512.293р(оплаты фактические:199.803р 80к-переводы;81.225р 35к-корпоративная карта;34.202р-наличные из кассы; Итого 315.231р 15к)".prihodWithItogo(),
                       .item(title: "1. Приход товара по накладным", value: 315_231.15, comment: "179.108р 89к+512.293р(оплаты фактические:199.803р 80к-переводы;81.225р 35к-корпоративная карта;34.202р-наличные из кассы; Итого 315.231р 15к)"))
        XCTAssertEqual("1. Приход товара по накладным\t473.128р 43к(оплаты фактические:231.572р 46к-переводы;51.104р 93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р 39к)".prihodWithItogo(),
                       .item(title: "1. Приход товара по накладным", value: 285_476.39, comment: "473.128р 43к(оплаты фактические:231.572р 46к-переводы;51.104р 93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р 39к)"))
    }

    func testBodySymbol_prepayWithItogo() {
        XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе\tБейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400".prepayWithItogo(),
                       .item(title: "2. Предоплаченный товар, но не отраженный в приходе", value: 40_400, comment: "Бейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400"))
        XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе\t КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого 23.600".prepayWithItogo(),
                       .item(title: "2. Предоплаченный товар, но не отраженный в приходе", value: 23_600, comment: "КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого 23.600"))

        XCTAssertNil("2. Предоплаченный товар, но не отраженный в приходе\tСтудиопак-12.500 (влажные салфетки);\t\t".prepayWithItogo())
    }

    func testBodySymbol_prepayNoItogo() throws {
        XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе\tСтудиопак-12.500 (влажные салфетки);\t\t".prepayNoItogo(),
                       .item(title: "2. Предоплаченный товар, но не отраженный в приходе", value: 12_500, comment: "Студиопак-12.500 (влажные салфетки);"))

        XCTAssertNil("2. Предоплаченный товар, но не отраженный в приходе    Бейсболки персонал-18.000; Подушки в зал-22.400; Итого-40.400".prepayNoItogo())
        XCTAssertNil("2. Предоплаченный товар, но не отраженный в приходе\tБейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400".prepayNoItogo())
        XCTAssertNil("2. Предоплаченный товар, но не отраженный в приходе\t КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого 23.600".prepayNoItogo())
    }

    func testBodySymbol_otherPatterns() {
        #warning("error in getting comment")
        XCTAssertEqual("1. Приход товара по накладным\t946.056р (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого-632.684р 37к)".otherPatterns(),
                       .item(title: "1. Приход товара по накладным", value: -632_684.37, comment: "946.056р (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого-632.684р 37к)"))

        XCTAssertEqual("1. Приход товара по накладным\t451.198р41к (из них у нас оплачено фактический 21.346р 15к)".otherPatterns(),
                       .item(title: "1. Приход товара по накладным", value: 21_346.15, comment: "451.198р41к (из них у нас оплачено фактический 21.346р 15к)"))
    }

    func testHelper_getFirstMatchAndRemains() {
        let patterns = [#"(?:\w+)\d+"#, #"(\w*)"#]

        "Обслуживание 500+500+15.995\t"
            .getFirstMatchAndRemains(patterns: patterns) { match, remains in
                XCTAssertEqual(match, "500")
                XCTAssertEqual(remains, "Обслуживание +500+15.995")
            }

        let itemTitlePatterns = [Patterns.itemTitleWithPercentage,
                                 Patterns.itemTitleWithParentheses,
                                 Patterns.itemTitle]

        "4.Банковская комиссия 1.6% за эквайринг\t31.587\t"
            .getFirstMatchAndRemains(patterns: itemTitlePatterns) { match, remains in
                XCTAssertEqual(match, "4.Банковская комиссия 1.6% за эквайринг")
                XCTAssertEqual(remains, "31.587")
            }

        "22. Хэдхантер (подбор пероснала)\t4.227\t"
            .getFirstMatchAndRemains(patterns: itemTitlePatterns) { match, remains in
                XCTAssertEqual(match, "22. Хэдхантер (подбор пероснала)")
                XCTAssertEqual(remains, "4.227")
            }

        "6.Обслуживание кассовой программы Айко\t8.435\t\t"
            .getFirstMatchAndRemains(patterns: itemTitlePatterns) { match, remains in
                XCTAssertEqual(match, "6.Обслуживание кассовой программы Айко")
                XCTAssertEqual(remains, "8.435")
            }

    }

}


final class BodySymbolPatternsTests: XCTestCase {
    func test_itemCorrectionLine() {
        XCTAssertNotNil("-10.000 за перерасход питание персонала в июле"
                            .firstMatch(for:Patterns.itemCorrectionLine))
        XCTAssertEqual("-10.000 за перерасход питание персонала в июле"
                        .firstMatch(for:Patterns.itemCorrectionLine),
                       "-10.000 за перерасход питание персонала в июле")
    }

    func test_itemTitle() {
        XCTAssertNotNil("1.ФОТ\t595.360 ( за первую часть ноября)\t"
                            .firstMatch(for:Patterns.itemTitle))
        XCTAssertEqual("1.ФОТ\t595.360 ( за первую часть ноября)\t"
                        .firstMatch(for:Patterns.itemTitle),
                       "1.ФОТ\t")
    }

    func test_itemWithPlus() {
        XCTAssertNotNil("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)\t\t\n"
                            .firstMatch(for:Patterns.itemWithPlus))
        XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)\t\t\n"
                        .firstMatch(for:Patterns.itemWithPlus),
                       "1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)\t\t\n")
    }

    func test_itemTitleWithPercentage() {
        XCTAssertNil("5. Аренда головного офиса\t"
                        .firstMatch(for:Patterns.itemTitleWithPercentage))
        XCTAssertNotNil("4.Банковская комиссия 1.6% за эквайринг\t\n"
                            .firstMatch(for:Patterns.itemTitleWithPercentage))
        XCTAssertEqual("4.Банковская комиссия 1.6% за эквайринг\t\n"
                        .firstMatch(for:Patterns.itemTitleWithPercentage),
                       "4.Банковская комиссия 1.6% за эквайринг\t\n")
    }

    func test_itemTitleWithParentheses() {
        XCTAssertNotNil("22. Хэдхантер (подбор пероснала)\t"
                            .firstMatch(for: Patterns.itemTitleWithParentheses))
        XCTAssertEqual("22. Хэдхантер (подбор пероснала)\t"
                        .firstMatch(for: Patterns.itemTitleWithParentheses),
                       "22. Хэдхантер (подбор пероснала)\t")

    }

    func test_numbersWithPlus() {
        XCTAssertNotNil("200.000 (за август) +400.000 (за сентябрь)"
                            .firstMatch(for:Patterns.numbersWithPlus))
        XCTAssertNotNil("7.701+4.500"
                            .firstMatch(for:Patterns.numbersWithPlus))
        XCTAssertNotNil("7.701+4.500+12.400"
                            .firstMatch(for:Patterns.numbersWithPlus))

        XCTAssertEqual("200.000 (за август) +400.000 (за сентябрь)"
                        .firstMatch(for:Patterns.numbersWithPlus),
                       "200.000 (за август) +400.000 (за сентябрь)")
        XCTAssertEqual("7.701+4.500"
                        .firstMatch(for:Patterns.numbersWithPlus),
                       "7.701+4.500")
        XCTAssertEqual("7.701+4.500+12.400"
                        .firstMatch(for:Patterns.numbersWithPlus),
                       "7.701+4.500+12.400")
    }

    func test_itemWithItogoPattern() {
        /// special case when number after item title is not a number for item
        /// for example in `"1. Приход товара по накладным\t946.056р (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого-632.684р 37к)"`
        XCTAssertNotNil("1. Приход товара по накладным\t946.056р (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого-632.684р 37к)".firstMatch(for: Patterns.itogo))
    }

    func test_prihod() {
        let sources = try? filenames
            .flatMap { filename in
                ReportContent(
                    stringLiteral: try filename
                        .contentsOfFile()
                        .clearReport()
                )
                .body
                .flatMap { $0.components(separatedBy: "\n") }
                .filter { $0.firstMatch(for: Patterns.prihod) != nil }
            }
        // XCTAssertNil(sources)
        sources?.forEach {
            XCTAssertNotNil($0.firstMatch(for: Patterns.prihod))
        }

        XCTAssertNotNil("1. Приход товара по накладным\t451.198р 41к (из них у нас оплачено фактический 21.346р 15к)".firstMatch(for: Patterns.prihod))
        XCTAssertNotNil("1. Приход товара по накладным\t922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)".firstMatch(for: Patterns.prihod))
        XCTAssertNotNil("1. Приход товара по накладным\t 753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)".firstMatch(for: Patterns.prihod))
        XCTAssertNotNil("1. Приход товара по накладным\t 946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)".firstMatch(for: Patterns.prihod))
        XCTAssertNotNil("1. Приход товара по накладным\t 907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)".firstMatch(for: Patterns.prihod))
        XCTAssertNotNil("1. Приход товара по накладным\t 739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого 437.474р 47к)".firstMatch(for: Patterns.prihod))
        XCTAssertNotNil("1. Приход товара по накладным\t 997.446р; (оплаты фактические: 491.114р 65к -переводы; 114.589 -корпоративная карта; 12.170 -наличные из кассы; Итого 617.873р 65к)".firstMatch(for: Patterns.prihod))
        XCTAssertNotNil("1. Приход товара по накладным\t179.108р 89к+512.293р(оплаты фактические:199.803р 80к-переводы;81.225р 35к-корпоративная карта;34.202р-наличные из кассы; Итого 315.231р 15к)".firstMatch(for: Patterns.prihod))
        XCTAssertNotNil("1. Приход товара по накладным\t473.128р 43к(оплаты фактические:231.572р 46к-переводы;51.104р 93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р 39к)".firstMatch(for: Patterns.prihod))
    }


    func test_prihodWithItogo() {
        let sources = try? filenames
            .flatMap { filename in
                ReportContent(
                    stringLiteral: try filename
                        .contentsOfFile()
                        .clearReport()
                )
                .body
                .flatMap { $0.components(separatedBy: "\n") }
                .filter { $0.firstMatch(for: "Приход") != nil }
            }
         XCTAssertNotNil(sources)
//        sources?.forEach {
//            XCTAssertNotNil($0.firstMatch(for: Patterns.prihodWithItogo))
//        }

        XCTAssertNil("1. Приход товара по накладным\t451.198р 41к (из них у нас оплачено фактический 21.346р 15к)".firstMatch(for: Patterns.prihodWithItogo))

        XCTAssertNotNil("1. Приход товара по накладным\t922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)".firstMatch(for: Patterns.prihodWithItogo))
        XCTAssertNotNil("1. Приход товара по накладным\t 753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)".firstMatch(for: Patterns.prihodWithItogo))
        XCTAssertNotNil("1. Приход товара по накладным\t 946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)".firstMatch(for: Patterns.prihodWithItogo))
        XCTAssertNotNil("1. Приход товара по накладным\t 907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)".firstMatch(for: Patterns.prihodWithItogo))
        XCTAssertNotNil("1. Приход товара по накладным\t 739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого 437.474р 47к)".firstMatch(for: Patterns.prihodWithItogo))
        XCTAssertNotNil("1. Приход товара по накладным\t 997.446р; (оплаты фактические: 491.114р 65к -переводы; 114.589 -корпоративная карта; 12.170 -наличные из кассы; Итого 617.873р 65к)".firstMatch(for: Patterns.prihodWithItogo))
        XCTAssertNotNil("1. Приход товара по накладным\t179.108р 89к+512.293р(оплаты фактические:199.803р 80к-переводы;81.225р 35к-корпоративная карта;34.202р-наличные из кассы; Итого 315.231р 15к)".firstMatch(for: Patterns.prihodWithItogo))
        XCTAssertNotNil("1. Приход товара по накладным\t473.128р 43к(оплаты фактические:231.572р 46к-переводы;51.104р 93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р 39к)".firstMatch(for: Patterns.prihodWithItogo))
    }

    func test_prepayWithItogo() {
        XCTAssertNotNil("2. Предоплаченный товар, но не отраженный в приходе    Бейсболки персонал-18.000; Подушки в зал-22.400; Итого-40.400".firstMatch(for: Patterns.prepayWithItogo))
        XCTAssertNotNil("2. Предоплаченный товар, но не отраженный в приходе     КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого-23.600".firstMatch(for: Patterns.prepayWithItogo))

        XCTAssertNil("26. Новогодний декор\t169.702\t\t".firstMatch(for: Patterns.prepayWithItogo))
        XCTAssertNil("2. Предоплаченный товар, но не отраженный в приходе\tСтудиопак-12.500 (влажные салфетки);".firstMatch(for: Patterns.prepayWithItogo))
        XCTAssertNil("2. Предоплаченный товар, но не отраженный в приходе\t".firstMatch(for: Patterns.prepayWithItogo))
        XCTAssertNil("2. Предоплаченный товар, но не отраженный в приходе\t--------------".firstMatch(for: Patterns.prepayWithItogo))
    }

    func test_prepayNoItogo() {
        XCTAssertNil("26. Новогодний декор\t169.702\t\t".firstMatch(for: Patterns.prepayNoItogo))
        XCTAssertNil("2. Предоплаченный товар, но не отраженный в приходе    Бейсболки персонал-18.000; Подушки в зал-22.400; Итого-40.400".firstMatch(for: Patterns.prepayNoItogo))
        XCTAssertNil("2. Предоплаченный товар, но не отраженный в приходе     КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого-23.600".firstMatch(for: Patterns.prepayNoItogo))

        XCTAssertNotNil("2. Предоплаченный товар, но не отраженный в приходе\tСтудиопак-12.500 (влажные салфетки);".firstMatch(for: Patterns.prepayNoItogo))
        XCTAssertNotNil("2. Предоплаченный товар, но не отраженный в приходе\t".firstMatch(for: Patterns.prepayNoItogo))
        XCTAssertNotNil("2. Предоплаченный товар, но не отраженный в приходе\t--------------".firstMatch(for: Patterns.prepayNoItogo))
    }

    func test_factPattern() {
        /// another special case when number after item title is not a number for item
        /// for example in `"1. Приход товара по накладным\t451.198р41к (из них у нас оплачено фактический 21.346р15к)"`
        XCTAssertNotNil("1. Приход товара по накладным\t451.198р41к (из них у нас оплачено фактический 21.346р15к)".firstMatch(for: Patterns.factPattern))
    }

}
