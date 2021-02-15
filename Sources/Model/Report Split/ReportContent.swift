//
//  ReportContent.swift
//  TextViewApp
//
//  Created by Igor Malyarov on 05.01.2021.
//

import Foundation
import Toolbox

#warning("delete if not used any more")
internal struct ReportContent: Equatable {

    var header: [String]
    var body: [String]
    var footer: [String]

    internal init(header: [String], body: [String], footer: [String]) {
        self.header = header
        self.body = body
        self.footer = footer
    }

    static let empty = ReportContent(header: [], body: [], footer: [])
}

#warning("delete if not used any more")
extension ReportContent: ExpressibleByStringLiteral {
    init(stringLiteral string: String) {
        let delimiter = "$$$$$"

        let headerString = string.firstMatch(for: Patterns.header) ?? ""
        let header = headerString
            .replaceMatches(for: #"\t"#, withString: delimiter)
            .replaceMatches(for: #"\n"#, withString: delimiter)
            .components(separatedBy: delimiter)
            .map { $0.clearWhitespacesAndNewlines() }
            .filter { !$0.isEmpty }

        let footerString = string.firstMatch(for: Patterns.footer) ?? ""
        let footer = footerString
            .replaceMatches(for: #"\n"#, withString: delimiter)
            .components(separatedBy: delimiter)
            .map { $0.clearWhitespacesAndNewlines() }
            .filter { !$0.isEmpty }

        let body = string
            // cut header
            .replaceMatches(for: Patterns.header, withString: "")
            // cut footer
            .replaceMatches(for: Patterns.footer, withString: "")
            // delete column title row
            .replaceMatches(for: Patterns.columnTitleRow, withString: "")
            .listMatches(for: Patterns.body)

        self.init(header: header, body: body, footer: footer)
    }
}
