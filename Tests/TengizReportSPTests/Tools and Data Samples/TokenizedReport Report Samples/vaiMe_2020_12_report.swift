//
//  vaiMe_2020_12_report.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 16.02.2021.
//

@testable import TengizReportModel

extension TokenizedReport.Report {
    static let vaiMe_2020_12: TokenizedReport.Report =
        TokenizedReport.Report(monthStr: "Декабрь2020",
                               month: 12,
                               year: 2020,
                               company: "Вай Мэ! Щелково",
                               revenue: 929_625,
                               dailyAverage: 29_987,
                               openingBalance: 684_753.85,
                               balance: 8_670.46,
                               runningBalance: 693_424.31,
                               totalExpenses: 920_954.54,

                               groups: [
                                Group(groupNumber: 0, title: "Основные расходы", amount: 29_500, target: 0.25,
                                      items: [Item(itemNumber: 5, title: "Аренда головного офиса", amount: 11_500, note: nil),
                                              Item(itemNumber: 7, title: "Вывоз мусора", amount: 18_000, note: nil)]
                                ),

                                Group(groupNumber: 0, title: "Зарплата", amount: 351_978, target: 0.2,
                                      items: [Item(itemNumber: 1, title: "ФОТ общий", amount: 261_978, note: nil),
                                              Item(itemNumber: 2, title: "ФОТ Бренд, логистика, бухгалтерия", amount: 90_000, note: nil)]
                                ),

                                Group(groupNumber: 0, title: "Фактический приход товара и оплата товара", amount: 285_476.39, target: 0.3,
                                      items: [Item(itemNumber: 1, title: "Приход товара по накладным", amount: 285476.39, note: "473.128р43к(оплаты фактические:231.572р46к-переводы;51.104р93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р39к)")]
                                ),

                                Group(groupNumber: 0, title: "Прочие расходы", amount: 244_472.15, target: 0.08,
                                      items: [Item(itemNumber: 1, title: "Налоговые платежи", amount: 22_282.86, note: nil),
                                              Item(itemNumber: 2, title: "Банковское обслуживание", amount: 2_344.29, note: nil),
                                              Item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", amount: 12_111, note: nil),
                                              Item(itemNumber: 5, title: "Юридическое сопровождение", amount: 40_000, note: nil),
                                              Item(itemNumber: 6, title: "Обслуживание кассовой программы", amount: 15_995, note: nil),
                                              Item(itemNumber: 7, title: "Обслуживание хостинга", amount: 2_500, note: nil),
                                              Item(itemNumber: 8, title: "Аудит Кантора (бухуслуги)", amount: 60_000, note: nil),
                                              Item(itemNumber: 9, title: "Реклама и IT поддержка", amount: 59_200, note: nil),
                                              Item(itemNumber: 12, title: "Интернет", amount: 3_500, note: nil),
                                              Item(itemNumber: 15, title: "Ремонт и чистка вентиляции", amount: 15_000, note: nil),
                                              Item(itemNumber: 16, title: "Текущие мелкие расходы", amount: 1_400, note: nil),
                                              Item(itemNumber: 17, title: "Чистка жироуловителей и канализации", amount: 10_139, note: nil)]
                                ),

                                Group(groupNumber: 0, title: "Расходы на доставку", amount: 9_528, target: nil,
                                      items: [Item(itemNumber: 2, title: "Агрегаторы", amount: 9_528, note: nil)]
                                )
                               ]
        )
}
