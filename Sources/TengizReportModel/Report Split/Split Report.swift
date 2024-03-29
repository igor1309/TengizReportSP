//
//  Split Report.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 15.02.2021.
//

import Foundation
import RegexTools

extension String {
    func header() -> String {
        self
            .replaceMatches(for: "\r\n", withString: "\n")
            .firstMatch(for: Patterns.header) ?? ""
    }

    func body() -> [String] {
        self
            .replaceMatches(for: "\r\n", withString: "\n")
            // cut header
            .replaceMatches(for: Patterns.header, withString: "")
            // cut footer
            .replaceMatches(for: Patterns.footer, withString: "")
            // delete column title row
            .replaceMatches(for: Patterns.columnTitleRow, withString: "")
            .listMatches(for: Patterns.body)
    }

    func footer() -> String {
        self
            .replaceMatches(for: "\r\n", withString: "\n")
            .firstMatch(for: Patterns.footer) ?? ""
    }
}

extension Patterns {
    static let header = #"(?m)(^(.*)\n)+?(?=Статья расхода:)"#
    static let footer = #"(?m)^ИТОГ всех расходов за месяц(?:.|\n)*$"#
    static let columnTitleRow = #"(?m)^Статья расхода:\s*Сумма расхода:\s*План %\s*Факт %\s*\n"#
    static let body = #"(?m)(?:^[А-Яа-я ]+:.*$)(?:\n.*$)+?\nИТОГ:.*"#
}
