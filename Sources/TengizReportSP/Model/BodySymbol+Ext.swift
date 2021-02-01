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

#warning("move patterns to Patterns??")
public extension String {
    func correction() -> BodySymbol? {
        /// tokenize lines like `"-10.000 за перерасход питание персонала в июле"`
        guard firstMatch(for: Patterns.itemCorrectionLine) != nil,
              let number = numberWithSign() else { return nil }
        return .item(title: "Correction", value: number, comment: self)
    }

    func withPlus() -> BodySymbol? {
        /// tokenize lines like `"12.Интернет    7.701+4.500"`
        /// or `"1. Аренда торгового помещения     200.000 (за август) +400.000 (за сентябрь)        "`
        guard firstMatch(for: Patterns.itemWithPlus) != nil,
              let titleString = firstMatch(for: Patterns.itemTitle),
              let remains = firstMatch(for: Patterns.numbersWithPlus)
        else { return nil }

        let sum = remains
            .listMatches(for: Patterns.itemNumber)
            .compactMap { $0.numberWithSign() }
            .reduce(0, +)

        return .item(title: titleString.clearWhitespacesAndNewlines(),
                     value: sum,
                     comment: remains.clearWhitespacesAndNewlines())
    }

    func itogo() -> BodySymbol? {
        let itemWithItogoPattern = #".*?Итого"#
        if firstMatch(for: itemWithItogoPattern) != nil {

            let prihodPattern = #"1. Приход товара по накладным"#
            if let titleString = firstMatch(for: prihodPattern),
               let afterItogo = replaceFirstMatch(for: itemWithItogoPattern, withString: ""),
               let number = afterItogo.numberWithSign(),
               let comment = replaceFirstMatch(for: prihodPattern, withString: "") {
                return .item(title: titleString,
                             value: number,
                             comment: comment.clearWhitespacesAndNewlines())
            }

            let prepayPattern = #"2. Предоплаченный товар, но не отраженный в приходе"#
            if let titleString = firstMatch(for: prepayPattern),
               let afterItogo = replaceFirstMatch(for: itemWithItogoPattern, withString: ""),
               let number = afterItogo.numberWithSign(),
               let comment = replaceFirstMatch(for: prepayPattern, withString: "") {
                return .item(title: titleString,
                             value: number,
                             comment: comment.clearWhitespacesAndNewlines())
            }

            return nil
        } else {
            return nil
        }
    }

    func prihod() -> BodySymbol? {

        let itemWithItogoPattern = #".*?Итого"#
        let prihodPattern = #"1. Приход товара по накладным"#

        guard firstMatch(for: itemWithItogoPattern) != nil,
              let titleString = firstMatch(for: prihodPattern),
              let afterItogo = replaceFirstMatch(for: itemWithItogoPattern, withString: ""),
              let number = afterItogo.numberWithSign(),
              let comment = replaceFirstMatch(for: prihodPattern, withString: "")
        else { return nil }

        return .item(title: titleString,
                     value: number,
                     comment: comment.clearWhitespacesAndNewlines())
    }

    func prepay() -> BodySymbol? {
        let itemWithItogoPattern = #".*?Итого"#
        let prepayPattern = #"2. Предоплаченный товар, но не отраженный в приходе"#

        guard firstMatch(for: itemWithItogoPattern) != nil,
              let titleString = firstMatch(for: prepayPattern),
              let afterItogo = replaceFirstMatch(for: itemWithItogoPattern, withString: ""),
              let number = afterItogo.numberWithSign(),
              let comment = replaceFirstMatch(for: prepayPattern, withString: "")
        else { return nil }

        return .item(title: titleString,
                     value: number,
                     comment: comment.clearWhitespacesAndNewlines())
    }

    func anotherPrepay() -> BodySymbol? {
        /// tokenize line like `"2. Предоплаченный товар, но не отраженный в приходе    Студиопак-12.500 (влажные салфетки);"`
        let anotherPrepayPattern = #"2. Предоплаченный товар, но не отраженный в приходе(?=\s+[А-Яа-я])"#
        if let titleString = firstMatch(for: anotherPrepayPattern) {
            let comment = replaceMatches(for: anotherPrepayPattern, withString: "")
            if let number = comment.numberWithoutSign() {
                return .item(title: titleString,
                             value: number,
                             comment: comment.clearWhitespacesAndNewlines())
            } else {
                return nil
            }
        } else {
            return nil
        }
    }

    // swiftlint:disable:next function_body_length
    func bodySymbol() -> BodySymbol {
        var title: String = ""
        var remains: String = ""
        var number: Double?

        if let correction    = correction()    { return correction }
        if let withPlus      = withPlus()      { return withPlus }
        if let prihod        = prihod()        { return prihod }
        if let prepay        = prepay()        { return prepay }
        if let anotherPrepay = anotherPrepay() { return anotherPrepay }

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

        let itemWithItogoPattern = #".*?Итого"#
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

        let cleanComment = remains.clearWhitespacesAndNewlines()
        let comment: String? = cleanComment.isEmpty ? nil : cleanComment

        return .item(title: title, value: number ?? 0, comment: comment)
    }

    // MARK: - Helpers

    /// Get first match from string and cut match from string to give remains
    /// Handle head (match) and tail in closure
    /// - Parameters:
    ///   - patterns: array of regular expression patterns to apple to string (order matters!)
    ///   - completion: closure to work with non empty head and tail
    func getFirstMatchAndRemains(patterns: [String], completion: (String?, String?) -> Void) {
        var match: String?
        var remains: String?

        for pattern in patterns {
            guard let regex = try? NSRegularExpression(pattern: pattern, options: []),
                  let headString = self.firstMatch(for: regex),
                  let tailString = self.replaceFirstMatch(for: regex, withString: "") else { continue }

            match = headString.trimmingCharacters(in: .whitespaces)
            remains = tailString.trimmingCharacters(in: .whitespaces)
            break
        }

        completion(match, remains)
    }


}
