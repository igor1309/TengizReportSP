//
//  Generic Token.swift
//  TengizReportSPM
//
//  Created by Igor Malyarov on 11.01.2021.
//

import Foundation

// MARK: Token

struct Token<Symbol: TokenSymbol>: Equatable, Hashable {
    let source: String
    let symbol: Symbol
    
    init(source: String, symbol: Symbol) {
        self.source = source
        self.symbol = symbol
    }
}

extension Token: ExpressibleByStringLiteral {
    init(stringLiteral string: String) {
        self.init(source: string, symbol: Symbol(stringLiteral: string))
    }
}

// MARK: TokenSymbol

protocol TokenSymbol: Hashable,
                             ExpressibleByStringLiteral where StringLiteralType == String {}

extension HeaderSymbol: TokenSymbol {}
extension BodySymbol: TokenSymbol {}
extension FooterSymbol: TokenSymbol {}
