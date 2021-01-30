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
        if self.firstMatch(for: #"ИТОГ всех расходов за месяц"#) != nil,
           let number = self.numberWithSign() {
            return .expensesTotal(title: "ИТОГ всех расходов за месяц", value: number)
        } else {
            return nil
        }
    }

    func balance() -> FooterSymbol? {
        if self.firstMatch(for: #"Фактический остаток:"#) != nil {
            // get percentage and remains (replace percentage with "")
            let percentageString = self.firstMatch(for: Patterns.percentage)
            let percentage = percentageString?.percentageStringToDouble()

            let remains = self.replaceMatches(for: Patterns.percentage, withString: "")
            // get number
            if let number = remains.numberWithSign() {
                return .balance(title: "Фактический остаток", value: number, percentage: percentage)
            } else {
                return .error
            }
        } else {
            return nil
        }
    }

    func openingBalance() -> FooterSymbol? {
        if self.firstMatch(for: #"[П\п]ереход"#) != nil,
           let number = self.numberWithSign() {
            return .openingBalance(title: self.trimmingCharacters(in: .whitespaces), value: number)
        } else {
            return nil
        }
    }

    func extraIncomeExpenses() -> FooterSymbol? {
        if self.firstMatch(for: Patterns.numberWithSignAtStart) != nil,
           let number = self.numberWithSign() {
            return .extraIncomeExpenses(title: self, value: number)
        } else {
            return nil
        }
    }

    func runningBalance() -> FooterSymbol? {
        if self.firstMatch(for: #"ИТОГ:"#) != nil,
           let number = self.numberWithSign() {
            return .runningBalance(title: "ИТОГ", value: number)
        } else {
            return nil
        }
    }
}

extension Patterns {
    public static let numberWithSignAtStart = #"^\s*(-|\+)\d{1,3}"#
}
