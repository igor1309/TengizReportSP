//
//  Reports Verification.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 16.02.2021.
//

import XCTest
@testable import Model

#warning("MOVE TO NEW SWIFT PACKAGE")
extension TokenizedReportVerificationTests {
    func testAllReportsVerification() throws {
        for filename in SampleFiles.filenames {
            let contents = try filename.contentsOfFile()
            let report = try TokenizedReport(stringLiteral: contents).report().get()

            let reportID = "\(report.company) \(report.monthStr):\n"

            XCTAssert(report.isTotalExpensesMatch, "\(reportID)Recorded (\(report.totalExpenses)) and calculated sum of groups' total expenses (\(report.calculatedTotalExpenses)) should be equal, but they differ by \(report.totalExpensesDelta)")

            XCTAssert(report.isTotalOk, "\(reportID)Total balance (\(report.balance)) should be equal to revenue minus total expenses (\(report.revenue - report.totalExpenses)), but the difference is \(report.totalDelta)")

            XCTAssert(report.isBalanceOk, "\(reportID)Running balance (\(report.runningBalance)) should be equal to opening balance plus balance (\(report.openingBalance + report.balance)), but the difference is \(report.balanceDelta)")

            for group in report.groups {
                XCTAssert(group.isAmountMatch, "\(reportID)Group '\(group.title)' amount (\(group.amount)) and sum of items amount (\(group.amountCalculated)) should be equal, but they differ by \(group.amountDelta)")
            }
        }
    }
}

