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
        /// make some cleaning & fixes
        let cleanContent = string
            //.clearWhitespacesAndNewlines()
            // fix special line(s)
            .replaceMatches(for: #"\s*ВМ ЩК\s*"#,
                            withString: "Название объекта: Вай Мэ! Щелково\n")
            .replaceMatches(for: #"(?m)^ФОТ Бренд, логистика, бухгалтерия"#,
                            withString: "2. ФОТ Бренд, логистика, бухгалтерия")
            .replaceMatches(for: "Итого-",
                            withString: "Итого ")
            .replaceMatches(for: "Студиопак-",
                            withString: "Студиопак Итого ")
        /*
         /// remove optionality from rubli-kopeiki making rubliKopeikiPattern and kopeikiPatterm simpler/uniform
         .replaceMatches(for: #"(\d{1,3}(?:\.\d{3})*) *р *(?:(\d\d?) *к\.?)"#,
         withString: #"$1р $2к"#)
         /// rubli without kopeiki -> just number without `р` sign
         .replaceMatches(for: #"(\d{1,3}(?:\.\d{3})*) *р(?= [^\dк)])"#,
         withString: #"$1"#)
         /// fix no space after dot after line number
         .replaceMatches(for: #"(?m)(^\d+.)([А-Я])"#, withString: #"$1 $2"#)
         */

        let reportContent = ReportContent(stringLiteral: cleanContent)

        let header = reportContent.header.map { Token<HeaderSymbol>(stringLiteral: $0) }

        let body = reportContent.body.map { group in
            group
                .components(separatedBy: "\n")
                .filter{ !$0.isEmpty }
                .map {
                    Token<BodySymbol>(stringLiteral: $0)//.trimmingCharacters(in: .whitespaces))
                }
                .filter { $0.symbol != .empty }
        }

        let footer = reportContent.footer.map { Token<FooterSymbol>(stringLiteral: $0) }

        self = TokenizedReport(header: header, body: body, footer: footer)
    }
}
