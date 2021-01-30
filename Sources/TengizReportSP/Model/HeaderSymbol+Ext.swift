//
//  HeaderToken+Ext.swift
//  TengizReportSPM
//
//  Created by Igor Malyarov on 10.01.2021.
//

import Foundation

extension HeaderSymbol: ExpressibleByStringLiteral {
    public init(stringLiteral string: String) {
        self = string.headerSymbol()
    }
}

public extension String {
    func headerSymbol() -> HeaderSymbol {

        // company
        if let companyString = self.firstMatch(for: Patterns.headerCompanyPattern) {
            return .company(name: companyString)
        }

        // month
        if let monthString = self.firstMatch(for: Patterns.headerMonthPattern) {
            return .month(monthStr: monthString)
        }

        // item
        if let title = self.firstMatch(for: Patterns.headerItemTitlePattern),
           let number = self.numberWithoutSign() {
            // return .item(title: title, value: number)
            #warning("pattern hardcoding is not nice")
            switch title {
                case "Оборот": return .revenue(number)
                case "Оборот факт": return .revenue(number)
                case "Средний показатель": return .dailyAverage(number)
                default: return .error
            }
        }

        return .error
    }
}

public extension Patterns {
    static let headerItemTitlePattern = #"[А-Яа-я ]+(?=:)"#
    static let headerItemPattern = headerItemTitlePattern + #":[А-Яа-я ]*\d+(\.\d{3})*"#
    static let headerCompanyPattern = #"(?<=Название объекта:\s).*"#
    static let headerMonthPattern = #"[А-Яа-я]+\d{4}"#
}
