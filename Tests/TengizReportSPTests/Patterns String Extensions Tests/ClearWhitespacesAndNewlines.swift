//
//  ClearWhitespacesAndNewlines.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 28.01.2021.
//

import XCTest
@testable import TengizReportModel

final class ClearWhitespacesAndNewlines: XCTestCase {
    func testClearWhitespacesAndNewlines() {
        XCTAssertEqual("", "".clearWhitespacesAndNewlines())
        XCTAssertEqual("some text", "some text".clearWhitespacesAndNewlines())
        XCTAssertEqual("", " ".clearWhitespacesAndNewlines())
        XCTAssertNotEqual(" ", " ".clearWhitespacesAndNewlines())
        XCTAssertEqual("", " \n ".clearWhitespacesAndNewlines())
        XCTAssertEqual("", " \t ".clearWhitespacesAndNewlines())
        XCTAssertEqual("some text", " \t some text \t \n \t".clearWhitespacesAndNewlines())
        XCTAssertEqual("text  line 1\ntext line 2", " \t text  line 1 \n \n \t text line 2 \t \n \t".clearWhitespacesAndNewlines())
    }

}
