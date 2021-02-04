//
//  BodySymbolTests_Experimental.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 03.02.2021.
//

import XCTest
@testable import TengizReportSP

extension String {
    func bodySymbol(for pattern: String) -> BodySymbol? {
        guard firstMatch(for: pattern) != nil else { return nil }
        guard let title = replaceFirstMatch(for: pattern, withString: "$1")?
                .trimmingCharacters(in: .whitespaces) else { return nil }
        guard let valueStr = replaceFirstMatch(for: pattern, withString: "$2"),
              let value = valueStr.numberWithSign() else { return nil }

        let comment = replaceFirstMatch(for: pattern, withString: "$3")?
            .trimmingCharacters(in: .whitespaces) ?? ""

        return .item(title: title, value: value, comment: comment.isEmpty ? nil : comment)
    }

    func replaceFirstMatch(for pattern: String, withGroup groupName: String) -> String? {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return nil }

        let range = NSRange(self.startIndex..., in: self)
        let match = regex.firstMatch(in: self, options: [], range: range)

        if let match = match,
           let groupRange = Range(match.range(withName: groupName), in: self) {
            return String(self[groupRange])
        } else {
            return nil
        }
    }
}

extension RegexStringExtTests {
    func test_replaceFirstMatch_withGroup() {
        let input = "1. Аренда торгового помещения\t46.667 (за июнь)"

        XCTAssertEqual(input.replaceFirstMatch(for: #"(?<title>\w{6})"#, withGroup: "title"),
                       "Аренда")
        XCTAssertEqual(input.replaceFirstMatch(for: #"^\d+\.\D+(?<number>\d{1,3}(?:\.\d{3})*)\D*$"#, withGroup: "number"),
                       "46.667")
        XCTAssertEqual(input.replaceFirstMatch(for: #"(?<number>мещен)"#, withGroup: "number"),
                       "мещен")

        XCTAssertNil(input.replaceFirstMatch(for: #"(?<number>мещен)"#, withGroup: "title"),
                     "Matching to non-existing group")
    }
}

final class BodySymbolFuncTests: XCTestCase {
    func test_func_bodySymbol() {
        let input = "1. Аренда торгового помещения\t46.667 (за июнь)"
        let pattern = #"(^\d+\.\D+)(\d{1,3}(?:\.\d{3})*)(.*)$"#

        XCTAssertEqual(input.replaceFirstMatch(for: pattern, withString: "$1")?
                        .trimmingCharacters(in: .whitespaces),
                       "1. Аренда торгового помещения")
        XCTAssertEqual(input.replaceFirstMatch(for: pattern, withString: "$2"),
                       "46.667")
        XCTAssertEqual(input.replaceFirstMatch(for: pattern, withString: "$3")?
                        .trimmingCharacters(in: .whitespaces),
                       "(за июнь)")

        XCTAssertEqual(input.bodySymbol(for: pattern),
                       .item(title: "1. Аренда торгового помещения", value: 46_667, comment: "(за июнь)"))

        let pattern2 = #"(^\d+\.\D+)(\d{1,3}(?:\.\d{3})*).*$"#
        XCTAssertEqual(input.replaceFirstMatch(for: pattern2, withString: "$3")?
                        .trimmingCharacters(in: .whitespaces),
                       "", "Capturing non-existing group (just 2 groups in regex '\(pattern2)')")

        XCTAssertEqual(input.bodySymbol(for: pattern2),
                       .item(title: "1. Аренда торгового помещения", value: 46_667, comment: nil))
    }

    func testRegexGroupName() {
        let input = "1. Аренда торгового помещения\t46.667 (за июнь)"
        let pattern = #"(?<title>^\d+\.\D+)(?<value>\d{1,3}(?:\.\d{3})*)(?<comment>.*)$"#

        XCTAssertEqual(input.replaceFirstMatch(for: pattern, withGroup: "title")?
                        .trimmingCharacters(in: .whitespaces),
                       "1. Аренда торгового помещения")
        XCTAssertEqual(input.replaceFirstMatch(for: pattern, withGroup: "value"),
                       "46.667")
        XCTAssertEqual(input.replaceFirstMatch(for: pattern, withGroup: "comment")?
                        .trimmingCharacters(in: .whitespaces),
                       "(за июнь)")
    }
}

final class BodySymbolTests_Experimental: XCTestCase {
    func test_GetSources() {
        let sourses = try? filenames
            .flatMap { filename in
                ReportContent(
                    stringLiteral: try filename
                        .contentsOfFile()
                        .clearReport()
                )
                .body
                .flatMap { $0.components(separatedBy: "\n") }
                //.filter { nil != $0.firstMatch(for: "Приход") }
            }
        XCTAssertEqual(sourses, [])
    }

    let bodyItemStart = #"^\d+\."#
    func test_bodyItemStart() {
        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: bodyItemStart) }.count,
                       33, "Total is 34, 'Correction' item line doesn't start with digits, so should be 33")
        XCTAssertEqual(bodyItems.count, 340)
        XCTAssertEqual(selectedBodyItems.count, 34)

        //XCTAssertNil(selectedBodyItems.joined(separator: "\n"))
    }

    func test_itemNoNumber() {
        /// `itemNoNumber`: title without number, should return .empty
        let itemNoNumber = #"\#(bodyItemStart)((?!\d).)*$"#
        _ = {
            XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: itemNoNumber) }.count,
                           2, "Should be exactly 2 matches")
            XCTAssertEqual("1. Аренда торгового помещения\t-----------------------------".firstMatch(for: itemNoNumber),
                           "1. Аренда торгового помещения\t-----------------------------")
            XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе".firstMatch(for: itemNoNumber),
                           "2. Предоплаченный товар, но не отраженный в приходе")
            XCTAssertNil("5. Аренда головного офиса\t11.500".firstMatch(for: itemNoNumber))
            XCTAssertNil("4. Банковская комиссия 1.6% за эквайринг\t2.120".firstMatch(for: itemNoNumber))
            XCTAssertNil("-10.000 за перерасход питание персонала в июле".firstMatch(for: itemNoNumber))
            XCTAssertNil("12. Интернет\t7.701+4.500".firstMatch(for: itemNoNumber))
            XCTAssertNil("27. Сервис Гуру (система аттестации, за 1 год)\t12.655".firstMatch(for: itemNoNumber))
        }()

        /// `itemSimple`: item title and number, no itogo, no number inside parantheses, no %, no comment after number
        let itemSimple = #"(\#(bodyItemStart)\D+)(\#(Patterns.itemNumber))$"#
        //XCTAssertEqual(itemSimple, "")
        _ = {
            XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: itemSimple) }.count,
                           6, "Should be matching exactly 6 samples from 'selectedBodyItems'")
            XCTAssertEqual("5. Аренда головного офиса\t11.500".firstMatch(for: itemSimple),
                           "5. Аренда головного офиса\t11.500")
            XCTAssertEqual("16. Текущие мелкие расходы \t1.200".firstMatch(for: itemSimple),
                           "16. Текущие мелкие расходы \t1.200")
            XCTAssertEqual("14. Контур (эл.отчетность)\t3.000".firstMatch(for: itemSimple),
                           "14. Контур (эл.отчетность)\t3.000")
            XCTAssertEqual("22. Хэдхантер (подбор пероснала)\t3.240".firstMatch(for: itemSimple),
                           "22. Хэдхантер (подбор пероснала)\t3.240")
            XCTAssertEqual("23. Аудит кантора (Бухуслуги)\t60.000".firstMatch(for: itemSimple),
                           "23. Аудит кантора (Бухуслуги)\t60.000")
            XCTAssertEqual("14. РПК Ника (крепления д/телевизоров и монтаж)\t30.000".firstMatch(for: itemSimple),
                           "14. РПК Ника (крепления д/телевизоров и монтаж)\t30.000")

            XCTAssertNil("27. Сервис Гуру (система аттестации, за 1 год)\t12.655".firstMatch(for: itemSimple), "Number match fail due to number inside parentheses")

            XCTAssertEqual("5. Аренда головного офиса\t11.500".bodySymbol(for: itemSimple),
                           .item(title: "5. Аренда головного офиса", value: 11_500, comment: nil))
            XCTAssertEqual("16. Текущие мелкие расходы \t1.200".bodySymbol(for: itemSimple),
                           .item(title: "16. Текущие мелкие расходы", value: 1_200, comment: nil))
            XCTAssertEqual("14. Контур (эл.отчетность)\t3.000".bodySymbol(for: itemSimple),
                           .item(title: "14. Контур (эл.отчетность)", value: 3_000, comment: nil))
            XCTAssertEqual("22. Хэдхантер (подбор пероснала)\t3.240".bodySymbol(for: itemSimple),
                           .item(title: "22. Хэдхантер (подбор пероснала)", value: 3_240, comment: nil))
            XCTAssertEqual("23. Аудит кантора (Бухуслуги)\t60.000".bodySymbol(for: itemSimple),
                           .item(title: "23. Аудит кантора (Бухуслуги)", value: 60_000, comment: nil))
            XCTAssertEqual("14. РПК Ника (крепления д/телевизоров и монтаж)\t30.000".bodySymbol(for: itemSimple),
                           .item(title: "14. РПК Ника (крепления д/телевизоров и монтаж)", value: 30_000, comment: nil))
        }()
    }

    func test_itemMath() {
        XCTAssertEqual("4.500+8.700+15.995".numberWithSign(), 4_500+8_700+15_995)

        /// `itemMath`
        let itemMath = #"(\#(bodyItemStart)\D+)(\#(Patterns.itemNumber)(?:\+\#(Patterns.itemNumber))+)$"#
        // XCTAssertEqual(itemMath, "")
        _ = {
            XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: itemMath) }.count,
                           2, "Should be exactly 2 matches")
            XCTAssertEqual("12. Интернет\t7.701+4.500".firstMatch(for: itemMath),
                           "12. Интернет\t7.701+4.500")
            XCTAssertEqual("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995".firstMatch(for: itemMath),
                           "6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995")

            XCTAssertEqual("12. Интернет\t7.701+4.500".bodySymbol(for: itemMath),
                           .item(title: "12. Интернет", value: 12_201, comment: nil))
            XCTAssertEqual("6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995".bodySymbol(for: itemMath),
                           .item(title: "6. Обслуживание кассовой программы Айко", value: 4_500+8_700+15_995, comment: nil))
        }()
    }

    func test_ideas() {
        #warning("test bodySymbol() func")
        /// item with digits and `percentage` inside item title
        let itemPercentage = #"\#(bodyItemStart).*?%.*$"#
        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: itemPercentage) }.count,
                       1, "Should be exactly 1 match")
        XCTAssertNotNil("4. Банковская комиссия 1.6% за эквайринг\t2.120".firstMatch(for: itemPercentage))
        // itemPercentage Title
        let itemPercentageTitle = #"\#(bodyItemStart).*?%.*\D$"#
        XCTAssertNotEqual("4. Банковская комиссия 1.6% за эквайринг\t2.120".firstMatch(for: itemPercentageTitle),
                          "4. Банковская комиссия 1.6% за эквайринг")
    }

    func test_itemNumberInsideParentheses() {
        /// `itemNumberInsideParentheses`: item with number inside parentheses
        let itemNumberInsideParentheses      = #"(^\d+\..*\(.*\d.*\))\s*(\d{1,3}(?:\.\d{3}))$"#
        //XCTAssertEqual(itemNumberInsideParentheses, "")
        _ = {
            XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: itemNumberInsideParentheses) }.count,
                           1, "Should be exactly 1 match")
            XCTAssertEqual("27. Сервис Гуру (система аттестации, за 1 год)\t12.655".firstMatch(for: itemNumberInsideParentheses),
                           "27. Сервис Гуру (система аттестации, за 1 год)\t12.655")
            XCTAssertEqual("27. Сервис Гуру (система аттестации, за 1 год)\t12.655".bodySymbol(for: itemNumberInsideParentheses),
                           .item(title: "27. Сервис Гуру (система аттестации, за 1 год)", value: 12_655, comment: nil))
        }
    }

    func test_itemWithComment() {
        /// item with `comment` after number, floating whitespace
        let itemWithComment = #"^(\d+\.\D+)(\d{1,3}(?:\.\d{3})*)(\s*\(.+\))$"#
        // #"(\#(bodyItemStart)\D+)(\#(Patterns.itemNumber))(.+)$"# //#"\#(bodyItemStart)\d*.*\(((?!Итого|фактический).)+\)$"#
        XCTAssertEqual(itemWithComment, "")
        _ = {
            XCTAssertNil("1. Приход товара по накладным\t 946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)".firstMatch(for: itemWithComment))

            XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: itemWithComment) }.count,
                           9, "Should be exactly 9 matches")

            XCTAssertEqual("1. Аренда торгового помещения\t46.667 (за июнь)".firstMatch(for: itemWithComment),
                           "1. Аренда торгового помещения\t46.667 (за июнь)")
            XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за июль)".firstMatch(for: itemWithComment),
                           "1. Аренда торгового помещения\t 200.000 (за июль)")
            XCTAssertEqual("1. ФОТ\t 564.678( за вторую часть октября)".firstMatch(for: itemWithComment),
                           "1. ФОТ\t 564.678( за вторую часть октября)")
            XCTAssertEqual("1. ФОТ\t595.360 ( за первую часть ноября)".firstMatch(for: itemWithComment),
                           "1. ФОТ\t595.360 ( за первую часть ноября)")
            /// have `numbers` inside parentheses (inside comment)
            XCTAssertEqual("1. ФОТ\t19.721 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)".firstMatch(for: itemWithComment),
                           "1. ФОТ\t19.721 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)")
            XCTAssertEqual("1. ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)".firstMatch(for: itemWithComment),
                           "1. ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)")
            XCTAssertEqual("1. ФОТ\t 894.510( за вторую часть июля и первая часть августа)".firstMatch(for: itemWithComment),
                           "1. ФОТ\t 894.510( за вторую часть июля и первая часть августа)")
            XCTAssertEqual("1. ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)".firstMatch(for: itemWithComment),
                           "1. ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)")
            /// item with `math` and `comment` after number
            XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)".firstMatch(for: itemWithComment),
                           "1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)")


            XCTAssertEqual("1. Аренда торгового помещения\t46.667 (за июнь)".bodySymbol(for: itemWithComment),
                           .item(title: "1. Аренда торгового помещения", value: 46_667, comment: "(за июнь)"))
            XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за июль)".bodySymbol(for: itemWithComment),
                           .item(title: "1. Аренда торгового помещения", value: 200_000, comment: "(за июль)"))
            XCTAssertEqual("1. ФОТ\t 564.678( за вторую часть октября)".bodySymbol(for: itemWithComment),
                           .item(title: "1. ФОТ", value: 564_678, comment: "( за вторую часть октября)"))
            XCTAssertEqual("1. ФОТ\t595.360 ( за первую часть ноября)".bodySymbol(for: itemWithComment),
                           .item(title: "1. ФОТ", value: 595_360, comment: "( за первую часть ноября)"))
            /// have `numbers` inside parentheses (inside comment)
            XCTAssertEqual("1. ФОТ\t19.721 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)".bodySymbol(for: itemWithComment),
                           .item(title: "1. ФОТ", value: 19_721, comment: "( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"))
            XCTAssertEqual("1. ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)".bodySymbol(for: itemWithComment),
                           .item(title: "1. ФОТ", value: 704_848, comment: "( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"))
            XCTAssertEqual("1. ФОТ\t 894.510( за вторую часть июля и первая часть августа)".bodySymbol(for: itemWithComment),
                           .item(title: "1. ФОТ", value: 894_510, comment: "( за вторую часть июля и первая часть августа)"))
            XCTAssertEqual("1. ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)".bodySymbol(for: itemWithComment),
                           .item(title: "1. ФОТ", value: 1_147_085, comment: "( за вторую часть сентября и первую  часть октября)"))
            /// item with `math` and `comment` after number
            XCTAssertEqual("1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)".bodySymbol(for: itemWithComment),
                           .item(title: "1. Аренда торгового помещения", value: 200_000+400_000, comment: "200.000 (за август) +400.000 (за сентябрь)"))
        }()









        /// `itogo`
        let itemItogo = #"\#(bodyItemStart).*(?=Итого).*$"#
        _ = {
            XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: itemItogo) }.count,
                           11, "Should be exactly 11 matches")

            XCTAssertEqual("1. Приход товара по накладным\t922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)".firstMatch(for: itemItogo),
                           "1. Приход товара по накладным\t922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)")
            XCTAssertEqual("1. Приход товара по накладным\t 753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)".firstMatch(for: itemItogo),
                           "1. Приход товара по накладным\t 753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)")
            XCTAssertEqual("1. Приход товара по накладным\t 946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)".firstMatch(for: itemItogo),
                           "1. Приход товара по накладным\t 946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)")
            XCTAssertEqual("1. Приход товара по накладным\t 907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)".firstMatch(for: itemItogo),
                           "1. Приход товара по накладным\t 907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)")
            XCTAssertEqual("1. Приход товара по накладным\t 739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого 437.474р 47к)".firstMatch(for: itemItogo),
                           "1. Приход товара по накладным\t 739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого 437.474р 47к)")
            XCTAssertEqual("1. Приход товара по накладным\t 997.446р; (оплаты фактические: 491.114р 65к -переводы; 114.589 -корпоративная карта; 12.170 -наличные из кассы; Итого 617.873р 65к)".firstMatch(for: itemItogo),
                           "1. Приход товара по накладным\t 997.446р; (оплаты фактические: 491.114р 65к -переводы; 114.589 -корпоративная карта; 12.170 -наличные из кассы; Итого 617.873р 65к)")
            XCTAssertEqual("1. Приход товара по накладным\t179.108р 89к+512.293р(оплаты фактические:199.803р 80к-переводы;81.225р 35к-корпоративная карта;34.202р-наличные из кассы; Итого 315.231р 15к)".firstMatch(for: itemItogo),
                           "1. Приход товара по накладным\t179.108р 89к+512.293р(оплаты фактические:199.803р 80к-переводы;81.225р 35к-корпоративная карта;34.202р-наличные из кассы; Итого 315.231р 15к)")
            XCTAssertEqual("1. Приход товара по накладным\t473.128р 43к(оплаты фактические:231.572р 46к-переводы;51.104р 93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р 39к)".firstMatch(for: itemItogo),
                           "1. Приход товара по накладным\t473.128р 43к(оплаты фактические:231.572р 46к-переводы;51.104р 93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р 39к)")
            // ??? need to replace 'оплачено фактический' with 'Итого' and tokenize like 'itogo'
            XCTAssertEqual("1. Приход товара по накладным\t451.198р 41к (из них у нас оплачено фактический 21.346р 15к)".firstMatch(for: itemItogo),
                           "1. Приход товара по накладным\t451.198р 41к (из них у нас оплачено фактический 21.346р 15к)")
            /// also `itogo`
            XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе\t КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого 23.600".firstMatch(for: itemItogo),
                           "2. Предоплаченный товар, но не отраженный в приходе\t КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого 23.600")
            XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе\tБейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400".firstMatch(for: itemItogo),
                           "2. Предоплаченный товар, но не отраженный в приходе\tБейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400")
        }()






        let patterns: [String] = [] // [itemNoNumber, itemSimple]
        let matchCounts: [Int] = [2, 6]

        zip(patterns, matchCounts).forEach { pattern, matchCount in
            let count = selectedBodyItems.compactMap { $0.firstMatch(for: pattern) }.count
            XCTAssertEqual(count, matchCount)
        }


        let noItogo = #"^(?:(?!Итого).)*$"#


        let itemNoItogo = noItogo//#"^\#(noItogo)"#// #"^(?:(?!Итого).)*$"#
        XCTAssertNil("1. Приход товара по накладным\t946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)".firstMatch(for: itemNoItogo))
        XCTAssertNotNil("1. Приход товара по накладным\t946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; ".firstMatch(for: itemNoItogo))


        let itemNoParenthesesNoItogo = #"^((?!Итого|\().)*$"#
        XCTAssertNil("1. Приход товара по накладным\t946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)".firstMatch(for: itemNoParenthesesNoItogo), "String has 'Итого'")
        XCTAssertNil("1. Приход товара по накладным\t946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; ".firstMatch(for: itemNoParenthesesNoItogo), "Has Parentheses")


        let itemParenthesesNoItogo = #"^(?=.*?\()\#(noItogo)"#
        //XCTAssertEqual(itemParenthesesNoItogo, "", "get 'itemParenthesesNoItogo' as string for testing at https://regex101.com")
        XCTAssertNil("1. Приход товара по накладным\t946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)".firstMatch(for: itemParenthesesNoItogo), "String has 'Итого'")

        XCTAssertEqual("14. РПК Ника (крепления д/телевизоров и монтаж)    30.000".firstMatch(for: itemParenthesesNoItogo),
                       "14. РПК Ника (крепления д/телевизоров и монтаж)    30.000")
        XCTAssertEqual("22. Хэдхантер (подбор пероснала)    ----------------------------".firstMatch(for: itemParenthesesNoItogo),
                       "22. Хэдхантер (подбор пероснала)    ----------------------------")
        XCTAssertEqual("23. Аудит кантора (Бухуслуги)    60.000".firstMatch(for: itemParenthesesNoItogo),
                       "23. Аудит кантора (Бухуслуги)    60.000")
        XCTAssertEqual("1. Аренда торгового помещения     200.000 (за август)".firstMatch(for: itemParenthesesNoItogo),
                       "1. Аренда торгового помещения     200.000 (за август)")
        XCTAssertEqual("1. ФОТ     960.056( за вторую часть августа и первую  часть сентября)".firstMatch(for: itemParenthesesNoItogo),
                       "1. ФОТ     960.056( за вторую часть августа и первую  часть сентября)")
        XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе    Студиопак-12.500 (влажные салфетки);".firstMatch(for: itemParenthesesNoItogo),
                       "2. Предоплаченный товар, но не отраженный в приходе    Студиопак-12.500 (влажные салфетки);")
        XCTAssertEqual("27. Сервис Гуру (система аттестации, за 1 год)    12.655".firstMatch(for: itemParenthesesNoItogo),
                       "27. Сервис Гуру (система аттестации, за 1 год)    12.655")
        XCTAssertEqual("1. Аренда торгового помещения     200.000 (за август) +400.000 (за сентябрь)".firstMatch(for: itemParenthesesNoItogo),
                       "1. Аренда торгового помещения     200.000 (за август) +400.000 (за сентябрь)")
        XCTAssertEqual("1. ФОТ     1.147.085( за вторую часть сентября и первую  часть октября)".firstMatch(for: itemParenthesesNoItogo),
                       "1. ФОТ     1.147.085( за вторую часть сентября и первую  часть октября)")


        let itemTitleParenthesesNoItogo = #"^[1-9]\d?\.\D+(?:\d{1,3}(?:\.\d{3})*)$"#//#"^(?=.*?)\#(Patterns.itemNumber)"#
        //XCTAssertEqual(itemTitleParenthesesNoItogo, "", "get 'itemParenthesesNoItogo' as string for testing at https://regex101.com")
        XCTAssertEqual("14. РПК Ника (крепления д/телевизоров и монтаж)    30.000".firstMatch(for: Patterns.itemTitle),
                       "14. РПК Ника (крепления д/телевизоров и монтаж)    ")
        XCTAssertEqual("22. Хэдхантер (подбор пероснала)    ----------------------------".firstMatch(for: Patterns.itemTitle),
                       "22. Хэдхантер (подбор пероснала)    ----------------------------")
        XCTAssertEqual("23. Аудит кантора (Бухуслуги)    60.000".firstMatch(for: Patterns.itemTitle),
                       "23. Аудит кантора (Бухуслуги)    ")
        XCTAssertEqual("1. Аренда торгового помещения     200.000 (за август)".firstMatch(for: Patterns.itemTitle),
                       "1. Аренда торгового помещения     ")
        XCTAssertEqual("1. ФОТ     960.056( за вторую часть августа и первую  часть сентября)".firstMatch(for: Patterns.itemTitle),
                       "1. ФОТ     ")
        XCTAssertEqual("2. Предоплаченный товар, но не отраженный в приходе    Студиопак-12.500 (влажные салфетки);".firstMatch(for: Patterns.itemTitle),
                       "2. Предоплаченный товар, но не отраженный в приходе    Студиопак-12.500 (влажные салфетки);")
        XCTAssertEqual("27. Сервис Гуру (система аттестации, за 1 год)    12.655".firstMatch(for: Patterns.itemTitle),
                       "27. Сервис Гуру (система аттестации, за 1 год)    ")
        XCTAssertEqual("1. Аренда торгового помещения     200.000 (за август) +400.000 (за сентябрь)".firstMatch(for: Patterns.itemTitle),
                       "1. Аренда торгового помещения     ")
        XCTAssertEqual("1. ФОТ     1.147.085( за вторую часть сентября и первую  часть октября)".firstMatch(for: Patterns.itemTitle),
                       "1. ФОТ     ")




        let itemPercentageNoItogo = #"^(?=.*?%)\#(noItogo)"#
        // XCTAssertEqual(itemPercentageNoItogo, "", "get 'itemPercentageNoItogo' as string for testing at https://regex101.com")
        XCTAssertEqual("Фактический приход товара и оплата товара:        25%".firstMatch(for: itemPercentageNoItogo),
                       "Фактический приход товара и оплата товара:        25%")
        XCTAssertEqual("4. Банковская комиссия 1.6% за эквайринг    2.120".firstMatch(for: itemPercentageNoItogo),
                       "4. Банковская комиссия 1.6% за эквайринг    2.120")
        XCTAssertEqual("Основные расходы:        20%    12.56%".firstMatch(for: itemPercentageNoItogo),
                       "Основные расходы:        20%    12.56%")
        XCTAssertEqual("Основные расходы:    -----------------------------    25%/25%".firstMatch(for: itemPercentageNoItogo),
                       "Основные расходы:    -----------------------------    25%/25%")
        XCTAssertEqual("Зарплата:    -----------------------------    20%".firstMatch(for: itemPercentageNoItogo),
                       "Зарплата:    -----------------------------    20%")

    }

    func test_getFirstMatchAndTail() throws {
        var (match1, tail1) = "4. Банковская комиссия 1.6% за эквайринг\t2.120"
            .getFirstMatchAndTail(for: Patterns.itemTitleWithPercentage) ?? ("", "")

        (match1, tail1) = "4. Банковская комиссия 1.6% за эквайринг\t2.120"
            .getFirstMatchAndTail(for: Patterns.itemTitleWithPercentage) ?? ("", "")

        guard var (match, tail) = "4. Банковская комиссия 1.6% за эквайринг\t2.120"
                .getFirstMatchAndTail(for: Patterns.itemTitleWithPercentage) else {
            XCTFail()
            return
        }
        XCTAssertEqual(match, "4. Банковская комиссия 1.6% за эквайринг")
        XCTAssertEqual(tail, "2.120")

    }

    func test_itemTitleWithPercentage() {
        XCTAssertEqual("4. Банковская комиссия 1.6% за эквайринг\t2.120"
                        .itemTitleWithPercentage(),
                       .item(title: "4. Банковская комиссия 1.6% за эквайринг", value: 2_120, comment: nil))
        XCTAssertEqual("4. Банковская комиссия 1.6% за эквайринг\t12.111"
                        .itemTitleWithPercentage(),
                       .item(title: "4. Банковская комиссия 1.6% за эквайринг", value: 12_111, comment: nil))
    }
}
