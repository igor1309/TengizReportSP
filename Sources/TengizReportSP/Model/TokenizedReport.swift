//
//  TokenizedReport.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 08.02.2021.
//

import Foundation

public struct TokenizedReport: Equatable {
    public var header: [Token<HeaderSymbol>]
    public var body: [[Token<BodySymbol>]]
    public var footer: [Token<FooterSymbol>]

    init(header: [Token<HeaderSymbol>], body: [[Token<BodySymbol>]], footer: [Token<FooterSymbol>]) {
        self.header = header
        self.body = body
        self.footer = footer
    }
}

extension TokenizedReport: ExpressibleByStringLiteral {
    public init(stringLiteral string: String) {

        // MARK: Cleaning & fixes

        let cleanContent = string
            //.clearWhitespacesAndNewlines()
            /// fix special line(s)
            .replaceMatches(for: #"\s*ВМ ЩК\s*"#,
                            withString: "Название объекта: Вай Мэ! Щелково\n")
            .replaceMatches(for: #"(?m)^ФОТ Бренд, логистика, бухгалтерия"#,
                            withString: "2. ФОТ Бренд, логистика, бухгалтерия")
            .replaceMatches(for: "Итого-",
                            withString: "Итого ")
            .replaceMatches(for: "Студиопак-",
                            withString: "Студиопак Итого ")

        let reportContent = ReportContent(stringLiteral: cleanContent)

        // MARK: Map Strings to Tokens

        header = reportContent.header.map(Token<HeaderSymbol>.init)

        body = reportContent.body.map { group in
            group
                .components(separatedBy: "\n")
                .map(Token<BodySymbol>.init)
                .filter { $0.symbol != .empty }
        }

        footer = reportContent.footer.map(Token<FooterSymbol>.init)
    }
}
