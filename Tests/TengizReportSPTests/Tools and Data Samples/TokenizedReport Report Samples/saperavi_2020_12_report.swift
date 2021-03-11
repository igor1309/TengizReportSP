//
//  saperavi_2020_12_report.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 16.02.2021.
//

@testable import TengizReportModel

extension TokenizedReport.Report {
    static let saperavi_2020_12: TokenizedReport.Report =
        TokenizedReport.Report(monthStr: "Декабрь2020",
                               month: 12,
                               year: 2020,
                               company: "Саперави Аминьевка",
                               revenue: 2_318_274,
                               dailyAverage: 74_783,
                               openingBalance: -1_065_596.76,
                               balance: -113_901.89,
                               runningBalance: -1_179_498.65,
                               totalExpenses: 2_432_175.89,

                               groups: [
                                Group(groupNumber: 0, title: "Основные расходы", amount: 518_500, target: 0.2,
                                      items: [Item(itemNumber: 1, title: "Аренда торгового помещения", amount: 500_000, note: "(за ноябрь)"),
                                              Item(itemNumber: 5, title: "Аренда головного офиса", amount: 11_500),
                                              Item(itemNumber: 6, title: "Аренда головного склада", amount: 7_000)]
                                ),

                                Group(groupNumber: 0, title: "Зарплата", amount: 694_360, target: 0.2,
                                      items: [Item(itemNumber: 1, title: "ФОТ", amount: 595_360, note: "( за первую часть ноября)"),
                                              Item(itemNumber: 2, title: "ФОТ Бренд, логистика, бухгалтерия", amount: 99_000)]
                                ),

                                Group(groupNumber: 0, title: "Фактический приход товара и оплата товара", amount: 617_873.65, target: 0.25,
                                      items: [Item(itemNumber: 1, title: "Приход товара по накладным", amount: 617_873.65, note: "997.446р; (оплаты фактические: 491.114р 65к -переводы; 114.589р -корпоративная карта; 12.170р -наличные из кассы; Итого 617.873р 65к)")
                                      ]
                                ),

                                Group(groupNumber: 0, title: "Прочие расходы", amount: 582311.24, target: 0.15,
                                      items: [Item(itemNumber: 1, title: "Налоговые платежи", amount: 22_895.38),
                                              Item(itemNumber: 2, title: "Банковское обслуживание", amount: 7_473.86),
                                              Item(itemNumber: 3, title: "Юридическое сопровождение", amount: 40_000),
                                              Item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", amount: 26_915),
                                              Item(itemNumber: 6, title: "Обслуживание кассовой программы Айко", amount: 29_195, note: "4.500+8.700+15.995"),
                                              Item(itemNumber: 8, title: "Печать рекламных буклетов и их раздача", amount: 7_300),
                                              Item(itemNumber: 9, title: "Реклама и IT поддержка", amount: 82_000),
                                              Item(itemNumber: 12, title: "Интернет", amount: 4_500),
                                              Item(itemNumber: 14, title: "Облачная касса для доставки через сайт", amount: 36_000),
                                              Item(itemNumber: 15, title: "Аренда зарядных устройств и раций", amount: 5_000),
                                              Item(itemNumber: 16, title: "Текущие мелкие расходы", amount: 2_600),
                                              Item(itemNumber: 18, title: "Аренда оборудования д/питьевой воды", amount: 5_130),
                                              Item(itemNumber: 20, title: "Чистка вентиляции", amount: 35_000),
                                              Item(itemNumber: 21, title: "Обслуживание банкетов", amount: 6_750),
                                              Item(itemNumber: 22, title: "Хэдхантер (подбор пероснала)", amount: 9_720),
                                              Item(itemNumber: 23, title: "Аудит кантора (Бухуслуги)", amount: 60_000),
                                              Item(itemNumber: 24, title: "Корректировка ЕГАИС", amount: 10_000),
                                              Item(itemNumber: 25, title: "Игорь стол", amount: 22_130),
                                              Item(itemNumber: 26, title: "Новогодний декор", amount: 169_702)]
                                ),
                                
                                Group(groupNumber: 0, title: "Расходы на доставку", amount: 19_131, target: nil,
                                      items: [Item(itemNumber: 1, title: "Курьеры", amount: 4_700),
                                              Item(itemNumber: 2, title: "Агрегаторы", amount: 14_431)]
                                )
                               ]
        )
}
