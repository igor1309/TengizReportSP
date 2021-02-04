//
//  bodyItemStart.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 04.02.2021.
//

import XCTest
@testable import TengizReportSP

extension Patterns {
    static let bodyItemStart = #"^\d+\."#
}

extension RegexPatternsTests {
    func test_bodyItemStart() {
        XCTAssertEqual(Patterns.bodyItemStart, #"^\d+\."#)

        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: Patterns.bodyItemStart) }.count,
                       33, "Total is 34, 'Correction' item line doesn't start with digits, so should be 33")
    }
}
