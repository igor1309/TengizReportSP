//
//  saperavi_2020_06_report.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 16.02.2021.
//

import Model

extension TokenizedReport.Report {
    static let saperavi_2020_06: TokenizedReport.Report =
        TokenizedReport.Report(monthStr: "июнь2020 (с 24 по 30 июня)",
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
                                Group(groupNumber: 0, title: "Основные расходы", amount: 11_500, target: 0.25,
                                      items: [Item(itemNumber: 5, title: "Аренда головного офиса", amount: 11500.0, note: nil)]
                                ),
                                Group(groupNumber: 0, title: "Зарплата", amount: 19_721, target: 0.22,
                                      items: [Item(itemNumber: 1, title: "ФОТ", amount: 19_721, note: Optional("( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"))]
                                ),
                                Group(groupNumber: 0, title: "Фактический приход товара и оплата товара", amount: 37146.15, target: 0.25,
                                      items: [Item(itemNumber: 1, title: "Приход товара по накладным", amount: 21346.15, note: "451.198р41к (из них у нас оплачено фактический 21.346р15к)"),
                                              Item(itemNumber: 2, title: "Предоплаченный товар, но не отраженный в приходе", amount: 15_800, note: nil)]
                                ),
                                Group(groupNumber: 0, title: "Прочие расходы", amount: 24_164, target: 0.08,
                                      items: [Item(itemNumber: 2, title: "Банковское обслуживание", amount: 4_544, note: nil),
                                              Item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", amount: 2_120, note: nil),
                                              Item(itemNumber: 9, title: "Реклама и IT поддержка", amount: 16_300, note: nil),
                                              Item(itemNumber: 16, title: "Текущие мелкие расходы", amount: 1_200, note: nil)]
                                )
                               ]
        )
}

