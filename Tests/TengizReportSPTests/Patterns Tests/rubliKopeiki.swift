//
//  rubliKopeiki.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 04.02.2021.
//

import XCTest
@testable import TengizReportSP

final class RubliKopeikiTests: XCTestCase {
    func test_GetSources() {
        let sourses = try? filenames
            .flatMap { filename in
                ReportContent(
                    stringLiteral: try filename
                        .contentsOfFile()
                        .clearReport()
                )
                .body
                .flatMap { $0.components(separatedBy: "\n") }
                .filter { nil != $0.firstMatch(for: #"\d{1,3}(\.\d{3})*\s*р"#) }
            }
        // XCTAssertEqual(sourses, [])
        // XCTAssertNil(sourses?.joined(separator: "\n").listMatches(for: Patterns.rubliKopeiki))

        // XCTAssertEqual(bodyItems.count, 340)
        // XCTAssertEqual(selectedBodyItems.count, 34)

        // XCTAssertNil(selectedBodyItems.joined(separator: "\n"))
    }
}

extension RegexPatternsTests {
    func test_rubliKopeiki() {
        XCTAssertEqual("1".firstMatch(for: Patterns.rubliKopeiki), "1")

        XCTAssertEqual("2.799".firstMatch(for: Patterns.rubliKopeiki), "2.799")

        XCTAssertEqual("12.170".firstMatch(for: Patterns.rubliKopeiki), "12.170")

        XCTAssertEqual("946.056".firstMatch(for: Patterns.rubliKopeiki), "946.056")

        XCTAssertEqual("2.344р 29к".firstMatch(for: Patterns.rubliKopeiki), "2.344р 29к")

        XCTAssertEqual("81.225р 35к".firstMatch(for: Patterns.rubliKopeiki), "81.225р 35к")

        XCTAssertEqual("244.472р 15к".firstMatch(for: Patterns.rubliKopeiki), "244.472р 15к")

        XCTAssertEqual("--. Аудит кантора (Бухуслуги)\t60.000\t\t\n".firstMatch(for:Patterns.rubliKopeiki), "60.000")
        XCTAssertEqual("\tПереходит минус с сентября 642.997р 43к\t\t\n".firstMatch(for:Patterns.rubliKopeiki), "642.997р 43к")
    }
}

extension NumberFromStringTests {
    func test_rubliKopeikiToDouble() {
        XCTAssertEqual("1".rubliKopeikiToDouble(), 1)

        XCTAssertEqual("2.799".rubliKopeikiToDouble(), 2_799)

        XCTAssertEqual("12.170".rubliKopeikiToDouble(), 12_170)

        XCTAssertEqual("946.056".rubliKopeikiToDouble(), 946_056)

        XCTAssertEqual("2.344р 29к".rubliKopeikiToDouble(), 2_344.29)

        XCTAssertEqual("81.225р 35к".rubliKopeikiToDouble(), 81_225.35)

        XCTAssertEqual("244.472р 15к".rubliKopeikiToDouble(), 244_472.15)

        XCTAssertEqual("--. Аудит кантора (Бухуслуги)\t60.000\t\t\n".rubliKopeikiToDouble(), 60_000)
        XCTAssertEqual("\tПереходит минус с сентября 642.997р 43к\t\t\n".rubliKopeikiToDouble(), 642_997.43)

    }
}
