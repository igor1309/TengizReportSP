//
//  ReportContentTests.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 28.01.2021.
//

import XCTest
@testable import TengizReportSP

final class ReportContentTests: XCTestCase {
    func testEmptyReportContent() {
        let reportContent = ReportContent.empty

        XCTAssert(reportContent.header.isEmpty, "Should be empty")
        XCTAssert(reportContent.body.isEmpty, "Should be empty")
        XCTAssert(reportContent.footer.isEmpty, "Should be empty")
    }

    func testEmptyReportContentExpressibleByStringLiteral() {
        let reportContent = ReportContent(stringLiteral: "")

        XCTAssert(reportContent.header.isEmpty, "Should be empty")
        XCTAssert(reportContent.body.isEmpty, "Should be empty")
        XCTAssert(reportContent.footer.isEmpty, "Should be empty")
    }

    func testSplitReportContent() throws {
        let samples = ReportContent.sampleContents

        XCTAssertEqual(filenames.count, samples.count,
                       "File count should be equal to Samples count")

        try zip(filenames, samples)
            .forEach { filename, sample in
                let contents = try filename.contentsOfFile()
                let reportContent = ReportContent(stringLiteral: contents)

                XCTAssertNotEqual(reportContent, ReportContent.empty)

                XCTAssertFalse(reportContent.header.isEmpty, "Header is empty")
                XCTAssertFalse(reportContent.body.isEmpty, "Body array is empty")
                XCTAssertFalse(reportContent.footer.isEmpty, "Footer is empty")

                XCTAssertEqual(reportContent.header, sample.header, "Header split error")
                XCTAssertEqual(reportContent.body, sample.body, "Body split error")
                XCTAssertEqual(reportContent.footer, sample.footer, "Footer split error")
            }
    }
}
