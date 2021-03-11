//
//  FilesTests.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 28.01.2021.
//

import XCTest
@testable import TextReports

final class FilesTests: XCTestCase {
    func testTextFilesReadable() throws {
        XCTAssertEqual(ContentLoader.allFilenames.count, 12, "Report sample might have been added.")

        for filename in ContentLoader.allFilenames {
            XCTAssertFalse(try ContentLoader.contentsOfSampleFile(named: filename).get().isEmpty, "Can't read Report file content")
        }
    }
}
