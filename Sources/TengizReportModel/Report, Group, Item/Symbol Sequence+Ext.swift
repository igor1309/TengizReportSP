//
//  Symbol Sequence+Ext.swift
//  UsingTengizReportSP
//
//  Created by Igor Malyarov on 10.02.2021.
//

public extension Sequence where Element == Token<HeaderSymbol> {
    func monthStr() -> String? {
        compactMap {
            switch $0.symbol {
                case let .month(monthStr: monthStr): return monthStr
                default: return nil
            }
        }.first
    }
    func company() -> String? {
        compactMap {
            switch $0.symbol {
                case let .company(name: name): return name
                default: return nil
            }
        }.first
    }
    func revenue() -> Double? {
        compactMap {
            switch $0.symbol {
                case let .revenue(revenue): return revenue
                default: return nil
            }
        }.first
    }
    func dailyAverage() -> Double? {
        compactMap {
            switch $0.symbol {
                case let .dailyAverage(dailyAverage): return dailyAverage
                default: return nil
            }
        }.first
    }
}

public extension Sequence where Element == Token<BodySymbol> {
    func title() -> String? {
        compactMap {
            switch $0.symbol {
                case let .header(title: title, plan: _, fact: _): return title
                default: return nil
            }
        }.first
    }
    func amount() -> Double? {
        compactMap {
            switch $0.symbol {
                case let .footer(title: _, value: amount): return amount
                default: return nil
            }
        }.first
    }
    func target() -> Double? {
        compactMap {
            switch $0.symbol {
                case let .header(title: _, plan: target, fact: _): return target
                default: return nil
            }
        }.first
    }
}

public extension Sequence where Element == Token<FooterSymbol> {
    func openingBalance() -> Double? {
        compactMap {
            switch $0.symbol {
                case let .openingBalance(_, openingBalance): return openingBalance
                default: return nil
            }
        }.first
    }
    func balance() -> Double? {
        compactMap {
            switch $0.symbol {
                case let .balance(_, balance, _): return balance
                default: return nil
            }
        }.first
    }
    func runningBalance() -> Double? {
        compactMap {
            switch $0.symbol {
                case let .runningBalance(_, runningBalance): return runningBalance
                default: return nil
            }
        }.first
    }
    func totalExpenses() -> Double? {
        compactMap {
            switch $0.symbol {
                case let .totalExpenses(_, totalExpenses): return totalExpenses
                default: return nil
            }
        }.first
    }
}


