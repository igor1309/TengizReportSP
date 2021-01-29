//
//  ReportContent.swift
//  TextViewApp
//
//  Created by Igor Malyarov on 05.01.2021.
//

import Foundation

public struct ReportContent: Equatable {

    public var header: String
    public var body: [String]
    public var footer: String

    public init(header: String, body: [String], footer: String) {
        self.header = header
        self.body = body
        self.footer = footer
    }

    public static let empty = ReportContent(header: "", body: [], footer: "")
}

extension ReportContent: ExpressibleByStringLiteral {
    public init(stringLiteral string: String) {
        let header = string.firstMatch(for: Patterns.headerPattern) ?? ""
        let footer = string.firstMatch(for: Patterns.footerPattern) ?? ""

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

public extension Patterns {
    static let headerPattern: String = { #"(?m)(^(.*)\n)+?(?=Статья расхода:)"# }()
    static let footerPattern: String = { #"(?m)^ИТОГ всех расходов за месяц.*\n(^.*\n)*"# }()
    static let columnTitleRowPattern: String = { #"(?m)^Статья расхода:\s*Сумма расхода:\s*План %\s*Факт %\s*\n"# }()
    static let bodyPattern: String = { #"(?m)(?:^[А-Яа-я ]+:.*$)(?:\n.*$)+?\nИТОГ:.*"# }()
}
