//
//  Generic Token.swift
//  TengizReportSPM
//
//  Created by Igor Malyarov on 11.01.2021.
//

import Foundation

// MARK: Token

public struct Token<Symbol: TokenSymbol>: Equatable, Hashable {
    public let source: String
    public let symbol: Symbol
    
    public init(source: String, symbol: Symbol) {
        self.source = source
        self.symbol = symbol
    }
}

extension Token: ExpressibleByStringLiteral {
    public init(stringLiteral string: String) {
        self.init(source: string, symbol: Symbol(stringLiteral: string))
    }
}

// MARK: TokenSymbol

public protocol TokenSymbol: Hashable,
                             ExpressibleByStringLiteral where StringLiteralType == String {}

extension HeaderSymbol: TokenSymbol {}
extension BodySymbol: TokenSymbol {}
extension FooterSymbol: TokenSymbol {}
