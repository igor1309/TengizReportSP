//
//  itemNumber.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 09.02.2021.
//

import XCTest
@testable import TengizReportSP

extension RegexPatternsTests {
    func test_itemNumber() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.itemNumber, #"\d{1,3}(?:\.\d{3})*"#)

        // MARK: no match
        XCTAssertNil("- sdf".firstMatch(for:Patterns.itemNumber), "No number")
        XCTAssertNil("- ".firstMatch(for:Patterns.itemNumber), "No number")

        // MARK: match
        XCTAssertEqual("-. Обслуживание кассовой программы Айко 4.500+ item".firstMatch(for: Patterns.itemNumber),
                       "4.500")
        XCTAssertEqual("Оборот факт:141.690+1.238.900=1.380.590".firstMatch(for: Patterns.itemNumber),
                       "141.690", "This is not math")
        XCTAssertEqual("12. Интернет 323".firstMatch(for: Patterns.itemNumber), "12")
        XCTAssertEqual("--. Интернет 323".firstMatch(for: Patterns.itemNumber), "323")
        XCTAssertEqual("23. Аудит кантора (Бухуслуги)\t60.000\t\t\n".firstMatch(for:Patterns.itemNumber), "23")
        XCTAssertEqual("--. Аудит кантора (Бухуслуги)\t60.000\t\t\n".firstMatch(for:Patterns.itemNumber), "60.000")

        XCTAssertEqual("\tПереходит минус с сентября 642.997р 43к\t\t\n".firstMatch(for:Patterns.rubliKopeiki),
                       "642.997р 43к")
    }
}
