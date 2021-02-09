//
//  Regex Patterns.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 25.12.2020.
//

import Foundation

enum Patterns {
    // MARK: Regular Expression Patterns
    ///  (?m) - MULTILINE mode on

    static let itemNumber = #"\d{1,3}(?:\.\d{3})*"#

    /// `math`
    static let math = #"\#(itemNumber)(?:\D*\s*\+\s*\#(itemNumber))+"#

    static let minus = #"(?:[М|м]инус\D*)|-(?=\d)"#

    static let rubliKopeiki = #"(?<integer>\#(Patterns.itemNumber))(?:\s*р\s*(?<decimal>\d\d?) ?к)?"#

    static let title = #"(?<title>^.*?)(?:\t\s*)"#
}
