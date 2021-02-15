//
//  Split Report.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 15.02.2021.
//

import Foundation
import Toolbox

extension String {
    func header() -> String {
        firstMatch(for: Patterns.header) ?? ""
    }

    func body() -> [String] {
        // cut header
        replaceMatches(for: Patterns.header, withString: "")
            // cut footer
            .replaceMatches(for: Patterns.footer, withString: "")
            // delete column title row
            .replaceMatches(for: Patterns.columnTitleRow, withString: "")
            .listMatches(for: Patterns.body)
    }

    func footer() -> String {
        firstMatch(for: Patterns.footer) ?? ""
    }
}
