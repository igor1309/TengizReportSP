//
//  bodyFooter.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 09.02.2021.
//

import XCTest
@testable import TengizReportSP

extension BodySymbolPatternTests {
    func test_bodyFooter() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.bodyFooter, #"(?=ИТОГ:)(?<title>^[^-].*?)(?:\t\s*)(?<value>(?<integer>\d{1,3}(?:\.\d{3})*)(?:\s*р\s*(?<decimal>\d\d?) ?к)?)(?:\t\t)?$"#)

        // MARK: match
        /*
         "ИТОГ:\t11.500\t\t",
         "ИТОГ:\t19.721\t\t",
         "ИТОГ:\t37.146р15к\t\t",
         "ИТОГ:\t24.164\t\t",
         "ИТОГ:\t\t\t",
         */
        XCTAssertEqual("ИТОГ:\t618.500\t\t".firstMatch(for: Patterns.bodyFooter), "ИТОГ:\t618.500\t\t")
        XCTAssertNotNil("ИТОГ:\t11.500\t\t".firstMatch(for: Patterns.bodyFooter), "Mind \t\t at the end")
        XCTAssertNotNil("ИТОГ:\t37.146р15к\t\t".firstMatch(for: Patterns.bodyFooter), "Mind \t\t at the end")

        XCTAssertEqual("ИТОГ:\t11.500".firstMatch(for: Patterns.bodyFooter), "ИТОГ:\t11.500")
        XCTAssertEqual("ИТОГ:\t19.721".firstMatch(for: Patterns.bodyFooter), "ИТОГ:\t19.721")
        XCTAssertEqual("ИТОГ:\t37.146р15к".firstMatch(for: Patterns.bodyFooter), "ИТОГ:\t37.146р15к")
        XCTAssertEqual("ИТОГ:\t24.164".firstMatch(for: Patterns.bodyFooter), "ИТОГ:\t24.164")

        XCTAssertEqual("ИТОГ:\t37.146р 15к".firstMatch(for: Patterns.bodyFooter), "ИТОГ:\t37.146р 15к")
        XCTAssertEqual("ИТОГ:\t37.146р 15 к".firstMatch(for: Patterns.bodyFooter), "ИТОГ:\t37.146р 15 к")
        XCTAssertEqual("ИТОГ:\t37.146р  15к".firstMatch(for: Patterns.bodyFooter), "ИТОГ:\t37.146р  15к")
        XCTAssertEqual("ИТОГ:\t 37.146р15 к".firstMatch(for: Patterns.bodyFooter), "ИТОГ:\t 37.146р15 к")

        // MARK: regex structure
        XCTAssertEqual("ИТОГ:\t65.167".firstMatch(for: Patterns.bodyFooter), "ИТОГ:\t65.167")
        XCTAssertEqual("ИТОГ:\t65.167".replaceFirstMatch(for: Patterns.bodyFooter, withGroup: "title"), "ИТОГ:")
        XCTAssertEqual("ИТОГ:\t65.167".replaceFirstMatch(for: Patterns.bodyFooter, withGroup: "value"), "65.167")
        XCTAssertNil("ИТОГ:\t65.167".replaceFirstMatch(for: Patterns.bodyFooter, withGroup: "VALUE"), "No such group in pattern")

        XCTAssertEqual("ИТОГ:\t37.146р 15к".firstMatch(for: Patterns.bodyFooter), "ИТОГ:\t37.146р 15к")
        XCTAssertEqual("ИТОГ:\t37.146р 15к".replaceFirstMatch(for: Patterns.bodyFooter, withGroup: "title"), "ИТОГ:")
        XCTAssertEqual("ИТОГ:\t37.146р 15к".replaceFirstMatch(for: Patterns.bodyFooter, withGroup: "value"), "37.146р 15к")

        XCTAssertEqual("ИТОГ:\t618.500\t\t".replaceFirstMatch(for: Patterns.bodyFooter, withGroup: "value"), "618.500")
        XCTAssertEqual("ИТОГ:\t11.500\t\t".replaceFirstMatch(for: Patterns.bodyFooter, withGroup: "value"), "11.500")
        XCTAssertEqual("ИТОГ:\t37.146р15к\t\t".replaceFirstMatch(for: Patterns.bodyFooter, withGroup: "value"), "37.146р15к")
        XCTAssertEqual("ИТОГ:\t 37.146р15к\t\t".replaceFirstMatch(for: Patterns.bodyFooter, withGroup: "value"), "37.146р15к")
        XCTAssertEqual("ИТОГ:\t 37.146р 15к\t\t".replaceFirstMatch(for: Patterns.bodyFooter, withGroup: "value"), "37.146р 15к")
        XCTAssertEqual("ИТОГ:\t 37.146р 15 к\t\t".replaceFirstMatch(for: Patterns.bodyFooter, withGroup: "value"), "37.146р 15 к")

