//
//  BodySymbol+Ext.swift
//  TengizReportSPM
//
//  Created by Igor Malyarov on 10.01.2021.
//

import Foundation

extension BodySymbol: ExpressibleByStringLiteral {
    public init(stringLiteral string: String) {
        self = {
            if let correction      = string.correction()      { return correction }
            if let withPlus        = string.withPlus()        { return withPlus }
            if let prihodWithItogo = string.prihodWithItogo() { return prihodWithItogo }
            if let prepayWithItogo = string.prepayWithItogo() { return prepayWithItogo }
            if let prepayNoItogo   = string.prepayNoItogo()   { return prepayNoItogo }
            if let otherPatterns   = string.otherPatterns()   { return otherPatterns }

            return .empty
        }()
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

//    func itogo() -> BodySymbol? {
//        if firstMatch(for: Patterns.itemWithItogoPattern) != nil {
//
//            #warning("move to patterns + make tests")
//            let prihodPattern = #"1. Приход товара по накладным"#
//            if let titleString = firstMatch(for: prihodPattern),
//               let dropItogo = replaceFirstMatch(for: Patterns.itemWithItogoPattern, withString: ""),
//               let number = dropItogo.numberWithSign(),
//               let comment = replaceFirstMatch(for: prihodPattern, withString: "") {
//                return .item(title: titleString,
//                             value: number,
//                             comment: comment.clearWhitespacesAndNewlines())
//            }
//
//            #warning("move to patterns + make tests")
//            let prepayWithItogo = #"2. Предоплаченный товар, но не отраженный в приходе"#
//            if let titleString = firstMatch(for: prepayWithItogo),
//               let dropItogo = replaceFirstMatch(for: Patterns.itemWithItogoPattern, withString: ""),
//               let number = dropItogo.numberWithSign(),
//               let comment = replaceFirstMatch(for: prepayWithItogo, withString: "") {
//                return .item(title: titleString,
//                             value: number,
//                             comment: comment.clearWhitespacesAndNewlines())
//            }
//
//            return nil
//        } else {
//            return nil
//        }
//    }

    func prihodWithItogo() -> BodySymbol? {
        guard firstMatch(for: Patterns.itogo) != nil,
              let titleString = firstMatch(for: Patterns.prihod),
              let dropItogo = replaceFirstMatch(for: Patterns.itogo, withString: ""),
              let number = dropItogo.numberWithSign(),
              let comment = replaceFirstMatch(for: Patterns.prihod, withString: "")
        else { return nil }

        return .item(title: titleString,
                     value: number,
                     comment: comment.clearWhitespacesAndNewlines())
    }

    func prepayWithItogo() -> BodySymbol? {
        guard firstMatch(for: Patterns.prepayWithItogo) != nil,
              let titleString = firstMatch(for: Patterns.prepay),
              let dropItogo = replaceFirstMatch(for: Patterns.itogo, withString: ""),
              let number = dropItogo.numberWithoutSign(),
              let comment = replaceFirstMatch(for: titleString, withString: "")
        else { return nil }

        return .item(title: titleString,
                     value: number,
                     comment: comment.clearWhitespacesAndNewlines())
    }

    func prepayNoItogo() -> BodySymbol? {
        #warning("why not working replaceFirstMatch(for: Patterns.prepayNoItogo, …) ????")
        guard firstMatch(for: Patterns.prepayNoItogo) != nil,
              let titleString = firstMatch(for: Patterns.prepay),
              let comment = replaceFirstMatch(for: titleString, withString: ""),
              let number = comment.numberWithoutSign()
        else { return nil }

        return .item(title: titleString,
                     value: number,
                     comment: comment.clearWhitespacesAndNewlines())
    }

    func otherPatterns() -> BodySymbol? {
        var title: String = ""
        var remains: String = ""
        var number: Double?

        let itemTitlePatterns = [Patterns.itemTitleWithPercentage,
                                 Patterns.itemTitleWithParentheses,
                                 Patterns.itemTitle]

        self.getFirstMatchAndRemains(patterns: itemTitlePatterns) { (match, remainsString) in
            guard let headString = match,
                  let tailString = remainsString else { return }
            title = headString
            remains = tailString
        }

        guard !title.isEmpty && !remains.isEmpty else { return nil }

        (number, remains) = remains.numberAndRemains()

        if let dropItogo = remains.replaceFirstMatch(for: Patterns.itogo, withString: "") {
            number = dropItogo.numberWithSign()
        }

        if let afterFact = remains.replaceFirstMatch(for: Patterns.factPattern, withString: "") {
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
            guard let headString = self.firstMatch(for: pattern),
                  let tailString = self.replaceFirstMatch(for: pattern, withString: "") else { continue }

            match = headString.trimmingCharacters(in: .whitespaces)
            remains = tailString.trimmingCharacters(in: .whitespaces)
            break
        }

        completion(match, remains)
    }

}

extension Patterns {
    /// matching lines like `"-10.000 за перерасход питание персонала в июле"`
    public static let itemCorrectionLine = #"^-\d{1,3}(?:\.\d{3})*.*"#

    public static let itemTitle = #"^[1-9]\d?\.\D+"#

    public static let itemWithPlus = itemTitle + numbersWithPlus

    /// matching lines like `"4.Банковская комиссия 1.6% за эквайринг    "` (mind whitespace)
    public static let itemTitleWithPercentage =  itemTitle + percentage + #"\D*"#
    /// matching lines like `"22. Хэдхантер (подбор пероснала)    "` (mind whitespace)
    public static let itemTitleWithParentheses = itemTitle + #"\([^(]*\)\D*"#

    /// pattern to match `"200.000 (за август) +400.000 (за сентябрь)"` or `"7.701+4.500"`
    public static let numbersWithPlus = itemNumber + #"(?:\s*\([^\)]+\)\s*)?\+"# + itemNumber + #"(?:\s*\([^\)]+\)\s*)?"#

    /// special case when number after item title is not a number for item
    /// for example in `"1. Приход товара по накладным\t946.056р (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого-632.684р 37к)"`
    public static let itogo = #".*?Итого"#

    #warning("make tests")
    public static let prihod = #"1. Приход товара по накладным"#
    public static let prihodWithItogo = "\(prihod)(?=.*?Итого)"

    public static let prepay = "2. Предоплаченный товар, но не отраженный в приходе"
    public static let prepayWithItogo = "\(prepay)(?=.*?Итого)"
    public static let prepayNoItogo = "\(prepay)((?!Итого).)*$"

    /// another special case when number after item title is not a number for item
    /// for example in `"1. Приход товара по накладным\t451.198р41к (из них у нас оплачено фактический 21.346р15к)"`
    public static let factPattern = #".*?фактический"#
}
