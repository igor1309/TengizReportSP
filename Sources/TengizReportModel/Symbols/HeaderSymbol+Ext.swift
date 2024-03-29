//
//  HeaderSymbol+Ext.swift
//  TengizReportSPM
//
//  Created by Igor Malyarov on 10.01.2021.
//

import Foundation
import RegexTools

extension HeaderSymbol: ExpressibleByStringLiteral {
    public init(stringLiteral string: String) {
        self = {
            if let company      = string.company()      { return company }
            if let month        = string.month()        { return month }
            if let revenue      = string.revenue()      { return revenue }
            if let dailyAverage = string.dailyAverage() { return dailyAverage }

            return .error
        }()
    }
}

extension String {
    func company() -> HeaderSymbol? {
        guard let company = firstMatch(for: Patterns.headerCompany) else { return nil }
        return .company(name: company)
    }

    func month() -> HeaderSymbol? {
        guard let month = replaceFirstMatch(for: Patterns.headerMonth, withGroup: "monthStr") else { return nil }
        return .month(monthStr: month)
    }

    func revenue() -> HeaderSymbol? {
        guard firstMatch(for: Patterns.revenue) != nil,
              let number = numberWithSign() else { return nil }
        return .revenue(number)
    }

    func dailyAverage() -> HeaderSymbol? {
        guard firstMatch(for: Patterns.dailyAverage) != nil,
              let number = numberWithSign() else { return nil }
        return .dailyAverage(number)
    }
}

extension Patterns {
    static let headerItemTitle = #"[А-Яа-я ]+(?=:)"#
    static let headerItem = headerItemTitle + #":[А-Яа-я ]*\d+(\.\d{3})*"#
    static let headerCompany = #"(?<=Название объекта:\s).*"#
    static let headerMonth = #"^(?!Оборот|Средний)(?:Месяц:)?\s?(?<monthStr>.*)$"#
    static let revenue = "Оборот"
    static let dailyAverage = "Средний показатель"
}
