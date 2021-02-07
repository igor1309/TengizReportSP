//
//  RegexPatternsTests.swift
//  
//
//  Created by Igor Malyarov on 28.01.2021.
//

import XCTest
@testable import TengizReportSP

final class RegexPatternsTests: XCTestCase {
    func test_itemNumber() {
        XCTAssertEqual("23. Аудит кантора (Бухуслуги)\t60.000\t\t\n".firstMatch(for:Patterns.itemNumber), "23")
        XCTAssertEqual("--. Аудит кантора (Бухуслуги)\t60.000\t\t\n".firstMatch(for:Patterns.itemNumber), "60.000")

        XCTAssertEqual("\tПереходит минус с сентября 642.997р 43к\t\t\n".firstMatch(for:Patterns.rubliKopeiki),
                       "642.997р 43к")
    }

    func test_minus() {
        XCTAssertNotNil("Минус".firstMatch(for:Patterns.minus))
        XCTAssertNotNil("минус".firstMatch(for:Patterns.minus))
        XCTAssertNotNil("-2".firstMatch(for:Patterns.minus))

        XCTAssertNil("- ".firstMatch(for:Patterns.minus))
    }
}
