//
//  saperavi_2021_01_report.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 16.02.2021.
//

@testable import TengizReportModel

extension TokenizedReport.Report {
    #warning("report text with 'Январь2020' but this is Jan 2021!")
    static let saperavi_2021_01: TokenizedReport.Report =
        TokenizedReport.Report(
            monthStr: "Январь2020",
            month: 01,
            year: 2021,
            company: "Саперави Аминьевка",
            revenue: 2_307_231,
            dailyAverage: 74_426,
            openingBalance: -1_179_498.65,
            balance: -243_103.18,
            runningBalance: -1_422_601.83,
            totalExpenses: 2_550_334.18,

            groups: [
                Group(groupNumber: 0, title: "Основные расходы", amount: 168_500, target: 0.2,
                      items: [Item(itemNumber: 3, title: "Электричество", amount: 150_000, note: nil),
                              Item(itemNumber: 5, title: "Аренда головного офиса", amount: 11_500, note: nil),
                              Item(itemNumber: 6, title: "Аренда головного склада", amount: 7_000, note: nil)]
                ),

                Group(groupNumber: 0, title: "Зарплата", amount: 1_163_769, target: 0.2,
                      items: [Item(itemNumber: 1, title: "ФОТ", amount: 1_064_769, note: "( за вторую  часть ноября и первую часть декабря)"),
                              Item(itemNumber: 2, title: "ФОТ Бренд, логистика, бухгалтерия", amount: 99_000, note: nil)]
                ),

                Group(groupNumber: 0, title: "Фактический приход товара и оплата товара", amount: 869029.78, target: 0.25,
                      items: [Item(itemNumber: 1, title: "Приход товара по накладным", amount: 869_029.78, note: "832.168р88к; (оплаты фактические: 556.331р 58к -переводы; 159.321р20к -корпоративная карта; 153.377р -наличные из кассы; Итого 869.029р 78к)")]
                ),

                Group(groupNumber: 0, title: "Прочие расходы", amount: 319_456.4, target: 0.15,
                      items: [Item(itemNumber: 1, title: "Налоговые платежи", amount: 28_480.79, note: nil),
                              Item(itemNumber: 2, title: "Банковское обслуживание", amount: 6_994.61, note: nil),
                              Item(itemNumber: 3, title: "Юридическое сопровождение", amount: 40_000, note: nil),
                              Item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", amount: 25_785, note: nil),
                              Item(itemNumber: 6, title: "Обслуживание кассовой программы Айко", amount: 15_250, note: "6.250+9.000"),
                              Item(itemNumber: 8, title: "Печать рекламных буклетов и их раздача", amount: 7_300, note: nil),
                              Item(itemNumber: 9, title: "Реклама и IT поддержка", amount: 70_500, note: nil),
                              Item(itemNumber: 12, title: "Интернет", amount: 4_500, note: nil),
                              Item(itemNumber: 15, title: "Аренда зарядных устройств и раций", amount: 5_000, note: nil),
                              Item(itemNumber: 16, title: "Текущие мелкие расходы", amount: 4_746, note: nil),
                              Item(itemNumber: 20, title: "Чистка вентиляции", amount: 35_000, note: nil),
                              Item(itemNumber: 23, title: "Аудит кантора (Бухуслуги)", amount: 60_000, note: nil),
                              Item(itemNumber: 26, title: "Новогодний декор-демонтаж", amount: 15_900, note: nil)]
                ),

                Group(groupNumber: 0, title: "Расходы на доставку", amount: 29_579, target: nil,
                      items: [Item(itemNumber: 1, title: "Курьеры", amount: 6_400, note: nil),
                              Item(itemNumber: 2, title: "Агрегаторы", amount: 23_179, note: nil)]
                )
            ]
        )
}
