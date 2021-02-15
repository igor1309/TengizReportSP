//
//  itemNumber.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 09.02.2021.
//

import XCTest
@testable import Model

extension RegexPatternsTests {
    func test_itemNumber() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.integer, #"\d{1,3}(?:\.\d{3})*"#)

        // MARK: no match
        XCTAssertNil("- sdf".firstMatch(for:Patterns.integer), "No number")
        XCTAssertNil("- ".firstMatch(for:Patterns.integer), "No number")

        // MARK: match
        XCTAssertEqual("-. Обслуживание кассовой программы Айко 4.500+ item".firstMatch(for: Patterns.integer),
                       "4.500")
        XCTAssertEqual("Оборот факт:141.690+1.238.900=1.380.590".firstMatch(for: Patterns.integer),
                       "141.690", "This is not math")
        XCTAssertEqual("12. Интернет 323".firstMatch(for: Patterns.integer), "12")
        XCTAssertEqual("--. Интернет 323".firstMatch(for: Patterns.integer), "323")
        XCTAssertEqual("23. Аудит кантора (Бухуслуги)\t60.000\t\t\n".firstMatch(for:Patterns.integer), "23")
        XCTAssertEqual("--. Аудит кантора (Бухуслуги)\t60.000\t\t\n".firstMatch(for:Patterns.integer), "60.000")

        XCTAssertEqual("\tПереходит минус с сентября 642.997р 43к\t\t\n".firstMatch(for:Patterns.rubliKopeiki),
                       "642.997р 43к")
    }
}
