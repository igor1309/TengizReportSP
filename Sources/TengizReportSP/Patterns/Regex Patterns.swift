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
    /// matching lines like `"-10.000 за перерасход питание персонала в июле"`
    public static let itemCorrectionLine = #"^-\d{1,3}(?:\.\d{3})*.*"#

    public static let itemTitle = #"^[1-9]\d?\.[^\d\n]+"#
    public static let itemFullLineWithDigits = #"(?m)"# + itemTitle + #"\d+.*"#
    /// rows without digits except for line number
    public static let itemFullLineWithoutDigits = #"(?m)^[1-9]\d?\.\D*$"#

    /// matching lines like `"4.Банковская комиссия 1.6% за эквайринг    "` (mind whitespace)
    public static let itemTitleWithPercentage =  itemTitle + percentage + #"[\D]*"#
    // public static let itemTitleWithPercentagePattern =  #"^[1-9]\d?\.[\D]*\d+(\.\d+)?%[\D]*"#
    /// matching lines like `"22. Хэдхантер (подбор пероснала)    "` (mind whitespace)
    public static let itemTitleWithParentheses = itemTitle + #"\([^(]*\)[^\d\n]*"#

    public static let itemWithPlus = itemTitle + numbersWithPlus

    /// pattern to match `"200.000 (за август) +400.000 (за сентябрь)"` or `"7.701+4.500"`
    public static let numbersWithPlus = itemNumber + #"(?:\s*\([^\)]+\)\s*)?\+"# + itemNumber + #"(?:\s*\([^\)]+\)\s*)?"#

    public static let percentage = #"\d+(\.\d+)?%"#

    // pattern to match numbers without rubliKopeiki
    public static let itemNumber =   #"\d{1,3}(?:\.\d{3})*"#
    public static let rubliKopeiki = #"\d{1,3}(\.\d{3})*р( \d\d?к)?"#
    public static let kopeiki = #"((?<=р )\d\d?(?=к))"#

    public static let minus = #"(?:[М|м]инус\D*)|-(?=\d)"#

}
