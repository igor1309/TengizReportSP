//
//  saperavi_2020_11_report.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 16.02.2021.
//

import Model

extension TokenizedReport.Report {
    static let saperavi_2020_11: TokenizedReport.Report =
        TokenizedReport.Report(monthStr: "Ноябрь2020",
                               month: 11,
                               year: 2020,
                               company: "Саперави Аминьевка",
                               revenue: 1_885_280,
                               dailyAverage: 62_842,
                               openingBalance: -920_304.17,
                               balance: -145_292.59,
                               runningBalance: -1_065_596.76,
                               totalExpenses: 2_030_572.59,

                               groups: [
                                Group(groupNumber: 0, title: "Основные расходы", amount: 518500.0, target: Optional(0.2),
                                      items: [Item(itemNumber: 1, title: "Аренда торгового помещения", amount: 500000.0, note: Optional("(за октябрь)")),
                                              Item(itemNumber: 5, title: "Аренда головного офиса", amount: 11500.0, note: nil),
                                              Item(itemNumber: 6, title: "Аренда головного склада", amount: 7000.0, note: nil)]
                                ),

                                Group(groupNumber: 0, title: "Зарплата", amount: 663678.0, target: Optional(0.2),
                                      items: [Item(itemNumber: 1, title: "ФОТ", amount: 564678.0, note: Optional("( за вторую часть октября)")),
                                              Item(itemNumber: 2, title: "ФОТ Бренд, логистика, бухгалтерия", amount: 99000.0, note: nil)]
                                ),

                                Group(groupNumber: 0, title: "Фактический приход товара и оплата товара", amount: 437474.47, target: Optional(0.25),
                                      items: [Item(itemNumber: 1, title: "Приход товара по накладным", amount: 437474.47, note: Optional("739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого 437.474р 47к)"))]
                                ),

                                Group(groupNumber: 0, title: "Прочие расходы", amount: 393081.12, target: 0.15,
                                      items: [Item(itemNumber: 1, title: "Налоговые платежи",amount: 31_949.38, note: nil),
                                              Item(itemNumber: 2, title: "Банковское обслуживание",amount: 5_863.74, note: nil),
                                              Item(itemNumber: 3, title: "Юридическое сопровождение", amount: 40000.0, note: nil),
                                              Item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", amount: 22653.0, note: nil),
                                              Item(itemNumber: 6, title: "Обслуживание кассовой программы Айко", amount: 12000.0, note: nil),
                                              Item(itemNumber: 8, title: "Обслуживание мобильного приложения", amount: 9200.0, note: nil),
                                              Item(itemNumber: 9, title: "Реклама и IT поддержка", amount: 90000.0, note: nil),
                                              Item(itemNumber: 12, title: "Интернет", amount: 4500.0, note: nil),
                                              Item(itemNumber: 14, title: "Поверка весов", amount: 3400.0, note: nil),
                                              Item(itemNumber: 15, title: "Аренда зарядных устройств и раций", amount: 5000.0, note: nil),
                                              Item(itemNumber: 16, title: "Текущие мелкие расходы", amount: 6690.0, note: nil),
                                              Item(itemNumber: 18, title: "Аренда оборудования д/питьевой воды", amount: 5130.0, note: nil),
                                              Item(itemNumber: 20, title: "Чистка вентиляции", amount: 35000.0, note: nil),
                                              Item(itemNumber: 22, title: "Хэдхантер (подбор пероснала)", amount: 9720.0, note: nil),
                                              Item(itemNumber: 23, title: "Аудит кантора (Бухуслуги)", amount: 60000.0, note: nil),
                                              Item(itemNumber: 24, title: "Яндекс карты", amount: 51975.0, note: nil)]
                                ),

                                Group(groupNumber: 0, title: "Расходы на доставку", amount: 17_839, target: nil,
                                      items: [Item(itemNumber: 2, title: "Агрегаторы", amount: 17_839, note: nil)]
                                )
                               ]
        )
}
