//
//  saperavi_2020_07_report.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 11.02.2021.
//

import Model

extension TokenizedReport.Report {
    static let saperavi_2020_07: TokenizedReport.Report =
        TokenizedReport.Report(monthStr: "июль2020",
                               month: 07,
                               year: 2020,
                               company: "Саперави Аминьевка",
                               revenue: 1_067_807,
                               dailyAverage: 34_445,
                               openingBalance: -173_753,
                               balance: -609_230.46,
                               runningBalance: -407_477.46,
                               totalExpenses: 1_677_077.46,

                               groups: [
                                Group(groupNumber: 0, title: "Основные расходы", amount: 65_167, target: 0.25,
                                      items: [Item(itemNumber: 1, title: "Аренда торгового помещения", amount: 46_667, note: "(за июнь)"),
                                              Item(itemNumber: 5, title: "Аренда головного офиса", amount: 11_500, note: nil),
                                              Item(itemNumber: 6, title: "Аренда головного склада", amount: 7_000, note: nil)]
                                ),

                                Group(groupNumber: 0, title: "Зарплата", amount: 803_848, target: 0.22,
                                      items: [Item(itemNumber: 1, title: "ФОТ", amount: 704_848, note: "( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"),
                                              Item(itemNumber: 2, title: "ФОТ Бренд, логистика, бухгалтерия", amount: 99__000, note: nil)]
                                ),

                                Group(groupNumber: 0, title: "Фактический приход товара и оплата товара", amount: 538_773.46, target: 0.25,
                                      items: [Item(itemNumber: 1, title: "Приход товара по накладным", amount: 498373.46, note: Optional("922.936р37к (оплаты фактические: 313.570р26к-переводы; 87.091р20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р46к)")),
                                              Item(itemNumber: 2, title: "Предоплаченный товар, но не отраженный в приходе", amount: 40_400, note: Optional("Бейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400"))]
                                ),

                                Group(groupNumber: 0, title: "Прочие расходы", amount: 262_308, target: 0.08,
                                      items: [Item(itemNumber: 1, title: "Налоговые платежи", amount: 13_318.93, note: nil),
                                              Item(itemNumber: 2, title: "Банковское обслуживание", amount: 5_778, note: nil),
                                              Item(itemNumber: 3, title: "Юридическое сопровождение", amount: 20_000, note: nil),
                                              Item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", amount: 12_785, note: nil),
                                              Item(itemNumber: 6, title: "Обслуживание кассовой программы", amount: 21_806.20, note: nil),
                                              Item(itemNumber: 9, title: "Реклама и IT поддержка", amount: 104_000, note: nil),
                                              Item(itemNumber: 14, title: "Контур (эл.отчетность)", amount: 3_000, note: nil),
                                              Item(itemNumber: 16, title: "Текущие мелкие расходы", amount: 2_910, note: nil),
                                              Item(itemNumber: 18, title: "Регистрация Кассового аппарата (запасной)", amount: 2_000, note: nil),
                                              Item(itemNumber: 22, title: "Хэдхантер (подбор пероснала)", amount: 3_240, note: nil),
                                              Item(itemNumber: 23, title: "Аудит кантора (Бухуслуги)", amount: 60_000, note: nil),
                                              Item(itemNumber: 24, title: "Столы Тенгиза", amount: 6_100, note: nil),
                                              Item(itemNumber: 25, title: "Стол Игорь", amount: 5_470, note: nil),
                                              Item(itemNumber: 26, title: "Вино отправляли в подарок", amount: 1_900, note: nil)]
                                ),

                                Group(groupNumber: 0, title: "Расходы на доставку", amount: 6_981, target: nil,
                                      items: [Item(itemNumber: 2, title: "Агрегаторы", amount: 6_981, note: nil)]
                                ),
                               ]
        )

    

}
