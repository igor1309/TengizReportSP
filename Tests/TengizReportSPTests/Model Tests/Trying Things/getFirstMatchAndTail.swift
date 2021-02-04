//
//  getFirstMatchAndTail.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 03.02.2021.
//

import XCTest
@testable import TengizReportSP

extension String {
    /// Get non-empty match for pattern and remains of string (tail).
    /// Returning nil if no pattern match.
    /// If match or tail is empty return nil.
    /// - Parameter pattern: pattern to match
    /// - Returns: tuple for match and tail or nil
    func getFirstMatchAndTail(for pattern: String) -> (String, String)? {
        guard let match = firstMatch(for: pattern)?.trimmingCharacters(in: .whitespaces),
              !match.isEmpty,
              let tail = replaceFirstMatch(for: pattern, withString: "")?.trimmingCharacters(in: .whitespaces),
              !tail.isEmpty
        else { return nil }

        return (match, tail)
    }
}

final class BodySymbolTests_Experimental: XCTestCase {
    func test_getFirstMatchAndTail() throws {
        var (match1, tail1) = "4. Банковская комиссия 1.6% за эквайринг\t2.120"
            .getFirstMatchAndTail(for: Patterns.itemTitleWithPercentage) ?? ("", "")
        XCTAssertEqual(match1, "4. Банковская комиссия 1.6% за эквайринг")
        XCTAssertEqual(tail1, "2.120")

        (match1, tail1) = "4. Банковская комиссия 1.6% за эквайринг\t2.120"
            .getFirstMatchAndTail(for: Patterns.itemTitleWithPercentage) ?? ("", "")

        guard let (match, tail) = "4. Банковская комиссия 1.6% за эквайринг\t2.120"
                .getFirstMatchAndTail(for: Patterns.itemTitleWithPercentage) else {
            XCTFail()
            return
        }
        XCTAssertEqual(match, "4. Банковская комиссия 1.6% за эквайринг")
        XCTAssertEqual(tail, "2.120")
    }
}
