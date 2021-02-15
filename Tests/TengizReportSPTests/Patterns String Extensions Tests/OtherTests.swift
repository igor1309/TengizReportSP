//
//  OtherTests.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 04.02.2021.
//

import XCTest
@testable import Model

extension String {
    func match(for pattern: String) -> String? {
        self == pattern ? pattern : nil
    }

    func create() -> String {
        let patterns: [String] = ["AAA", "BBBB", "CCCCC"]

        for pattern in patterns {
            if let symbol = self.match(for: pattern) { return symbol }
        }

        return ""
    }
}

final class OtherTests: XCTestCase {
    func test_match() {
        XCTAssertNil("AAA".match(for: "AA"))
        XCTAssertEqual("AAA".match(for: "AAA"), "AAA")
    }

    func test_create() {
        XCTAssertEqual("A".create(), "")
        XCTAssertEqual("AA".create(), "")
        XCTAssertEqual("AAA".create(), "AAA")
        XCTAssertEqual("BBBB".create(), "BBBB")
        XCTAssertEqual("CCCCC".create(), "CCCCC")
    }
}
