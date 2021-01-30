//
//  HeaderToken+Ext.swift
//  TengizReportSPM
//
//  Created by Igor Malyarov on 10.01.2021.
//

import Foundation

extension HeaderSymbol: ExpressibleByStringLiteral {
    public init(stringLiteral string: String) {
        self = {
            if let company = string.company() { return company }
            if let month = string.month() { return month }
            if let item = string.item() { return item }

            return .error
        }()
    }
}

public extension String {
    func company() -> HeaderSymbol? {
        guard let companyString = self.firstMatch(for: Patterns.headerCompanyPattern) else { return nil }
        return .company(name: companyString)
    }

    func month() -> HeaderSymbol? {
        guard let monthString = self.firstMatch(for: Patterns.headerMonthPattern) else { return nil }
        return .month(monthStr: monthString)
    }

    func item() -> HeaderSymbol? {
        if let title = self.firstMatch(for: Patterns.headerItemTitlePattern),
           let number = self.numberWithoutSign() {
            // return .item(title: title, value: number)
            #warning("pattern hardcoding is not nice")
            switch title {
                case "Оборот": return .revenue(number)
                case "Оборот факт": return .revenue(number)
                case "Средний показатель": return .dailyAverage(number)
                default: return nil
            }
        } else {
            return nil
        }
    }
}

public extension Patterns {
    static let headerItemTitlePattern = #"[А-Яа-я ]+(?=:)"#
    static let headerItemPattern = headerItemTitlePattern + #":[А-Яа-я ]*\d+(\.\d{3})*"#
    static let headerCompanyPattern = #"(?<=Название объекта:\s).*"#
    static let headerMonthPattern = #"[А-Яа-я]+\d{4}"#
}
