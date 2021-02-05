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
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.bodyItemStart, #"(?<title>^\d+\.\D+"#)

        let bodyItemStartToTest = "\(Patterns.bodyItemStart))"

        // MARK: exceptions
        XCTAssertNil("Хэдхантер (подбор пероснала)\t3.240".firstMatch(for: bodyItemStartToTest))

        // MARK: count in selectedBodyItems
        XCTAssertEqual(selectedBodyItems.compactMap { $0.firstMatch(for: bodyItemStartToTest) }.count,
                       33, "Total is 34, 'Correction' item line doesn't start with digits, so should be 33")

        // MARK: match

        XCTAssertEqual("1. Аренда торгового помещения\t--------"
                        .firstMatch(for: bodyItemStartToTest),
                       "1. Аренда торгового помещения\t--------")
        XCTAssertEqual("22. Хэдхантер (подбор пероснала)\t3.240"
                        .firstMatch(for: bodyItemStartToTest),
                       "22. Хэдхантер (подбор пероснала)\t")

        // MARK: regex structure
        XCTAssertEqual("1. Аренда торгового помещения\t--------"
                        .replaceFirstMatch(for: bodyItemStartToTest, withGroup: "title"),
                       "1. Аренда торгового помещения\t--------")
        XCTAssertNil("1. Аренда торгового помещения\t--------"
                        .replaceFirstMatch(for: bodyItemStartToTest, withGroup: "value"))
    }
}
