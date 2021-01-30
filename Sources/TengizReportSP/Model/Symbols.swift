//
//  Symbols.swift
//  TextViewApp
//
//  Created by Igor Malyarov on 11.01.2021.
//

import Foundation

//public enum Symbols {

    public enum HeaderSymbol: Hashable, Equatable {
        case company(name: String)
        case month(monthStr: String)
        case revenue(Double)
        case dailyAverage(Double)
        case error
    }

    public enum BodySymbol: Hashable, Equatable {
        case item(title: String, value: Double, comment: String?)
        case header(title: String, value: Double?, percentage: Double?)
        case footer(title: String, value: Double?)
        case empty
    }

    public enum FooterSymbol: Hashable, Equatable {
        case expensesTotal(title: String, value: Double)
        /// сальдо доходов-расходов
        case balance(title: String, value: Double, percentage: Double?)
        case openingBalance(title: String, value: Double)
        case extraIncomeExpenses(title: String, value: Double)
        case runningBalance(title: String, value: Double)
        case error
    }
//}
