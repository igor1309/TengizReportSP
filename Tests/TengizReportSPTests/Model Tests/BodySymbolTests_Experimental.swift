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
        guard let title = replaceFirstMatch(for: pattern, withGroup: "title")?
                .trimmingCharacters(in: .whitespaces) else { return nil }
        guard let valueStr = replaceFirstMatch(for: pattern, withGroup: "value")?
                .trimmingCharacters(in: .whitespaces),
              let value = valueStr.numberWithSign() else { return nil }

        let comment = replaceFirstMatch(for: pattern, withGroup: "comment")?
            .trimmingCharacters(in: .whitespaces) ?? ""

        return .item(title: title, value: value, comment: comment.isEmpty ? nil : comment)
    }
}

extension String {
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
                     "Matching to non-existing group 'title'")
    }
}

final class BodySymbolFuncTests: XCTestCase {
    func test_func_bodySymbol() {
        let input = "1. Аренда торгового помещения\t46.667 (за июнь)"
        let pattern = #"(?<title>^\d+\.\D+)(?<value>\d{1,3}(?:\.\d{3})*)(?<comment>.*)$"#

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

        let pattern2 = #"(?<title>^\d+\.\D+)(?<value>\d{1,3}(?:\.\d{3})*).*$"#
        XCTAssertEqual(input.replaceFirstMatch(for: pattern2, withString: "$3")?
                        .trimmingCharacters(in: .whitespaces),
                       "", "Capturing non-existing group (just 2 groups in regex '\(pattern2)')")

        XCTAssertEqual(input.bodySymbol(for: pattern2),
                       .item(title: "1. Аренда торгового помещения", value: 46_667, comment: nil),
                       "Comment group is nil")
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

final class GetSourcesTests: XCTestCase {
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

        XCTAssertEqual(bodyItems.count, 340)
        XCTAssertEqual(selectedBodyItems.count, 34)

        //XCTAssertNil(selectedBodyItems.joined(separator: "\n"))
    }
}

final class BodySymbolTests_Experimental: XCTestCase {

    func test() {

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
