//
//  FilesTests.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 28.01.2021.
//

import XCTest
import TextReports

final class FilesTests: XCTestCase {
    func testTextFilesReadable() throws {
        XCTAssertEqual(ContentLoader.allFilenames.count, 11, "Report sample might have been added.")

        for filename in ContentLoader.allFilenames {
            XCTAssertFalse(try ContentLoader.contentsOfFile(filename).get().isEmpty, "Can't read Report file content")
        }
    }
}
