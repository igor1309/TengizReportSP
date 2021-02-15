//
//  tokenization.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 15.02.2021.
//

import Foundation

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
