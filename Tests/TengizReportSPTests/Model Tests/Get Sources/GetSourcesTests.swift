//
//  GetSourcesTests.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 03.02.2021.
//

import XCTest
@testable import Model

final class GetSourcesTests: XCTestCase {
    func test_GetSources() {
        let sourses = try? SampleFiles.filenames
            .flatMap { filename in
                ReportContent(
                    stringLiteral: try filename
                        .contentsOfFile()
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

    func test_DeliveryHeader() throws {
        let deliveryHeaders = try SampleFiles.filenames.flatMap { filename -> [String] in
            let content = try filename.contentsOfFile()
            return content
                .components(separatedBy: "\n")
                .filter { $0.hasPrefix("Расходы на доставку") }
        }
        .removingDuplicates()

        let sample = ["Расходы на доставку:\t\t\t",
                      "Расходы на доставку:\t-----------------------------\t\t"]

        XCTAssertEqual(deliveryHeaders, sample)
    }
}
