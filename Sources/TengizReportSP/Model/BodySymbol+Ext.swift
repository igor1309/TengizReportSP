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
                                      Patterns.itemWithComment]

            for pattern in patterns {
                if let symbol = string.bodySymbol(for: pattern) { return symbol }
            }

            return .empty
        }()
    }
}

#warning("use Patterns properties in definitions")
extension Patterns {
    static let bodyItemStart = #"^\d+\."#

    /// `itogo`
    //static let itemItogo = #"(?<title>^\d+\.\D+)(?<comment>.*\s*(?<value>(?<=Итого|фактический)\s*\#(Patterns.rubliKopeiki)).*)"#
    static let itemItogo = #"(?<title>^\d+\.\D+\t)(?<comment>.*(?<value>(?<=Итого|фактический)\s*\d{1,3}(?:\.\d{3})*(?:р \d\d?к)?).*)"#

    /// `itemMath`
    static let itemMath = #"(?<title>\#(bodyItemStart)\D+)(?<comment>(?<value>\#(Patterns.itemNumber)(?:\+\#(Patterns.itemNumber))+))$"#

    /// `itemNoNumber`: title without number, should return .empty
    static let itemNoNumber = #"\#(bodyItemStart)((?!\d).)*$"#

    /// `itemNumberInsideParentheses`: item with number inside parentheses
    static let itemNumberInsideParentheses = #"(?<title>\#(bodyItemStart).*\(.*\d.*\))\s*(?<value>\#(Patterns.itemNumber))$"#

    /// item with digits and `percentage` inside item title
    static let itemPercentage = #"(?<title>\#(bodyItemStart)\D*\d{1,3}\.\d{1,2}\%\D+)(?<value>\#(Patterns.itemNumber))"#

    /// `itemSimple`: item title and number, no itogo, no number inside parantheses, no %, no comment after number
    static let itemSimple = #"(?<title>\#(bodyItemStart)\D+)(?<value>\#(Patterns.itemNumber))$"#

    /// item with `comment` after number, floating whitespace
    static let itemWithComment = #"^(?<title>^\d+\.\D+)(?<value>\d{1,3}(?:\.\d{3})*)(?<comment>\s*\((?:(?!Итого|фактический).)*\))$"#
    // #"^(?<title>\#(bodyItemStart)\D+)(?<value>\#(Patterns.itemNumber))(?<comment>\s*\(.+\))$"#
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

