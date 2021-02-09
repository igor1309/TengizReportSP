//
//  TokenizedReportTests.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 08.02.2021.
//

import XCTest
@testable import TengizReportSP

final class TokenizedReportTests: XCTestCase {
    func test_init_dummy() {
        XCTAssertNotNil(TokenizedReport(header: [], body: [], footer: []))
        XCTAssertNotNil(TokenizedReport(""))
        XCTAssertNotNil(TokenizedReport(stringLiteral: ""))
    }

}
