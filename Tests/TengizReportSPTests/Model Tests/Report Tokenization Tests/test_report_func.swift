//
//  TokenizedReportReportTests.swift
//  
//
//  Created by Igor Malyarov on 16.02.2021.
//

import XCTest
@testable import TextReports
@testable import TengizReportModel

extension TokenizedReport.Report {
    static let allReports = [
        saperavi_2020_06,
        saperavi_2020_07,
        saperavi_2020_08,
        saperavi_2020_09,
        saperavi_2020_10,
        saperavi_2020_11,
        saperavi_2020_12,
        saperavi_2021_01,
        saperavi_2021_02,

        vaiMe_2020_11,
        vaiMe_2020_12,
        vaiMe_2021_01
    ]
}

extension TokenizedReportReportTests {
    func test_report_func() throws {
        let filenames = ContentLoader.allFilenames
        let samples = TokenizedReport.Report.allReports

        XCTAssertEqual(filenames.count, samples.count, "Might have been added new report(s).")

        try zip(filenames, samples).forEach { filename, sample in

            let contents = try ContentLoader.contentsOfSampleFile(named: filename).get()
            let report = try TokenizedReport(stringLiteral: contents).report().get()

            XCTAssertEqual(report.month, sample.month)
            XCTAssertEqual(report.year, sample.year)

            XCTAssertEqual(report.monthStr, sample.monthStr, "\(report.company) (\(report.monthStr)) is not equal to \(sample.company) (\(sample.monthStr))")

            XCTAssertEqual(report.company, sample.company, "\(report.company) (\(report.monthStr)) is not equal to \(sample.company) (\(sample.monthStr))")

            XCTAssertEqual(report.revenue, sample.revenue, "Revenue for \(report.company) \(report.monthStr) is not equal to \(sample.company) \(sample.monthStr)")

            XCTAssertEqual(report.dailyAverage, sample.dailyAverage, "Daily average for \(report.company) \(report.monthStr) is not equal to \(sample.company) \(sample.monthStr)")

            XCTAssertEqual(report.openingBalance, sample.openingBalance, "Opening balance for \(report.company) \(report.monthStr) is not equal to \(sample.company) \(sample.monthStr)")

            XCTAssertEqual(report.balance, sample.balance, "Balance for \(report.company) \(report.monthStr) is not equal to \(sample.company) \(sample.monthStr)")

            XCTAssertEqual(report.runningBalance, sample.runningBalance, "Running balance for \(report.company) \(report.monthStr) is not equal to \(sample.company) \(sample.monthStr)")

            XCTAssertEqual(report.totalExpenses, sample.totalExpenses, "Total expenses for \(report.company) \(report.monthStr) is not equal to \(sample.company) \(sample.monthStr)")

            XCTAssertEqual(report.groups, sample.groups, "Groups for \(report.company) \(report.monthStr) are not equal to \(sample.company) \(sample.monthStr)")
            XCTAssertEqual(report.groups.count, sample.groups.count)

            zip(report.groups, sample.groups).forEach { group, sampleGroup in
                XCTAssertEqual(group, sampleGroup)

                let groupID = "\(report.company) \(report.monthStr) \(group.title) is not equal to \(sample.company) \(sample.monthStr) \(sampleGroup.title)"

                XCTAssertEqual(group.groupNumber, sampleGroup.groupNumber)
                XCTAssertEqual(group.title, sampleGroup.title)
                XCTAssertEqual(group.amount, sampleGroup.amount, groupID)
                XCTAssertEqual(group.target, sampleGroup.target, groupID)

                XCTAssertEqual(group.items, sampleGroup.items)
                XCTAssertEqual(group.items.count, sampleGroup.items.count)

                zip(group.items, sampleGroup.items).forEach {
                    XCTAssertEqual($0, $1)
                    XCTAssertEqual($0.itemNumber, $1.itemNumber)
                    XCTAssertEqual($0.title, $1.title)
                    XCTAssertEqual($0.amount, $1.amount)
                    XCTAssertEqual($0.note, $1.note)
                }
            }
        }
    }

}
