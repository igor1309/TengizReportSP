//
//  ReportContent.swift
//  TextViewApp
//
//  Created by Igor Malyarov on 05.01.2021.
//

import Foundation

internal struct ReportContent: Equatable {

    var header: [String]
    var body: [String]
    var footer: [String]

    internal init(header: [String], body: [String], footer: [String]) {
        self.header = header
        self.body = body
        self.footer = footer
    }

    static let empty = ReportContent(header: [], body: [], footer: [])
}

extension ReportContent: ExpressibleByStringLiteral {
    init(stringLiteral string: String) {
        let delimiter = "$$$$$"

        let headerString = string.firstMatch(for: Patterns.headerPattern) ?? ""
        let header = headerString
            .replaceMatches(for: #"\t"#, withString: delimiter)
            .replaceMatches(for: #"\n"#, withString: delimiter)
            .components(separatedBy: delimiter)
            .map { $0.clearWhitespacesAndNewlines() }
            .filter { !$0.isEmpty }

        let footerString = string.firstMatch(for: Patterns.footerPattern) ?? ""
        let footer = footerString
            .replaceMatches(for: #"\n"#, withString: delimiter)
            .components(separatedBy: delimiter)
            .map { $0.clearWhitespacesAndNewlines() }
            .filter { !$0.isEmpty }

        let body = string
            // cut header
            .replaceMatches(for: Patterns.headerPattern, withString: "")
            // cut footer
            .replaceMatches(for: Patterns.footerPattern, withString: "")
            // delete column title row
            .replaceMatches(for: Patterns.columnTitleRowPattern, withString: "")
            .listMatches(for: Patterns.bodyPattern)

        self.init(header: header, body: body, footer: footer)
    }
}

extension Patterns {
    static let headerPattern = #"(?m)(^(.*)\n)+?(?=Статья расхода:)"#
    static let footerPattern = #"(?m)^ИТОГ всех расходов за месяц(?:.|\n)*$"#
    static let columnTitleRowPattern = #"(?m)^Статья расхода:\s*Сумма расхода:\s*План %\s*Факт %\s*\n"#
    static let bodyPattern = #"(?m)(?:^[А-Яа-я ]+:.*$)(?:\n.*$)+?\nИТОГ:.*"#
}
