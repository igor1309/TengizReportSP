//
//  SourceTests.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 12.02.2021.
//

import XCTest
@testable import TextReports
@testable import Model

class SourceTests: XCTestCase {
    func test_GET_SOURCE() throws {
        let contents = try ContentLoader.contentsOfSampleFile(ContentLoader.vaiMe_2021_01).get()
        // set 'XCTAssertNil' and filename to get file contents
        XCTAssertNotNil([contents], "Using array to have non-visible symbols")
    }

    func testFilesReadable() throws {
        XCTAssertEqual(ContentLoader.allFilenames.count, 11, "Might have been added report file(s)")

        for filename in ContentLoader.allFilenames {
            let contents = try ContentLoader.contentsOfSampleFile(filename).get()
            XCTAssertFalse(contents.isEmpty)
        }
    }

    // MARK: - Source static property 'fileContents' vs file contents

    func testAllFileContents() throws {
        let sources = Source.allSources
        let fileContents = try ContentLoader.allFilenames.map { try ContentLoader.contentsOfSampleFile($0).get() }

        XCTAssertEqual(fileContents.count, 11, "Might have been added report file(s)")
        XCTAssertEqual(sources.count, fileContents.count, "Might have been added report file(s)")

        zip(sources, fileContents).forEach { source, fileContents in
            XCTAssertEqual([source.fileContents], [fileContents], "Using array to have non-visible symbols")
        }
    }

    // MARK: - testing header/body/footer funcs vs samples (Source static properties)

    func testAllSourcesHeader() {
        for source in Source.allSources {
            XCTAssertEqual([source.fileContents.header()], [source.header], "Using array to have non-visible symbols")
        }
    }

    func testAllSourcesBody() {
        for source in Source.allSources {
            let body = source.fileContents.body()

            XCTAssertEqual(body, source.body)
            XCTAssertEqual(body.count, source.body.count)

            zip(body, source.body).forEach {
                XCTAssertEqual([$0.0], [$0.1], "Using array to have non-visible symbols")
            }
        }
    }

    func testAllSourcesFooter() {
        for source in Source.allSources {
            XCTAssertEqual([source.fileContents.footer()], [source.footer], "Using array to have non-visible symbols")
        }
    }


    // MARK: - testing header/body/footer funcs vs file contents

    func testHeaderFunc() throws {
        let sources = Source.allSources
        let fileContents = try ContentLoader.allFilenames.map { try ContentLoader.contentsOfSampleFile($0).get() }

        XCTAssertEqual(fileContents.count, 11, "Might have been added report file(s)")
        XCTAssertEqual(sources.count, fileContents.count, "Might have been added report file(s)")

        zip(sources, fileContents).forEach { source, fileContents in
            XCTAssertEqual([source.header], [fileContents.header()], "Using array to have non-visible symbols")
        }
    }

    func testBodyFunc() throws {
        let sources = Source.allSources
        let fileContents = try ContentLoader.allFilenames.map { try ContentLoader.contentsOfSampleFile($0).get() }

        XCTAssertEqual(fileContents.count, 11, "Might have been added report file(s)")
        XCTAssertEqual(sources.count, fileContents.count, "Might have been added report file(s)")

        zip(sources, fileContents).forEach { source, fileContents in
            XCTAssertEqual([source.body], [fileContents.body()], "Using array to have non-visible symbols")
            XCTAssertEqual(source.body.count, fileContents.body().count)

            zip(source.body, fileContents.body()).forEach { sample, group in
                // body element (group) does not have '\n' at the end
                XCTAssertEqual([sample], [group], "Using array to have non-visible symbols")
            }
        }
    }

    func testFooterFunc() throws {
        let sources = Source.allSources
        let fileContents = try ContentLoader.allFilenames.map { try ContentLoader.contentsOfSampleFile($0).get() }

        XCTAssertEqual(fileContents.count, 11, "Might have been added report file(s)")
        XCTAssertEqual(sources.count, fileContents.count, "Might have been added report file(s)")

        zip(sources, fileContents).forEach { source, fileContents in
            XCTAssertEqual([source.footer], [fileContents.footer()], "Using array to have non-visible symbols")
        }
    }

}

extension Source: ExpressibleByStringLiteral {
    init(stringLiteral string: String) {
        fileContents = string
        header = string.header()
        body = string.body()
        footer = string.footer()
    }
}

final class SourceExpressibleByStringLiteralTests: XCTestCase {
    func testExpressibleByStringLiteral() {
        let sources = Source.allSources

        for source in sources {
            let testSource = Source(stringLiteral: source.fileContents)

            XCTAssertEqual([testSource.header], [source.header])
            XCTAssertEqual(testSource.body, source.body)
            XCTAssertEqual([testSource.footer], [source.footer])
        }
    }

}
