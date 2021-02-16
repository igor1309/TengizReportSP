//
//  Saperavi_2020_07.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 09.02.2021.
//

import XCTest
@testable import Model
@testable import Originals

extension TokenizedReportTests {
    func test_init_Saperavi_2020_07() throws {
        let filename = SampleFiles.saperavi_2020_07
        let sample = TokenizedReport.saperavi_2020_07

        // MARK: checking tokens in sample
        sample.header.forEach { XCTAssertEqual($0.symbol, HeaderSymbol(stringLiteral: $0.source)) }
        sample.body.flatMap { $0 }.forEach { XCTAssertEqual($0.symbol, BodySymbol(stringLiteral: $0.source)) }
        sample.footer.forEach { XCTAssertEqual($0.symbol, FooterSymbol(stringLiteral: $0.source)) }

        let contents = try filename.contentsOfFile()
        let report = TokenizedReport(stringLiteral: contents)
        XCTAssertEqual(report, sample)

        // header
        XCTAssertEqual(report.header, sample.header)
        XCTAssertEqual(report.header.count, sample.header.count)
        zip(report.header, sample.header).forEach { XCTAssertEqual($0, $1) }

        // body
        XCTAssertEqual(report.body, sample.body)
        XCTAssertEqual(report.body.count, sample.body.count)

        XCTAssertEqual(report.body[3], sample.body[3])

        zip(report.body, sample.body).forEach { group, sample in
            XCTAssertEqual(group, sample)
            XCTAssertEqual(group.count, sample.count)

            zip(group, sample).forEach { token, sample in
                XCTAssertEqual(token, sample)
                XCTAssertEqual(token.source, sample.source)
                XCTAssertEqual(token.symbol, sample.symbol)
            }
        }

        // footer
        XCTAssertEqual(report.footer, sample.footer)
        XCTAssertEqual(report.footer.count, sample.footer.count)
        // XCTAssertNil(report.footer)
        zip(report.footer, sample.footer).forEach { XCTAssertEqual($0, $1) }
    }

}