        // MARK: no match
        #warning("finish this: add more")
        XCTAssertNil("ИТОГ:\t\t\t".firstMatch(for: Patterns.bodyFooter), "Mind \t\t at the end")
        XCTAssertNil("ИТОГ:\t".firstMatch(for: Patterns.bodyFooter), "No number")
        XCTAssertNil("ИТОГ:\t 37.146р15к \t\t".replaceFirstMatch(for: Patterns.bodyFooter, withGroup: "value"), "37.146р15к")
    }
}

extension BodySymbolTests {
    func test_bodyFooter() {
        // MARK: match
        /*
         "ИТОГ:\t11.500\t\t",
         "ИТОГ:\t19.721\t\t",
         "ИТОГ:\t37.146р15к\t\t",
         "ИТОГ:\t24.164\t\t",
         "ИТОГ:\t\t\t",
         */
        XCTAssertEqual("ИТОГ:\t618.500\t\t".bodyFooter(), .footer(title: "ИТОГ:", value: 618_500))

        XCTAssertEqual("ИТОГ:\t37.146р 15к".bodyFooter(), .footer(title: "ИТОГ:", value: 37_146.15))
        XCTAssertEqual("ИТОГ:\t37.146р 15 к".bodyFooter(), .footer(title: "ИТОГ:", value: 37_146.15))

        XCTAssertEqual("ИТОГ:\t65.167".bodyFooter(), .footer(title: "ИТОГ:", value: 65_167))
        XCTAssertEqual("ИТОГ:\t518.500".bodyFooter(), .footer(title: "ИТОГ:", value: 518_500))

        XCTAssertEqual("ИТОГ:\t37.146р 15к".bodyFooter(), .footer(title: "ИТОГ:", value: 37_146.15))
        XCTAssertEqual("ИТОГ:\t37.146р 15 к".bodyFooter(), .footer(title: "ИТОГ:", value: 37_146.15))
        XCTAssertEqual("ИТОГ:\t37.146р  15к".bodyFooter(), .footer(title: "ИТОГ:", value: 37_146.15))
        XCTAssertEqual("ИТОГ:\t 37.146р15 к".bodyFooter(), .footer(title: "ИТОГ:", value: 37_146.15))

        XCTAssertEqual("ИТОГ:\t618.500\t\t".bodyFooter(), .footer(title: "ИТОГ:", value: 618_500))
        XCTAssertEqual("ИТОГ:\t11.500\t\t".bodyFooter(), .footer(title: "ИТОГ:", value: 11_500))
        XCTAssertEqual("ИТОГ:\t37.146р15к\t\t".bodyFooter(), .footer(title: "ИТОГ:", value: 37_146.15))
        XCTAssertEqual("ИТОГ:\t 37.146р15к\t\t".bodyFooter(), .footer(title: "ИТОГ:", value: 37_146.15))
        XCTAssertEqual("ИТОГ:\t 37.146р 15к\t\t".bodyFooter(), .footer(title: "ИТОГ:", value: 37_146.15))
        XCTAssertEqual("ИТОГ:\t 37.146р 15 к\t\t".bodyFooter(), .footer(title: "ИТОГ:", value: 37_146.15))


        // MARK: no match
        XCTAssertNil("ИТОГ:    518.500".bodyFooter(), "Mind TAB and \t")
        XCTAssertNil("Основные расходы:\t20%\t8.95%".bodyFooter(), "Not a group footer line")

    }

    func test_BodySymbol_init_footer() {
        // MARK: match
        /*
         "ИТОГ:\t11.500\t\t",
         "ИТОГ:\t19.721\t\t",
         "ИТОГ:\t37.146р15к\t\t",
         "ИТОГ:\t24.164\t\t",
         "ИТОГ:\t\t\t",
         */

        var input = "ИТОГ:\t65.167"
        XCTAssertEqual(BodySymbol(stringLiteral: input), .footer(title: "ИТОГ:", value: 65_167))
        input = "ИТОГ:\t65.167\t\t"
        XCTAssertEqual(BodySymbol(input), .footer(title: "ИТОГ:", value: 65_167))
        input = "ИТОГ:\t11.500\t\t"
        XCTAssertEqual(BodySymbol(input), .footer(title: "ИТОГ:", value: 11_500))
        input = "ИТОГ:\t19.721\t\t"
        XCTAssertEqual(BodySymbol(input), .footer(title: "ИТОГ:", value: 19_721))
        input = "ИТОГ:\t37.146р15к\t\t"
        XCTAssertEqual(BodySymbol(input), .footer(title: "ИТОГ:", value: 37_146.15))
        input = "ИТОГ:\t24.164\t\t"
        XCTAssertEqual(BodySymbol(input), .footer(title: "ИТОГ:", value: 24_164))

        // MARK: no match
        #warning("finish this: add more")
        input = "ИТОГ:"
        XCTAssertEqual(BodySymbol(input), .empty, "No number")
        input = "ИТОГ:\t\t\t"
        XCTAssertEqual(BodySymbol(input), .empty)
    }

}
