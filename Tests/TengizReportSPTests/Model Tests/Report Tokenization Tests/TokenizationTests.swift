//
//  TokenizationTests.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 14.02.2021.
//

import XCTest
import TextReports
@testable import Model

extension TokenizedReport {
    static let someReports = [
        saperavi_2020_06,
        saperavi_2020_07,
        saperavi_2020_09,
        saperavi_2020_10,
        saperavi_2020_11,

        vaiMe_2020_12
    ]
}

extension Source {
    static let someSources = [
        saperavi_2020_06,
        saperavi_2020_07,
        saperavi_2020_09,
        saperavi_2020_10,
        saperavi_2020_11,

        vaiMe_2020_12
    ]
}

final class TokenizationTests: XCTestCase {

    // MARK: - tokenizedHeader()

    func testTokenizedHeaderSomeSources() {
        let sources = Source.someSources.flatMap {
            $0.fileContents.tokenizedHeader()
        }

        let tokens = TokenizedReport.someReports.flatMap(\.header)

        XCTAssertNotEqual(sources.count, 0)
        XCTAssertEqual(sources.count, tokens.count)

        zip(sources, tokens).forEach { source, token in
            XCTAssertEqual(source, token)
            XCTAssertEqual(source.source, token.source)
            XCTAssertEqual(source.symbol, token.symbol)
        }
    }

    // MARK: - tokenizedBody()

    func testTokenizedBodySomeSources() {
        let sources = Source.someSources.flatMap {
            $0.fileContents.tokenizedBody()
        }

        let tokens = TokenizedReport.someReports.flatMap(\.body)

        XCTAssertNotEqual(sources.count, 0)
        XCTAssertEqual(sources.count, tokens.count)

        zip(sources, tokens).forEach { sources, tokens in
            XCTAssertEqual(sources, tokens)
            XCTAssertNotEqual(sources.count, 0)
            XCTAssertEqual(sources.count, tokens.count)

            zip(sources, tokens).forEach { source, token in
                XCTAssertEqual(source, token)
                XCTAssertEqual(source.source, token.source)
                XCTAssertEqual(source.symbol, token.symbol)
            }
        }
    }

    // MARK: - tokenizedFooter()

    func testTokenizedFooterSomeSources() {
        let sources = Source.someSources.flatMap {
            $0.fileContents.tokenizedFooter()
        }

        let tokens = TokenizedReport.someReports.flatMap(\.footer)

        XCTAssertNotEqual(sources.count, 0)
        XCTAssertEqual(sources.count, tokens.count)

        zip(sources, tokens).forEach { source, token in
            XCTAssertEqual(source, token)
            XCTAssertEqual(source.source, token.source)
            XCTAssertEqual(source.symbol, token.symbol)
        }
    }

    // MARK: - Tokenization via init

    func testTokenizationAllTextReports() throws {
        XCTAssertEqual(ContentLoader.allFilenames.count, 11, "Might have been added new report(s).")

        for filename in ContentLoader.allFilenames {
            let contents = try ContentLoader.contentsOfFile(filename).get()
            let report = try TokenizedReport(stringLiteral: contents).report().get()

            XCTAssertFalse(report.company.isEmpty)
            XCTAssertFalse(report.balance == 0)
            XCTAssertFalse(report.groups.isEmpty)
        }
    }
}
