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

        let cleanContent = string.cleanContent()

        // MARK: - Tokenize

        let header = cleanContent.tokenizedHeader()
        let body =   cleanContent.tokenizedBody()
        let footer = cleanContent.tokenizedFooter()

        self.init(header: header, body: body, footer: footer)
    }
}
