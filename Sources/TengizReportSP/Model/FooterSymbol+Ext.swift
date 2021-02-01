//
//  FooterToken+Ext.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 10.01.2021.
//

import Foundation

extension FooterSymbol: ExpressibleByStringLiteral {
    public init(stringLiteral string: String) {
        self = {
            if let expenses = string.expensesTotal()       { return expenses }
            if let balance  = string.balance()             { return balance }
            if let opening  = string.openingBalance()      { return opening }
            if let extra    = string.extraIncomeExpenses() { return extra }
            if let running  = string.runningBalance()      { return running }

            return .error
        }()
    }
}

extension String {
    func expensesTotal() -> FooterSymbol? {
        guard firstMatch(for: #"ИТОГ всех расходов за месяц"#) != nil,
              let number = numberWithSign() else { return nil }
        return .expensesTotal(title: "ИТОГ всех расходов за месяц", value: number)
    }

    func balance() -> FooterSymbol? {
        guard firstMatch(for: #"Фактический остаток:"#) != nil,
              let number = replaceMatches(for: Patterns.percentage, withString: "").numberWithSign()
        else { return nil }

        // get percentage and remains (replace percentage with "")
        let percentageString = firstMatch(for: Patterns.percentage)
        let percentage = percentageString?.percentageStringToDouble()

        return .balance(title: "Фактический остаток", value: number, percentage: percentage)
    }

    func openingBalance() -> FooterSymbol? {
        guard firstMatch(for: #"[П\п]ереход"#) != nil,
              let number = numberWithSign() else { return nil }
        return .openingBalance(title: trimmingCharacters(in: .whitespaces), value: number)
    }

    func extraIncomeExpenses() -> FooterSymbol? {
        guard firstMatch(for: Patterns.numberWithSignAtStart) != nil,
              let number = numberWithSign() else { return nil }
        return .extraIncomeExpenses(title: self, value: number)
    }

    func runningBalance() -> FooterSymbol? {
        guard firstMatch(for: #"ИТОГ:"#) != nil,
              let number = numberWithSign() else { return nil }
        return .runningBalance(title: "ИТОГ", value: number)
    }
}

extension Patterns {
    public static let numberWithSignAtStart = #"^\s*(-|\+)\d{1,3}"#
    public static let percentage = #"\d+(\.\d+)?%"#

}
