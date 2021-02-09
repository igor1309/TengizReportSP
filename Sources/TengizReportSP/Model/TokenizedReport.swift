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
    #warning("should use func clearReport()!!! - important replacements there")
    public init(stringLiteral string: String) {
        let reportContent = ReportContent(stringLiteral: string)
        let header = reportContent.header.map { Token<HeaderSymbol>(stringLiteral: $0) }

        let body = reportContent.body.map { array in
            array
                .components(separatedBy: "\n")
                .filter{ !$0.isEmpty }
                .map {
                    Token<BodySymbol>(stringLiteral: $0.trimmingCharacters(in: .whitespaces))
                }
        }

        let footer = reportContent.footer.map { Token<FooterSymbol>(stringLiteral: $0) }

        self = TokenizedReport(header: header, body: body, footer: footer)
    }
}
