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
                                      Patterns.itemBasic,
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

    /// `itemBasic`: item with title and number, no itogo.
    /// Title may have number inside parantheses or %.
    /// May have comment after number.
    /// Does not match a string without number, so failure could be used to return `.empty` in BodySymbol init
    static let itemBasic = #"\#(title)(?<value>\#(itemNumber))(?<comment>\s*\((?:(?!Итого|фактический|\+).)*\))?$"#

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

