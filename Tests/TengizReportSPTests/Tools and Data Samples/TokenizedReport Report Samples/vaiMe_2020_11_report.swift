//
//  vaiMe_2020_11_report.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 16.02.2021.
//

@testable import TengizReportModel

extension TokenizedReport.Report {
    static let vaiMe_2020_11: TokenizedReport.Report =
        TokenizedReport.Report(monthStr: "Октябрь+Ноябрь2020",
                               month: 11,
                               year: 2020,
                               company: "Вай Мэ! Щелково",
                               revenue: 1_380_590,
                               dailyAverage: 41_836,
                               openingBalance: 0,
                               balance: 684_753.85,
                               runningBalance: 684_753.85,
                               totalExpenses: 695_836.15,

                               groups: [
                                Group(groupNumber: 0, title: "Основные расходы", amount: 27_300, target: nil,
                                      items: [Item(itemNumber: 5, title: "Аренда головного офиса", amount: 11_500),
                                              Item(itemNumber: 7, title: "Вывоз мусора", amount: 15_800)]
                                ),

                                Group(groupNumber: 0, title: "Зарплата", amount: 157_894, target: 0.2,
                                      items: [Item(itemNumber: 1, title: "ФОТ общий", amount: 67_894),
                                              Item(itemNumber: 2, title: "ФОТ Бренд, логистика, бухгалтерия", amount: 90_000)]
                                ),

                                Group(groupNumber: 0, title: "Фактический приход товара и оплата товара", amount: 315231.15, target: 0.3,
                                      items: [Item(itemNumber: 1, title: "Приход товара по накладным", amount: 315231.15, note: "179.108р89к+512.293р(оплаты фактические:199.803р80к-переводы;81.225р35к-корпоративная карта;34.202р-наличные из кассы; Итого 315.231р15к)")]
                                ),

                                Group(groupNumber: 0, title: "Прочие расходы", amount: 214_542, target: 0.08,
                                      items: [Item(itemNumber: 2, title: "Банковское обслуживание", amount: 2_514),
                                              Item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", amount: 15_963),
                                              Item(itemNumber: 5, title: "Юридическое сопровождение", amount: 40_000),
                                              Item(itemNumber: 6, title: "Обслуживание кассовой программы", amount: 11_500),
                                              Item(itemNumber: 7, title: "Обслуживание хостинга", amount: 2_500),
                                              Item(itemNumber: 8, title: "Аудит Кантора (бухуслуги)", amount: 60_000),
                                              Item(itemNumber: 9, title: "Реклама и IT поддержка", amount: 75_000),
                                              Item(itemNumber: 12, title: "Интернет", amount: 6_065),
                                              Item(itemNumber: 16, title: "Текущие мелкие расходы", amount: 1_000)]
                                ),
                                
                                Group(groupNumber: 0, title: "Расходы на доставку", amount: 8_169, target: nil,
                                      items: [Item(itemNumber: 2, title: "Агрегаторы", amount: 8_169)]
                                )
                               ]
        )
}
