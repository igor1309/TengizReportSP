//
//  saperavi_2020_09_report.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 16.02.2021.
//

@testable import TengizReportModel

extension TokenizedReport.Report {
    static let saperavi_2020_09: TokenizedReport.Report =
        TokenizedReport.Report(monthStr: "сентябрь2020",
                               month: 09,
                               year: 2020,
                               company: "Саперави Аминьевка",
                               revenue: 2_440_021,
                               dailyAverage: 81_334,
                               openingBalance: -739_626.06,
                               balance: 96_628.63,
                               runningBalance: -642_997.43,
                               totalExpenses: 2_343_392.37,

                               groups: [
                                Group(groupNumber: 0, title: "Основные расходы", amount: 218_500, target: 0.2,
                                      items: [Item(itemNumber: 1, title: "Аренда торгового помещения", amount: 200_000, note: "(за август)"),
                                              Item(itemNumber: 5, title: "Аренда головного офиса", amount: 11_500, note: nil),
                                              Item(itemNumber: 6, title: "Аренда головного склада", amount: 7_000, note: nil)]
                                ),

                                Group(groupNumber: 0, title: "Зарплата", amount: 1059_056, target: 0.2,
                                      items: [Item(itemNumber: 1, title: "ФОТ", amount: 960_056, note: "( за вторую часть августа и первую  часть сентября)"),
                                              Item(itemNumber: 2, title: "ФОТ Бренд, логистика, бухгалтерия", amount: 99_000, note: nil)]
                                ),

                                Group(groupNumber: 0, title: "Фактический приход товара и оплата товара", amount: 645184.37, target: 0.25,
                                      items: [Item(itemNumber: 1, title: "Приход товара по накладным", amount: 632_684.37, note: "946.056р (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)"),
                                              Item(itemNumber: 2, title: "Предоплаченный товар, но не отраженный в приходе", amount: 12_500, note: "Студиопак Итого 12.500 (влажные салфетки);")]
                                ),

                                Group(groupNumber: 0, title: "Прочие расходы", amount: 402_520, target: 0.15,
                                      items: [Item(itemNumber: 1, title: "Налоговые платежи", amount: 26_964, note: nil),
                                              Item(itemNumber: 2, title: "Банковское обслуживание", amount: 6_419, note: nil),
                                              Item(itemNumber: 3, title: "Юридическое сопровождение", amount: 40_000, note: nil),
                                              Item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", amount: 26_581, note: nil),
                                              Item(itemNumber: 6, title: "Обслуживание кассовой программы Айко", amount: 16_336, note: nil),
                                              Item(itemNumber: 8, title: "Обслуживание мобильного приложения", amount: 9_200, note: nil),
                                              Item(itemNumber: 9, title: "Реклама и IT поддержка", amount: 65_000, note: nil),
                                              Item(itemNumber: 12, title: "Интернет", amount: 9_000, note: nil),
                                              Item(itemNumber: 16, title: "Текущие мелкие расходы", amount: 1_600, note: nil),
                                              Item(itemNumber: 20, title: "Чистка вентиляции", amount: 26_250, note: nil),
                                              Item(itemNumber: 21, title: "Обслуживание банкетов", amount: 15_250, note: nil),
                                              Item(itemNumber: 22, title: "Хэдхантер (подбор пероснала)", amount: 9_720, note: nil),
                                              Item(itemNumber: 23, title: "Аудит кантора (Бухуслуги)", amount: 60_000, note: nil),
                                              Item(itemNumber: 24, title: "Стол Тенгиз", amount: 17_905, note: nil),
                                              Item(itemNumber: 25, title: "Стол Игорь", amount: 47_090, note: nil),
                                              Item(itemNumber: 26, title: "Стол Андрей", amount: 9_550, note: nil),
                                              Item(itemNumber: 27, title: "Сервис Гуру (система аттестации, за 1 год)", amount: 12_655, note: nil)]
                                ),

                                Group(groupNumber: 0, title: "Расходы на доставку", amount: 18_132, target: nil,
                                      items: [Item(itemNumber: 2, title: "Агрегаторы", amount: 18_132, note: nil)]
                                )
                               ]
        )
}
