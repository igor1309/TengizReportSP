//
//  GetFirstMatchAndRemainsTests.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 28.01.2021.
//

import XCTest
@testable import TengizReportSP

final class GetFirstMatchAndRemainsTests: XCTestCase {
    func testGetFirstMatchAndRemains() {
        let patterns = [#"(?:\w+)\d+"#, #"(\w*)"#]

        "Обслуживание 500+500+15.995\t"
            .getFirstMatchAndRemains(patterns: patterns) { match, remains in
                XCTAssertEqual(match, "500")
                XCTAssertEqual(remains, "Обслуживание +500+15.995")
            }

        let itemTitlePatterns = [Patterns.itemTitleWithPercentage,
                                 Patterns.itemTitleWithParentheses,
                                 Patterns.itemTitle]

        "4.Банковская комиссия 1.6% за эквайринг\t31.587\t"
            .getFirstMatchAndRemains(patterns: itemTitlePatterns) { match, remains in
                XCTAssertEqual(match, "4.Банковская комиссия 1.6% за эквайринг")
                XCTAssertEqual(remains, "31.587")
            }

        "22. Хэдхантер (подбор пероснала)\t4.227\t"
            .getFirstMatchAndRemains(patterns: itemTitlePatterns) { match, remains in
                XCTAssertEqual(match, "22. Хэдхантер (подбор пероснала)")
                XCTAssertEqual(remains, "4.227")
            }

        "6.Обслуживание кассовой программы Айко\t8.435\t\t"
            .getFirstMatchAndRemains(patterns: itemTitlePatterns) { match, remains in
                XCTAssertEqual(match, "6.Обслуживание кассовой программы Айко")
                XCTAssertEqual(remains, "8.435")
            }

    }

}
