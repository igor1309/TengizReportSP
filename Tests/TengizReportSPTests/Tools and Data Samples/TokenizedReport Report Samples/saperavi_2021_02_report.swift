//
//  saperavi_2021_02_report.swift
//  
//
//  Created by Igor Malyarov on 11.03.2021.
//

@testable import TengizReportModel

extension TokenizedReport.Report {
    static let saperavi_2021_02: TokenizedReport.Report =
        TokenizedReport.Report(
            monthStr: "Февраль2021",
            month: 02,
            year: 2021,
            company: "Саперави Аминьевка",
            revenue: 2_903_617,
            dailyAverage: 103_700,
            openingBalance: -1_422_601.83,
            balance: -770_256.30,
            runningBalance: -2_192_858.13,
            totalExpenses: 3_673_873.30,
            
            groups: [
                Group(groupNumber: 1, title: "Основные расходы", amount: 1_299_025.61, target: Optional(0.2),
                      items: [Item(itemNumber: 1, title: "Аренда торгового помещения", amount: 1_000__000, note: "500.000 декабрь+500.000 январь"),
                              Item(itemNumber: 3, title: "Электричество", amount: 280525.61, note: "(с момента открытия не было счетов)"),
                              Item(itemNumber: 5, title: "Аренда головного офиса", amount: 11_500),
                              Item(itemNumber: 6, title: "Аренда головного склада", amount: 7_000)]
                ),

                Group(groupNumber: 2, title: "Зарплата", amount: 1_155_713, target: Optional(0.2),
                      items: [Item(itemNumber: 1, title: "ФОТ", amount: 1056_713, note: "( за вторую  часть декабря и первую часть января)"),
                              Item(itemNumber: 2, title: "ФОТ Бренд, логистика, бухгалтерия", amount: 99_000)]
                ),

                Group(groupNumber: 3, title: "Фактический приход товара и оплата товара", amount: 800_323.47, target: Optional(0.25),
                      items: [Item(itemNumber: 1, title: "Приход товара по накладным", amount: 800_323.47, note: "817.204р07к; (оплаты фактические: 671.144р 29к -переводы; 90.698р18к -корпоративная карта; 38.481р -наличные из кассы; Итого 800.323р 47к)")]
                ),

                Group(groupNumber: 4, title: "Прочие расходы", amount: 388075.22, target: Optional(0.15),
                      items: [Item(itemNumber: 1, title: "Налоговые платежи", amount: 51_197.5),
                              Item(itemNumber: 2, title: "Банковское обслуживание", amount: 7_750.72),
                              Item(itemNumber: 3, title: "Юридическое сопровождение", amount: 40_000),
                              Item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", amount: 33_114),
                              TengizReportModel.TokenizedReport.Report.Group.Item(itemNumber: 6, title: "Обслуживание кассовой программы Айко", amount: 10_730, note: "4.500+6.230"),
                              TengizReportModel.TokenizedReport.Report.Group.Item(itemNumber: 8, title: "Печать рекламных буклетов и их раздача", amount: 3_457),
                              Item(itemNumber: 9, title: "Реклама и IT поддержка", amount: 79_300),
                              Item(itemNumber: 12, title: "Интернет", amount: 4_500),
                              Item(itemNumber: 16, title: "Текущие мелкие расходы", amount: 2_250),
                              Item(itemNumber: 20, title: "Чистка вентиляции", amount: 35_000),
                              Item(itemNumber: 22, title: "Хэдхантер (подбор пероснала)", amount: 8_046),
                              Item(itemNumber: 23, title: "Аудит кантора (Бухуслуги)", amount: 60_000),
                              Item(itemNumber: 24, title: "Очистка засора трапа", amount: 3_000),
                              Item(itemNumber: 25, title: "Фотосьемка", amount: 9_000),
                              Item(itemNumber: 26, title: "Декор день Св. Валентина", amount: 32_330),
                              Item(itemNumber: 27, title: "Игорь алкоголь на 23 февраля (еда была списана по себесу)", amount: 8_400)]
                ),

                Group(groupNumber: 5, title: "Расходы на доставку", amount: 30_736, target: nil,
                      items: [Item(itemNumber: 1, title: "Курьеры", amount: 8_170),
                              Item(itemNumber: 2, title: "Агрегаторы", amount: 22_566)]
                )
            ]
        )
}
