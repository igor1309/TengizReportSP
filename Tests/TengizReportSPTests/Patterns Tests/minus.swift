//
//  minus.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 09.02.2021.
//

import XCTest
@testable import Model

extension RegexPatternsTests {
    func test_minus() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.minus, #"(?:[М|м]инус\D*)|-(?=\d)"#)

        // MARK: no match
        XCTAssertNil("- sdf".firstMatch(for:Patterns.minus), "No number")
        XCTAssertNil("- ".firstMatch(for:Patterns.minus), "No number")
        XCTAssertNil("12. Интернет 323".firstMatch(for: Patterns.minus))
        XCTAssertNil("6. Обслуживание кассовой программы Айко 4.500+ item".firstMatch(for: Patterns.minus))
        XCTAssertNil("Оборот факт:141.690+1.238.900=1.380.590".firstMatch(for: Patterns.minus))

        // MARK: match
        XCTAssertNotNil("Минус".firstMatch(for:Patterns.minus))
        XCTAssertNotNil("Минус батарейки".firstMatch(for:Patterns.minus))
        XCTAssertNotNil("минус".firstMatch(for:Patterns.minus))
        XCTAssertNotNil("-2".firstMatch(for:Patterns.minus))
    }
}
