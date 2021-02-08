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
         XCTAssertNotEqual(sourses, [])
        // XCTAssertNil(sourses?.joined(separator: "\n").listMatches(for: Patterns.rubliKopeiki))

        // XCTAssertEqual(bodyItems.count, 340)
        // XCTAssertEqual(selectedBodyItems.count, 34)

        // XCTAssertNil(selectedBodyItems.joined(separator: "\n"))
    }
}

extension RegexPatternsTests {
    func test_rubliKopeiki() {
        XCTAssertEqual(Patterns.rubliKopeiki, #"(?<integer>\d{1,3}(?:\.\d{3})*)(?:\s*р\s*(?<decimal>\d\d?) ?к)?"#)

        XCTAssertNil("".firstMatch(for: Patterns.rubliKopeiki))
        XCTAssertNil("asfasdf wef hg".firstMatch(for: Patterns.rubliKopeiki))

        XCTAssertEqual("22.22".firstMatch(for: Patterns.rubliKopeiki), "22")

        XCTAssertEqual("2".firstMatch(for: Patterns.rubliKopeiki), "2")
        XCTAssertEqual("df45".firstMatch(for: Patterns.rubliKopeiki), "45")
        XCTAssertEqual("9999".firstMatch(for: Patterns.rubliKopeiki), "999")

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
        XCTAssertNil("".rubliKopeikiToDouble())
        XCTAssertNil("asfasdf wef hg".rubliKopeikiToDouble())

        XCTAssertEqual("22.22".rubliKopeikiToDouble(), 22)

        XCTAssertEqual("2".rubliKopeikiToDouble(), 2)
        XCTAssertEqual("df45".rubliKopeikiToDouble(), 45)
        XCTAssertEqual("9999".rubliKopeikiToDouble(), 999)

        XCTAssertEqual("1".rubliKopeikiToDouble(), 1)
        XCTAssertEqual("2.799".rubliKopeikiToDouble(), 2_799)
        XCTAssertEqual("12.170".rubliKopeikiToDouble(), 12_170)
        XCTAssertEqual("946.056".rubliKopeikiToDouble(), 946_056)
        XCTAssertEqual("2.344р 29к".rubliKopeikiToDouble(), 2_344.29)
        XCTAssertEqual("81.225р 35к".rubliKopeikiToDouble(), 81_225.35)
        XCTAssertEqual("244.472р 15к".rubliKopeikiToDouble(), 244_472.15)

        XCTAssertEqual("--. Аудит кантора (Бухуслуги)\t60.000\t\t\n".rubliKopeikiToDouble(), 60_000)
        XCTAssertEqual("\tПереходит минус с сентября 642.997р 43к\t\t\n".rubliKopeikiToDouble(), 642_997.43)

        XCTAssertNotEqual("74к".rubliKopeikiToDouble(), 0.74, "Doesn't work without rubles")

        XCTAssertEqual("3р 74 к".rubliKopeikiToDouble(), 3.74)
        XCTAssertEqual("3р 74к".rubliKopeikiToDouble(), 3.74)
        XCTAssertEqual("63р 74к ".rubliKopeikiToDouble(), 63.74)
        XCTAssertEqual("63р 74к".rubliKopeikiToDouble(), 63.74)
        XCTAssertEqual("863р 74к".rubliKopeikiToDouble(), 863.74)
        XCTAssertEqual("5.863р 74к".rubliKopeikiToDouble(), 5863.74)

        XCTAssertEqual(" 13.318р93к".rubliKopeikiToDouble(), 13_318.93)
        XCTAssertEqual(" 13.318р93 к  ".rubliKopeikiToDouble(), 13_318.93)
        XCTAssertEqual("  13.318р 93 к  ".rubliKopeikiToDouble(), 13_318.93)
        XCTAssertEqual("  13.318р 93к  ".rubliKopeikiToDouble(), 13_318.93)
        XCTAssertEqual("  75.255р  20к  ".rubliKopeikiToDouble(), 75_255.2)
        XCTAssertEqual("  98.340р24к  ".rubliKopeikiToDouble(), 98_340.24)

        XCTAssertEqual("  145.292р 59 к   ".rubliKopeikiToDouble(), 145_292.59)
        XCTAssertEqual("  145.292р 59к   ".rubliKopeikiToDouble(), 145_292.59)
        XCTAssertEqual("  739.626р  06к   ".rubliKopeikiToDouble(), 739_626.06)
        XCTAssertEqual("  922.936р30к   ".rubliKopeikiToDouble(), 922_936.3)

        XCTAssertEqual("  1.065.596р 76 к  ".rubliKopeikiToDouble(), 106_5596.76)
        XCTAssertEqual("  1.065.596р 76к  ".rubliKopeikiToDouble(), 106_5596.76)
        XCTAssertEqual("  1.677.077р  46к  ".rubliKopeikiToDouble(), 167_7077.46)
        XCTAssertEqual("  2.030.572р59к  ".rubliKopeikiToDouble(), 203_0572.59)

        XCTAssertEqual("     841р ".rubliKopeikiToDouble(), 841.0)
        XCTAssertEqual("   7.841р ".rubliKopeikiToDouble(), 7_841.0)
        XCTAssertEqual("  90.841р ".rubliKopeikiToDouble(), 90_841.0)
        XCTAssertEqual("907.841р".rubliKopeikiToDouble(), 907_841.0)
        XCTAssertEqual(" 946.056р ".rubliKopeikiToDouble(), 946_056.0)

    }
}
