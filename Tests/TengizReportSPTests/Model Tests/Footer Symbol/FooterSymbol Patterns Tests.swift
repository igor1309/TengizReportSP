//
//  FooterSymbolPatternsTests.swift
//  TengizReportSPTests
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

        XCTAssertEqual("-173.753 остаток с июня"
                        .firstMatch(for: Patterns.numberWithSignAtStart), "-173")
        XCTAssertEqual("-28.000 субсидия, поступила в июле"
                        .firstMatch(for: Patterns.numberWithSignAtStart), "-28")
        XCTAssertEqual("+23.334р 76к остаток с инвестиций"
                        .firstMatch(for: Patterns.numberWithSignAtStart), "+23")
    }
}
