//
//  TokenizedReport+Ext.swift
//  UsingTengizReportSP
//
//  Created by Igor Malyarov on 10.02.2021.
//

//import TengizReportModel

extension TokenizedReport {
    public struct Report: Equatable {
        public let monthStr: String
        public let month: Int
        public let year: Int
        public let company: String
        public let revenue: Double
        public let dailyAverage: Double
        public let openingBalance: Double
        public let balance: Double
        public let runningBalance: Double
        public let totalExpenses: Double
        #warning("finish with note")
        //                           public let note: String

        public let groups: [Group]

        public struct Group: Equatable, Hashable {
            public let groupNumber: Int
            public let title: String
            public let amount: Double
            public let target: Double?
            #warning("finish with note")
            //                    public let note: String

            public let items: [Item]

            public struct Item: Equatable, Hashable {
                public let itemNumber: Int
                public let title: String
                public let amount: Double
                public let note: String?

                public init(itemNumber: Int, title: String, amount: Double, note: String?) {
                    self.itemNumber = itemNumber
                    self.title = title
                    self.amount = amount
                    self.note = note
                }
            }

            public init(groupNumber: Int, title: String, amount: Double, target: Double?, items: [TokenizedReport.Report.Group.Item]) {
                self.groupNumber = groupNumber
                self.title = title
                self.amount = amount
                self.target = target
                self.items = items
            }
        }

        public init(monthStr: String, month: Int, year: Int, company: String, revenue: Double, dailyAverage: Double, openingBalance: Double, balance: Double, runningBalance: Double, totalExpenses: Double, groups: [TokenizedReport.Report.Group]) {
            self.monthStr = monthStr
            self.month = month
            self.year = year
            self.company = company
            self.revenue = revenue
            self.dailyAverage = dailyAverage
            self.openingBalance = openingBalance
            self.balance = balance
            self.runningBalance = runningBalance
            self.totalExpenses = totalExpenses
            self.groups = groups
        }
    }

    public enum TransformationError: String, Error {
        case noMonth, noCompany, noRevenue, noDailyAverage,
             noOpeningBalance, noBalance, noRunningBalance, noTotalExpenses
    }

    public func report() -> Result<Report, TransformationError> {
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
    public init?(tokens: [Token<BodySymbol>]) {
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
