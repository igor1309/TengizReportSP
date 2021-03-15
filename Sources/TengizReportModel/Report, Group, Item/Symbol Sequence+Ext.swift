//
//  Symbol Sequence+Ext.swift
//  UsingTengizReportSP
//
//  Created by Igor Malyarov on 10.02.2021.
//

extension Patterns {
    static var monthWithoutYear = #"(?:Месяц: )?(?<month>\D+)(?:\d{4}).*\t?"#
}

extension String {
    func monthInt() -> Int? {
        let monthWithoutYearStr = replaceFirstMatch(for: Patterns.monthWithoutYear, withGroup: "month")
        switch monthWithoutYearStr {
            case "январь", "Январь": return 1
            case "февраль", "Февраль": return 2
            case "март", "Март": return 3
            case "апрель", "Апрель": return 4
            case "май", "Май": return 5
            case "июнь", "Июнь": return 6
            case "июль", "Июль": return 7
            case "август", "Август": return 8
            case "сентябрь", "Сентябрь": return 9
            case "октябрь", "Октябрь": return 10
            case "ноябрь", "Ноябрь", "Октябрь+Ноябрь": return 11
            case "декабрь", "Декабрь": return 12
            default: return nil
        }
    }
    func yearInt() -> Int? {
        guard let yearStr = replaceFirstMatch(for: #"\D*(?<year>\d{4})\D*"#, withGroup: "year") else { return nil }

        return Int(yearStr)
    }

}

#warning("try internal not public extension")
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


