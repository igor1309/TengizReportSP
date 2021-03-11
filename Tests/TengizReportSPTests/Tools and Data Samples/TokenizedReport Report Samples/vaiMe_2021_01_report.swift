//
//  vaiMe_2021_01_report.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 16.02.2021.
//

@testable import TengizReportModel

extension TokenizedReport.Report {
    static let vaiMe_2021_01: TokenizedReport.Report =
        TokenizedReport.Report(
            monthStr: "Январь2021",
            month: 1,
            year: 2021,
            company: "Вай Мэ! Щелково",
            revenue: 1_065_575,
            dailyAverage: 34_373,
            openingBalance: 693_424.31,
            balance: -337_285.06,
            runningBalance: 356_139.25,
            totalExpenses: 1_402_860.06,

            groups: [
                Group(groupNumber: 1, title: "Основные расходы", amount: 26_000, target: 0.25,
                      items: [Item(itemNumber: 5, title: "Аренда головного офиса", amount: 11_500),
                              Item(itemNumber: 7, title: "Вывоз мусора", amount: 14_500)]
                ),

                Group(groupNumber: 2, title: "Зарплата", amount: 593_608, target: 0.2,
                      items: [Item(itemNumber: 1, title: "ФОТ общий", amount: 503_608),
                              Item(itemNumber: 2, title: "ФОТ Бренд, логистика, бухгалтерия", amount: 90_000)]
                ),

                Group(groupNumber: 3, title: "Фактический приход товара и оплата товара", amount: 474_179.76, target: 0.3,
                      // в отчете опечатка, см коррекции в cleanContent()
                      items: [Item(itemNumber: 1, title: "Приход товара по накладным", amount: 474_179.76, note: "375.116р18к(оплаты фактические:389.218р21к-переводы;57.084р55к-корпоративная карта;27.877р-наличные из кассы; Итого 474.179р76к)")]
                ),

                Group(groupNumber: 4, title: "Прочие расходы", amount: 238_781.3, target: 0.08,
                      items: [Item(itemNumber: 1, title: "Налоговые платежи", amount: 23_130.52),
                              Item(itemNumber: 2, title: "Банковское обслуживание", amount: 2_305.78),
                              Item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", amount: 11_540),
                              Item(itemNumber: 5, title: "Юридическое сопровождение", amount: 40_000),
                              Item(itemNumber: 6, title: "Обслуживание кассовой программы", amount: 24_380, note: "6.250+18.130"),
                              Item(itemNumber: 7, title: "Обслуживание хостинга", amount: 2_500),
                              Item(itemNumber: 8, title: "Аудит Кантора (бухуслуги)", amount: 60_000),
                              Item(itemNumber: 9, title: "Реклама и IT поддержка", amount: 65_000),
                              Item(itemNumber: 12, title: "Интернет", amount: 3_500),
                              Item(itemNumber: 13, title: "Дезобработка помещения", amount: 4_500),
                              Item(itemNumber: 16, title: "Текущие мелкие расходы", amount: 1_925)]
                ),

                Group(groupNumber: 5, title: "Расходы на доставку", amount: 70_291, target: nil,
                      items: [Item(itemNumber: 2, title: "Агрегаторы", amount: 70_291)]
                )
            ]
        )
}
