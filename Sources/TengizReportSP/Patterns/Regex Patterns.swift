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
    // public static let body = #"(?m)^[А-Яа-я][^\n]*\n(^\d\d?\..*\n+)+ИТОГ:.*"#
    public static let body = #"(?m)"# + bodyHeader + #"("# + itemLine + #"|("# + itemCorrectionLine + #"\n))+ИТОГ:.*"#
    private static let bodyHeader = #"^[А-Яа-я][^\n]*\n"#

    public static let bodyHeaderFooterTitle = #"^[А-Яа-я][А-Яа-я ]+(?=:)"#

    private static let itemLine = #"(^\d\d?\..*\n+)"#

    public static let itemFullLineWithDigits = #"(?m)"# + itemTitle + #"\d+.*"#
    /// rows without digits except for line number
    public static let itemFullLineWithoutDigits = #"(?m)^[1-9]\d?\.\D*$"#

    // pattern to match numbers without rubliKopeiki
    public static let itemNumber = #"\d{1,3}(?:\.\d{3})*"#

    #warning("get back to pattern used in cleanReport")
    public static let rubliKopeiki = #"(?<integer>\d{1,3}(?:\.\d{3})*)(?:\s*р\s*(?<decimal>\d\d?)к)?"# //#"\d{1,3}(?:\.\d{3})*р(?: \d\d?к)?"#
           //>(?<=Итого|фактический)\s*\d{1,3}(?:\.\d{3})*р(?: \d\d?к)?).*)
    #warning("kopeiki - not used anymore?")
    //public static let kopeiki = #"((?<=р )\d\d?(?=к))"#
                                //((?<=р )\d\d?(?=к))

    public static let minus = #"(?:[М|м]инус\D*)|-(?=\d)"#

}
