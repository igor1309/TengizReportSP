//
//  saperavi_2020_10_report.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 16.02.2021.
//

@testable import TengizReportModel

extension TokenizedReport.Report {
    static let saperavi_2020_10: TokenizedReport.Report =
        TokenizedReport.Report(monthStr: "Октябрь2020",
                               month: 10,
                               year: 2020,
                               company: "Саперави Аминьевка",
                               revenue: 2_587_735,
                               dailyAverage: 83_475,
                               openingBalance: -642_997.43,
                               balance: -277_306.74,
                               runningBalance: -920_304.17,
                               totalExpenses: 2_865_042.74,

                               groups: [
                                Group(groupNumber: 0, title: "Основные расходы", amount: 618_500, target: 0.2,
                                      items: [Item(itemNumber: 1, title: "Аренда торгового помещения", amount: 600_000, note: "200.000 (за август) +400.000 (за сентябрь)"),
                                              Item(itemNumber: 5, title: "Аренда головного офиса", amount: 11_500, note: nil),
                                              Item(itemNumber: 6, title: "Аренда головного склада", amount: 7_000, note: nil)]
                                ),

                                Group(groupNumber: 0, title: "Зарплата", amount: 1246_085, target: 0.2,
                                      items: [Item(itemNumber: 1, title: "ФОТ", amount: 1147_085, note: "( за вторую часть сентября и первую  часть октября)"),
                                              Item(itemNumber: 2, title: "ФОТ Бренд, логистика, бухгалтерия", amount: 99_000, note: nil)]
                                ),

                                Group(groupNumber: 0, title: "Фактический приход товара и оплата товара", amount: 628215.74, target: 0.25,
                                      items: [Item(itemNumber: 1, title: "Приход товара по накладным", amount: 628215.74, note: "907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)")]
                                ),

                                Group(groupNumber: 0, title: "Прочие расходы", amount: 350_700, target: 0.15,
                                      items: [Item(itemNumber: 1, title: "Налоговые платежи", amount: 35_311, note: nil),
                                              Item(itemNumber: 2, title: "Банковское обслуживание", amount: 6_279, note: nil),
                                              Item(itemNumber: 3, title: "Юридическое сопровождение", amount: 40_000, note: nil),
                                              Item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", amount: 31_587, note: nil),
                                              Item(itemNumber: 6, title: "Обслуживание кассовой программы Айко", amount: 8_435, note: nil),
                                              Item(itemNumber: 8, title: "Обслуживание мобильного приложения", amount: 9_200, note: nil),
                                              Item(itemNumber: 9, title: "Реклама и IT поддержка", amount: 85_000, note: nil),
                                              Item(itemNumber: 14, title: "Вышивка логотипа на одежде", amount: 2_836, note: nil),
                                              Item(itemNumber: 15, title: "Аренда зарядных устройств и раций", amount: 10_000, note: nil),
                                              Item(itemNumber: 16, title: "Текущие мелкие расходы", amount: 5_460, note: nil),
                                              Item(itemNumber: 18, title: "Аренда оборудования д/питьевой воды", amount: 5_130, note: nil),
                                              Item(itemNumber: 19, title: "Ремонт оборудования", amount: 6_610, note: nil),
                                              Item(itemNumber: 20, title: "Чистка вентиляции", amount: 35_000, note: nil),
                                              Item(itemNumber: 21, title: "Обслуживание банкетов", amount: 5_625, note: nil),
                                              Item(itemNumber: 22, title: "Хэдхантер (подбор пероснала)", amount: 4_227, note: nil),
                                              Item(itemNumber: 23, title: "Аудит кантора (Бухуслуги)", amount: 60_000, note: nil)]
                                ),

                                Group(groupNumber: 0, title: "Расходы на доставку", amount: 21_541, target: nil,
                                      items: [Item(itemNumber: 2, title: "Агрегаторы", amount: 21_541, note: nil)]
                                )
                               ]
        )
}
