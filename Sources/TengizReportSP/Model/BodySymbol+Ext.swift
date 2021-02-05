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
            let patterns: [String] = [Patterns.itemItogo,
                                      Patterns.itemMath,
                                      Patterns.itemNoNumber,
                                      Patterns.itemNumberInsideParentheses,
                                      Patterns.itemPercentage,
                                      Patterns.itemSimple,
                                      Patterns.itemWithComment,
                                      Patterns.itemCorrection]

            for pattern in patterns {
                if let symbol = string.bodySymbol(for: pattern) { return symbol }
            }

            return .empty
        }()
    }
}

extension Patterns {
    static let bodyItemStart = #"(?<title>^\d+\.\D+"#

    /// `itogo`
    static let itemItogo = #"\#(bodyItemStart)\t)(?<comment>.*(?<value>(?<=Итого|фактический)\s*\#(itemNumber)(?:р \d\d?к)?).*)"#

    /// `math` and `itemMath`
    static let math = #"\#(itemNumber)(?:\s*\+\s*\#(itemNumber))+"#
    static let itemMath = #"\#(bodyItemStart))(?:\t)(?<comment>(?<value>\#(math)))$"#

    /// `itemNoNumber`: title without number, should return .empty
    static let itemNoNumber = #"\#(bodyItemStart))((?!\d).)*$"#

    /// `itemNumberInsideParentheses`: item with number inside parentheses
    static let itemNumberInsideParentheses = #"\#(bodyItemStart)\(.*\d.*\))\s*(?<value>\#(itemNumber))$"#

    /// item with digits and `percentage` inside item title
    static let itemPercentage = #"\#(bodyItemStart)\d{1,3}\.\d{1,2}\%\D+)(?:\t)(?<value>\#(itemNumber))"#

    /// `itemSimple`: item title and number, no itogo, no number inside parantheses, no %, no comment after number
    static let itemSimple = #"\#(bodyItemStart))(?:\t)(?<value>\#(itemNumber))$"#

    /// item with `comment` after number, floating whitespace
    static let itemWithComment = #"^\#(bodyItemStart))(?<value>\#(itemNumber))(?<comment>\s*\((?:(?!Итого|фактический).)*\))$"#

    /// matching lines like `"-10.000 за перерасход питание персонала в июле"`
    static let itemCorrection = #"^(?<value>-\#(itemNumber))\s*(?<title>.*)$"#

}

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

