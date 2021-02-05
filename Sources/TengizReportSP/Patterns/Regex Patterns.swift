//
//  Regex Patterns.swift
//  
//
//  Created by Igor Malyarov on 25.12.2020.
//

import Foundation

public enum Patterns {
    // MARK: - Regular Expression Patterns
    ///  (?m) - MULTILINE mode on

    public static let itemNumber = #"\d{1,3}(?:\.\d{3})*"#

    public static let rubliKopeiki = #"(?<integer>\d{1,3}(?:\.\d{3})*)(?:\s*р\s*(?<decimal>\d\d?)к)?"#

    public static let minus = #"(?:[М|м]инус\D*)|-(?=\d)"#

}
