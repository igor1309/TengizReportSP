//
//  TokenizedReport.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 08.02.2021.
//

import Foundation
import Toolbox

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

extension String {
    func tokenizedHeader() -> [Token<HeaderSymbol>] {
        let delimiter = "$$$$$"

        return header()
            .replaceMatches(for: #"\t"#, withString: delimiter)
            .replaceMatches(for: #"\n"#, withString: delimiter)
            .components(separatedBy: delimiter)
            .map { $0.clearWhitespacesAndNewlines() }
            .filter { !$0.isEmpty }
            .map(Token<HeaderSymbol>.init)
    }

    func tokenizedBody() -> [[Token<BodySymbol>]] {
        self
            .body()
            .map { group in
                group
                    .components(separatedBy: "\n")
                    .map(Token<BodySymbol>.init)
                    .filter { $0.symbol != .empty }
            }
    }

    func tokenizedFooter() -> [Token<FooterSymbol>] {
        let delimiter = "$$$$$"

        return footer()
            .replaceMatches(for: #"\n"#, withString: delimiter)
            .components(separatedBy: delimiter)
            .map { $0.clearWhitespacesAndNewlines() }
            .filter { !$0.isEmpty }
            .map(Token<FooterSymbol>.init)
    }

}
