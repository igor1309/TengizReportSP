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
    static let title = #"(?<title>^.*?)(?:\t\s*)"#

    /// `math` and `itemMath`
    static let math = #"\#(itemNumber)(?:\D*\s*\+\s*\#(itemNumber))+"#
    static let itemMath = #"\#(title)(?<comment>(?<value>\#(math))\D*)$"#

    /// `itogo`
    static let itemItogo = #"\#(title)(?<comment>.*(?<value>(?<=Итого|фактический)\s*\#(itemNumber)(?:р \d\d?к)?).*)"#

    /// item with `comment` after number, floating whitespace
    static let itemWithComment = #"^\#(title)(?<value>\#(itemNumber))(?<comment>\s*\((?:(?!Итого|фактический|\+).)*\))$"#

    /// `itemSimple`: item title and number, no itogo
    /// may have number inside parantheses or %
    /// no comment after number
    /// does not match a string without number, so failure could be used to return nil in BodySymbol init
    static let itemSimple = #"\#(title)(?<value>\#(itemNumber))$"#

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

