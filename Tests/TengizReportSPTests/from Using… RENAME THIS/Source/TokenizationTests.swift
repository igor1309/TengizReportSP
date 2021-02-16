//
//  TokenizationTests.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 14.02.2021.
//

import XCTest
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
            $0.fileContents
                .cleanContent()
                .tokenizedHeader()
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
            $0.fileContents
                .cleanContent()
                .tokenizedBody()
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
            $0.fileContents
                .cleanContent()
                .tokenizedFooter()
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

}
