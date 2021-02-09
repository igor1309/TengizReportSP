//
//  FooterSymbol+Ext.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 10.01.2021.
//

import Foundation

extension FooterSymbol: ExpressibleByStringLiteral {
    init(stringLiteral string: String) {
        self = {
            if let opening = string.openingBalance() { return opening }

            guard !string.isEmpty,
                  let item = string.footerItem() else { return .error }

            if let expenses = item.expensesTotal()       { return expenses }
            if let balance  = item.balance()             { return balance }
            if let extra    = item.extraIncomeExpenses() { return extra }
            if let running  = item.runningBalance()      { return running }

            return .error
        }()
    }
}

extension Patterns {
    static let numberWithSignAtStart = #"^\s*(-|\+)\d{1,3}"#
    static let bodyFooter = #"(?=ИТОГ:)\#(title)(?<value>\#(rubliKopeiki))$"#
}

extension String {
    func openingBalance() -> FooterSymbol? {
        // MARK: может отсутствовать в первый месяц, как в Саперави июнь 2020 и Щелково ноябрь 2020
        // структуру (колонки, наличие табуляции) см в файле Report Headers and Footers.xlsx
        /*
         -173.753 остаток с июня
         Минус с июля 407.477р 46 к., переходит
         Минус с августа переходит 739.626р 06к
         Переходит минус с сентября 642.997р 43к
         Переходящий минус 920.304р 17к
         Переходящий минус 1.065.596р 76к
         Остаток с ноября    684.753р85к
         */
        let openingBalance = #"^(?=.*?(?:статок|ереход))(?:(?!Фактический|инвестиций).)*$"#
        guard firstMatch(for: openingBalance) != nil else { return nil }
        let value = numberWithSign()

        return .openingBalance(title: self, value: value ?? 0)
    }
}

extension FooterItem {
    func balance() -> FooterSymbol? {
        /*
         Фактический остаток:\t173.753 \t20%
         Фактический остаток:\t-609.230р46к\t20%
         Фактический остаток:\t-355.483р 36к\t20%
         Фактический остаток:\t96.628р 63к\t20%
         Фактический остаток:\tМинус 277.306р 74к\t20%
         Фактический остаток:\tМинус 145.292р59к\t20%
         Фактический остаток:\t684.753р85к
         Фактический остаток:\t8.670р46к
         */
        guard title.firstMatch(for: "Фактический остаток:") != nil else { return nil }
        return .balance(title: "Фактический остаток", value: value ?? 0, percentage: percentage)
    }

    func expensesTotal() -> FooterSymbol? {
        /*
         ИТОГ всех расходов за месяц:\t92.531р15к
         ИТОГ всех расходов за месяц:\t1.677.077р46к
         ИТОГ всех расходов за месяц:\t2.094.271р 36к
         ИТОГ всех расходов за месяц:\t920.954р54к
         */
        guard title.firstMatch(for: "ИТОГ всех расходов за месяц:") != nil else { return nil }
        return .expensesTotal(title: "ИТОГ всех расходов за месяц", value: value ?? 0)
    }

    func extraIncomeExpenses() -> FooterSymbol? {
        /*
         two - so far - special cases:

         -28.000 субсидия, поступила в июле
         +23.334р 76к остаток с инвестиций
         */
        guard title.firstMatch(for: Patterns.numberWithSignAtStart) != nil,
              let value = title.numberWithSign()  else { return nil }
        return .extraIncomeExpenses(title: title, value: value)
    }

    func runningBalance() -> FooterSymbol? {
        // MARK: может отсутствовать, как в Саперави июнь 2020
        /*
         ИТОГ:\t-407.477р46к
         ИТОГ:\tМинус 1.179.498р65к
         ИТОГ:\t684.753р85к переносится на декабрь месяц
         ИТОГ:\t693.424р31к переносим на январь
         */
        guard title.firstMatch(for: #"(?!ИТОГ всех расходов за месяц:)(?=ИТОГ:)^.*$"#) != nil else { return nil }
        return .runningBalance(title: "ИТОГ", value: value ?? 0)
    }
}

