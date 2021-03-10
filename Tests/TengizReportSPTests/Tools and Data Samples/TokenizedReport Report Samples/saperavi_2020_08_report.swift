//
//  saperavi_2020_08_report.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 16.02.2021.
//

@testable import TengizReportModel

extension TokenizedReport.Report {
    static let saperavi_2020_08: TokenizedReport.Report =
        TokenizedReport.Report(monthStr: "август2020",
                               month: 08,
                               year: 2020,
                               company: "Саперави Аминьевка",
                               revenue: 1_738_788,
                               dailyAverage: 56_089,
                               openingBalance: -407_477.46,
                               balance: -355_483.36,
                               runningBalance: -739_626.06,
                               totalExpenses: 2_094_271.36,

                               groups: [
                                Group(groupNumber: 0, title: "Основные расходы", amount: 218_500, target: 0.2,
                                      items: [Item(itemNumber: 1, title: "Аренда торгового помещения", amount: 200_000, note: "(за июль)"),
                                              Item(itemNumber: 5, title: "Аренда головного офиса", amount: 11_500, note: nil),
                                              Item(itemNumber: 6, title: "Аренда головного склада", amount: 7_000, note: nil)]
                                ),
                                
                                Group(groupNumber: 0, title: "Зарплата", amount: 983_510, target: 0.2,
                                      items: [Item(itemNumber: 1, title: "ФОТ", amount: 894_510, note: "( за вторую часть июля и первая часть августа)"),
                                              Item(itemNumber: 2, title: "ФОТ Бренд, логистика, бухгалтерия", amount: 99_000, note: nil),
                                              Item(itemNumber: 0, title: "Correction", amount: -10_000, note: "-10.000 за перерасход питание персонала в июле")]
                                ),

                                Group(groupNumber: 0, title: "Фактический приход товара и оплата товара", amount: 545119.36, target: 0.25,
                                      items: [Item(itemNumber: 1, title: "Приход товара по накладным", amount: 521519.36, note: "753.950р74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)"),
                                              Item(itemNumber: 2, title: "Предоплаченный товар, но не отраженный в приходе", amount: 23_600, note: "КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого 23.600")]
                                ),

                                Group(groupNumber: 0, title: "Прочие расходы", amount: 326_556, target: 0.15,
                                      items: [Item(itemNumber: 1, title: "Налоговые платежи", amount: 20_614, note: nil),
                                              Item(itemNumber: 2, title: "Банковское обслуживание", amount: 7_234, note: nil),
                                              Item(itemNumber: 3, title: "Юридическое сопровождение", amount: 40_000, note: nil),
                                              Item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", amount: 19_769, note: nil),
                                              Item(itemNumber: 6, title: "Обслуживание кассовой программы", amount: 14_866, note: nil),
                                              Item(itemNumber: 9, title: "Реклама и IT поддержка", amount: 53_500, note: nil),
                                              Item(itemNumber: 12, title: "Интернет", amount: 12_201, note: "7.701+4.500"),
                                              Item(itemNumber: 14, title: "РПК Ника (крепления д/телевизоров и монтаж)", amount: 30_000, note: nil),
                                              Item(itemNumber: 15, title: "Аренда зарядных устройств и раций", amount: 5_000, note: nil),
                                              Item(itemNumber: 16, title: "Текущие мелкие расходы", amount: 2_250, note: nil),
                                              Item(itemNumber: 18, title: "Аренда оборудования д/питьевой воды", amount: 5_130, note: nil),
                                              Item(itemNumber: 23, title: "Аудит кантора (Бухуслуги)", amount: 60_000, note: nil),
                                              Item(itemNumber: 24, title: "Стол Тенгиз", amount: 10_552, note: nil),
                                              Item(itemNumber: 25, title: "Стол Игорь", amount: 45_440, note: nil)]
                                ),

                                Group(groupNumber: 0, title: "Расходы на доставку", amount: 20_586, target: nil,
                                      items: [Item(itemNumber: 2, title: "Агрегаторы", amount: 20_586, note: nil)]
                                )
                               ]
        )
}
