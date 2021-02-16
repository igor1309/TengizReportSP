//
//  TokenizedReport+Ext.swift
//  UsingTengizReportSP
//
//  Created by Igor Malyarov on 10.02.2021.
//

import Model

#warning("write tests for all small funcs in this file")
extension TokenizedReport {
    struct Report: Equatable {
        let monthStr: String
        let month: Int
        let year: Int
        let company: String
        let revenue: Double
        let dailyAverage: Double
        let openingBalance: Double
        let balance: Double
        let runningBalance: Double
        let totalExpenses: Double
        #warning("finish with note")
        //                           let note: String

        let groups: [Group]

        struct Group: Equatable {
            let groupNumber: Int
            let title: String
            let amount: Double
            let target: Double?
            #warning("finish with note")
            //                    let note: String

            let items: [Item]

            struct Item: Equatable {
                let itemNumber: Int
                let title: String
                let amount: Double
                let note: String?
            }
        }
    }

    enum TransformationError: Error {
        case noMonth, noCompany, noRevenue, noDailyAverage,
             noOpeningBalance, noBalance, noRunningBalance, noTotalExpenses
    }

    func report() -> Result<Report, TransformationError> {
        guard let monthStr = header.monthStr() else { return .failure(.noMonth) }
        #warning("dummy mock: fix month")
        let month = 13
        #warning("dummy mock: fix year")
        let year = 2013

        guard let company = header.company() else { return .failure(.noCompany) }
        guard let revenue = header.revenue() else { return .failure(.noRevenue) }
        guard let dailyAverage = header.dailyAverage() else { return .failure(.noDailyAverage) }
        // guard let openingBalance = footer.openingBalance() else { return .failure(.noOpeningBalance) }
        #warning("error throwing paused here")
        let openingBalance = footer.openingBalance() ?? 0
        guard let balance = footer.balance() else { return .failure(.noBalance) }
        // guard let runningBalance = footer.runningBalance() else { return .failure(.noRunningBalance) }
        #warning("error throwing paused here")
        let runningBalance = footer.runningBalance() ?? openingBalance + balance
        guard let totalExpenses = footer.totalExpenses() else { return .failure(.noTotalExpenses) }

        let groups: [Report.Group] = body.compactMap { Report.Group(tokens: $0) }

        let report = Report(monthStr: monthStr,
                            month: month,
                            year: year,
                            company: company,
                            revenue: revenue,
                            dailyAverage: dailyAverage,
                            openingBalance: openingBalance,
                            balance: balance,
                            runningBalance: runningBalance,
                            totalExpenses: totalExpenses,
                            //                      note: note,
                            groups: groups)

        return .success(report)
    }
}

typealias Group = TokenizedReport.Report.Group
typealias Item = TokenizedReport.Report.Group.Item

extension TokenizedReport.Report.Group {
    init?(tokens: [Token<BodySymbol>]) {
        guard let groupNumber = tokens.groupNumber(),
              let title = tokens.title(),
              let amount = tokens.amount()
        else { return nil }

        let target = tokens.target()

        let items: [Item] = tokens.compactMap {
            switch $0.symbol {
                case let .item(itemNumber: itemNumber, title: title, value: value, note: note):
                    return Item(itemNumber: itemNumber, title: title, amount: value, note: note)
                default: return nil
            }
        }

        self.groupNumber = groupNumber
        self.title = title
        self.amount = amount
        self.target = target
        self.items = items
    }

}
