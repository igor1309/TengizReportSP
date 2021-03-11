//
//  saperavi_2020_06_report.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 16.02.2021.
//

@testable import TengizReportModel

extension TokenizedReport.Report {
    static let saperavi_2020_06: TokenizedReport.Report =
        TokenizedReport.Report(
            monthStr: "июнь2020 (с 24 по 30 июня)",
            month: 06,
            year: 2020,
            company: "Саперави Аминьевка",
            revenue: 266_285,
            dailyAverage: 38_040,
            openingBalance: 0,
            balance: 173_753,
            runningBalance: 173_753,
            totalExpenses: 92_531.15,

            groups: [
                Group(groupNumber: 1, title: "Основные расходы", amount: 11_500, target: 0.25,
                      items: [Item(itemNumber: 5, title: "Аренда головного офиса", amount: 11500.0)]
                ),
                Group(groupNumber: 2, title: "Зарплата", amount: 19_721, target: 0.22,
                      items: [Item(itemNumber: 1, title: "ФОТ", amount: 19_721, note: "( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)")]
                ),
                Group(groupNumber: 3, title: "Фактический приход товара и оплата товара", amount: 37146.15, target: 0.25,
                      items: [Item(itemNumber: 1, title: "Приход товара по накладным", amount: 21346.15, note: "451.198р41к (из них у нас оплачено фактический 21.346р15к)"),
                              Item(itemNumber: 2, title: "Предоплаченный товар, но не отраженный в приходе", amount: 15_800)]
                ),
                Group(groupNumber: 4, title: "Прочие расходы", amount: 24_164, target: 0.08,
                      items: [Item(itemNumber: 2, title: "Банковское обслуживание", amount: 4_544),
                              Item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", amount: 2_120),
                              Item(itemNumber: 9, title: "Реклама и IT поддержка", amount: 16_300),
                              Item(itemNumber: 16, title: "Текущие мелкие расходы", amount: 1_200)]
                )
            ]
        )
}

