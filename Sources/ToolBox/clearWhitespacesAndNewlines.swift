//
//  clearWhitespacesAndNewlines.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 28.01.2021.
//

import Foundation

extension String {

    /// clean whitespaces and empty lines
    public func clearWhitespacesAndNewlines() -> String {
        let cleanContent = self
            .components(separatedBy: "\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
            .joined(separator: "\n")

        let clean = cleanContent.replaceMatches(for: "\n\n", withString: "\n")
        return clean
    }

}
