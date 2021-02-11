//
//  ReportContentTests.swift
//  TengizReportSPTests
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

        XCTAssertEqual(SampleFiles.filenames.count, samples.count,
                       "File count should be equal to Samples count")

        try zip(SampleFiles.filenames, samples)
            .forEach { filename, sample in
                let contents = try filename.contentsOfFile()//.clearReport()
                let reportContent = ReportContent(stringLiteral: contents)

                XCTAssertNotEqual(reportContent, ReportContent.empty)

                XCTAssertFalse(reportContent.header.isEmpty, "Header should not be empty")
                XCTAssertFalse(reportContent.body.isEmpty, "Body should not be empty")
                XCTAssertFalse(reportContent.footer.isEmpty, "Footer should not be empty")

                XCTAssertEqual(reportContent.header, sample.header, "Header split error")
                zip(reportContent.header, sample.header).forEach { XCTAssertEqual($0, $1) }

                XCTAssertEqual(reportContent.body, sample.body, "Body split error")
                XCTAssertEqual(reportContent.body.count, sample.body.count, "Count should be equal to Samples count")
                zip(reportContent.body, sample.body).forEach { XCTAssertEqual($0, $1) }

                XCTAssertEqual(reportContent.footer, sample.footer, "Footer split error")
                zip(reportContent.footer, sample.footer).forEach { XCTAssertEqual($0, $1) }
            }
    }

    func test_Saperavi072020() throws {
        let contents = try SampleFiles.filenames[1].contentsOfFile()
        XCTAssertEqual(ReportContent(stringLiteral: contents), ReportContent.saperavi202007)
    }

    func test_Saperavi_2020_11() throws {
        let contents = try SampleFiles.filenames[5].contentsOfFile()
        XCTAssertEqual(ReportContent(stringLiteral: contents), ReportContent.saperavi202011)
    }

}

