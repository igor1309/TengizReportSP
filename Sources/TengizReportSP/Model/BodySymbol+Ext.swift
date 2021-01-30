//
//  BodySymbol+Ext.swift
//  TengizReportSPM
//
//  Created by Igor Malyarov on 10.01.2021.
//

import Foundation

extension BodySymbol: ExpressibleByStringLiteral {
    public init(stringLiteral string: String) {
        self = string.bodySymbol()
    }
}

public extension String {
    // swiftlint:disable:next function_body_length
    func bodySymbol() -> BodySymbol {
        var title: String = ""
        var remains: String = ""
        var number: Double?

        /// tokenize lines like `"-10.000 за перерасход питание персонала в июле"`
        if self.firstMatch(for: Patterns.itemCorrectionLine) != nil,
           let number = self.numberWithSign() {
            return .item(title: "Correction", value: number, comment: self)
        }

        /// tokenize lines like `"12.Интернет    7.701+4.500"`
        /// or `"1. Аренда торгового помещения     200.000 (за август) +400.000 (за сентябрь)        "`
        if self.firstMatch(for: Patterns.itemWithPlus) != nil,
           let titleString = self.firstMatch(for: Patterns.itemTitle),
           let remains = self.firstMatch(for: Patterns.numbersWithPlus) {
            let sum = remains
                .listMatches(for: Patterns.itemNumber)
                .compactMap { $0.numberWithSign() }
                .reduce(0, +)

            return .item(title: titleString.clearWhitespacesAndNewlines(),
                         value: sum,
                         comment: remains.clearWhitespacesAndNewlines())
        }

        let itemWithItogoPattern = #".*?Итого"#
        if self.firstMatch(for: itemWithItogoPattern) != nil {

            let prihodPattern = #"1. Приход товара по накладным"#
            if let titleString = self.firstMatch(for: prihodPattern),
               let afterItogo = self.replaceFirstMatch(for: itemWithItogoPattern, withString: ""),
               let number = afterItogo.numberWithSign(),
               let comment = self.replaceFirstMatch(for: prihodPattern, withString: "") {
                return .item(title: titleString,
                             value: number,
                             comment: comment.clearWhitespacesAndNewlines())
            }

            let prepayPattern = #"2. Предоплаченный товар, но не отраженный в приходе"#
            if let titleString = self.firstMatch(for: prepayPattern),
               let afterItogo = self.replaceFirstMatch(for: itemWithItogoPattern, withString: ""),
               let number = afterItogo.numberWithSign(),
               let comment = self.replaceFirstMatch(for: prepayPattern, withString: "") {
                return .item(title: titleString,
                             value: number,
                             comment: comment.clearWhitespacesAndNewlines())
            }
        }

        /// tokenize line like `"2. Предоплаченный товар, но не отраженный в приходе    Студиопак-12.500 (влажные салфетки);"`
        let anotherPrepayPattern = #"2. Предоплаченный товар, но не отраженный в приходе(?=\s+[А-Яа-я])"#
        if let titleString = self.firstMatch(for: anotherPrepayPattern) {
            let comment = self.replaceMatches(for: anotherPrepayPattern, withString: "")
            if let number = comment.numberWithoutSign() {
                return .item(title: titleString,
                             value: number,
                             comment: comment.clearWhitespacesAndNewlines())
            }
        }

        let itemTitlePatterns = [Patterns.itemTitleWithPercentage,
                                 Patterns.itemTitleWithParentheses,
                                 Patterns.itemTitle]

        self.getFirstMatchAndRemains(patterns: itemTitlePatterns) { (match, remainsString) in
            guard let headString = match,
                  let tailString = remainsString else { return }
            title = headString
            remains = tailString
        }

        guard !title.isEmpty && !remains.isEmpty else {
            #warning("what to return here as source?")
            return .empty
        }

        (number, remains) = remains.numberAndRemains()

        /// special case when number after item title is not a number for item
        /// for example in `"1. Приход товара по накладным     946.056р (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого-632.684р 37к)"`
        if let afterItogo = remains.replaceFirstMatch(for: itemWithItogoPattern, withString: "") {
            number = afterItogo.numberWithSign()
        }

        /// another special case when number after item title is not a number for item
        /// for example in `"1. Приход товара по накладным    451.198р41к (из них у нас оплачено фактический 21.346р15к)"`
        let factPattern = #".*?фактический"#
        if let afterFact = remains.replaceFirstMatch(for: factPattern, withString: "") {
            number = afterFact.numberWithSign()
            remains = self.replaceFirstMatch(for: Patterns.itemTitle + #""#, withString: "") ?? self
        }

        let dirtyComment = remains.clearWhitespacesAndNewlines()
        let comment: String? = dirtyComment.isEmpty ? nil : dirtyComment

        return .item(title: title, value: number ?? 0, comment: comment)
    }
}
