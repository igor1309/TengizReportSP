//
//  GetSourcesTests.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 03.02.2021.
//

import XCTest
@testable import TengizReportSP

final class GetSourcesTests: XCTestCase {
    func test_GetSources() {
        let sourses = try? filenames
            .flatMap { filename in
                ReportContent(
                    stringLiteral: try filename
                        .contentsOfFile()
                        .clearReport()
                )
                //.body
                .footer
                .flatMap { $0.components(separatedBy: "\n") }
                //.filter { nil != $0.firstMatch(for: "Приход") }
            }
        XCTAssertNotEqual(sourses, [])

        XCTAssertEqual(bodyItems.count, 340)
        XCTAssertEqual(selectedBodyItems.count, 34)

        XCTAssertNotNil(selectedBodyItems.joined(separator: "\n"))
        XCTAssertNotNil(selectedFooterItems.joined(separator: "\n"))
    }
}
