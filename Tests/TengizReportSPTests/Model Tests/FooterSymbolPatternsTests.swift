//
//  FooterSymbolPatternsTests.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 29.01.2021.
//

import XCTest
@testable import TengizReportSP

final class FooterSymbolPatternsTests: XCTestCase {
    func test_numberWithSignAtStart() throws {
        XCTAssertNil("ИТОГ всех расходов за месяц:\t92.531р 15к"
                        .firstMatch(for: Patterns.numberWithSignAtStart))
        XCTAssertNil("Фактический остаток:\t-609.230р 46к\t20%"
                        .firstMatch(for: Patterns.numberWithSignAtStart))
        XCTAssertNil("Минус с июля 407.477р 46к, переходит"
                        .firstMatch(for: Patterns.numberWithSignAtStart))

        XCTAssertEqual("-173.753 переходит остаток с июня"
                        .firstMatch(for: Patterns.numberWithSignAtStart), "-173")
        XCTAssertEqual("-28.000 субсидия, поступила в июле"
                        .firstMatch(for: Patterns.numberWithSignAtStart), "-28")
        XCTAssertEqual("+23.334р 76к остаток с инвестиций"
                        .firstMatch(for: Patterns.numberWithSignAtStart), "+23")
    }

    func test_percentage() {

        //        let content = filenames
        //            .compactMap {
        //                try? $0.contentsOfFile()
        //            }
        //            .joined(separator: "\n")
        //        XCTAssertNil(content)
        #warning("actually pattern is used in footer - change testing strings")
        XCTAssertNotNil("4.Банковская 1.6% за эква\t12.111\t\t\n".firstMatch(for:Patterns.percentage))
        XCTAssertEqual("4.Банковская 1.6% за эква\t12.111\t\t\n".firstMatch(for:Patterns.percentage), "1.6%")
        XCTAssertEqual("4.Банковская 21.6% за эква\t12.111\t\t\n".firstMatch(for:Patterns.percentage), "21.6%")
        XCTAssertEqual("4.Банковская 221.6% за эква\t12.111\t\t\n".firstMatch(for:Patterns.percentage), "221.6%")
    }


}
