//
//  FooterToken+Ext.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 10.01.2021.
//

import Foundation

extension FooterSymbol: ExpressibleByStringLiteral {
    public init(stringLiteral string: String) {
        self = string.footerSymbol()
    }
}

public extension String {
    func footerSymbol() -> FooterSymbol {
        // expensesTotal
        if self.firstMatch(for: #"ИТОГ всех расходов за месяц"#) != nil,
           let number = self.numberWithSign() {
            return .expensesTotal(title: "ИТОГ всех расходов за месяц", value: number)
        }

        // total
        if self.firstMatch(for: #"Фактический остаток:"#) != nil {
            // get percentage and remains (replace percentage with "")
            guard let percentageString = self.firstMatch(for: Patterns.percentage),
                  let percentage = percentageString.percentageStringToDouble()
            else { return .error }

            let remains = self.replaceMatches(for: Patterns.percentage, withString: "")
            // get number
            if let number = remains.numberWithSign() {
                return .total(title: "Фактический остаток", value: number, percentage: percentage)
            }
            #warning("and what if there is 'else'?")
        }

        // openingBalance
        if self.firstMatch(for: #"[П\п]ереход"#) != nil,
           let number = self.numberWithSign() {
            return .openingBalance(title: self.trimmingCharacters(in: .whitespaces), value: number)
        }

        // extraIncomeExpenses
        if self.firstMatch(for: Patterns.numberWithSignAtStart) != nil,
           let number = self.numberWithSign() {
            return .extraIncomeExpenses(title: self, value: number)
        }

        // balance
        if self.firstMatch(for: #"ИТОГ:"#) != nil,
           let number = self.numberWithSign() {
            return .balance(title: "ИТОГ", value: number)
        }

        return .error
    }
}

extension Patterns {
    public static let numberWithSignAtStart = #"^\s*(-|\+)\d{1,3}"#
}
