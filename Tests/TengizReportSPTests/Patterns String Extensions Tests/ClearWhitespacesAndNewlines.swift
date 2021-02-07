//
//  ClearWhitespacesAndNewlines.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 28.01.2021.
//

import XCTest
@testable import TengizReportSP

final class ClearWhitespacesAndNewlines: XCTestCase {
    func testClearWhitespacesAndNewlines() {
        XCTAssertEqual("".clearWhitespacesAndNewlines(),
                       "",
                       "Strings should be equal")
        XCTAssertEqual("some text".clearWhitespacesAndNewlines(),
                       "some text",
                       "Strings should be equal")
        XCTAssertEqual(" ".clearWhitespacesAndNewlines(),
                       "",
                       "Strings should be equal")
        XCTAssertNotEqual(" ".clearWhitespacesAndNewlines(),
                          " ",
                          "Strings should be equal")
        XCTAssertEqual(" \n ".clearWhitespacesAndNewlines(),
                       "",
                       "Strings should be equal")
        XCTAssertEqual(" \t ".clearWhitespacesAndNewlines(),
                       "",
                       "Strings should be equal")
        XCTAssertEqual(" \t some text \t \n \t".clearWhitespacesAndNewlines(),
                       "some text",
                       "Strings should be equal")
        XCTAssertEqual(" \t text  line 1 \n \n \t text line 2 \t \n \t".clearWhitespacesAndNewlines(),
                       "text  line 1\ntext line 2",
                       "Strings should be equal")
    }

}
