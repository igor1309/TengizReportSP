//
//  bodyItemStart.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 04.02.2021.
//

import XCTest
@testable import TengizReportSP

extension RegexPatternsTests {
    func test_bodyItemStart() {
        XCTAssertEqual(Patterns.bodyItemStart, #"^\d+\."#)

        XCTAssertEqual("1. Аренда торгового помещения\t--------".firstMatch(for: Patterns.bodyItemStart), "1.")
        XCTAssertEqual("22. Хэдхантер (подбор пероснала)\t3.240".firstMatch(for: Patterns.bodyItemStart), "22.")

        XCTAssertNil("Хэдхантер (подбор пероснала)\t3.240".firstMatch(for: Patterns.bodyItemStart))

        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: Patterns.bodyItemStart) }.count,
                       33, "Total is 34, 'Correction' item line doesn't start with digits, so should be 33")
    }
}
