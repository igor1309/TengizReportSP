//
//  saperavi_2020_07.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 11.02.2021.
//

@testable import TengizReportModel

extension TokenizedReport {
    static let saperavi_2020_07 = TokenizedReport(
        header:
            [Token<HeaderSymbol>(source: "Название объекта: Саперави Аминьевка",
                                 symbol: .company(name: "Саперави Аминьевка")),
             Token<HeaderSymbol>(source: "Месяц: июль2020",
                                 symbol: .month(monthStr: "июль2020")),
             Token<HeaderSymbol>(source: "Оборот:1.067.807",
                                 symbol: .revenue(1_067_807)),
             Token<HeaderSymbol>(source: "Средний показатель: 34.445",
                                 symbol: .dailyAverage(34_445))],

        body: [
            // group 1
            [Token<BodySymbol>(source: "Основные расходы:\t\t25%\t",
                               symbol: .header(title: "Основные расходы", plan: 0.25, fact: nil)),
             Token<BodySymbol>(source: "1. Аренда торгового помещения\t46.667 (за июнь)\t\t",
                               symbol: .item(itemNumber: 1, title: "Аренда торгового помещения", value: 46_667, note: "(за июнь)")),
             Token<BodySymbol>(source: "5. Аренда головного офиса\t11.500\t\t",
                               symbol: .item(itemNumber: 5, title: "Аренда головного офиса", value: 11_500, note: nil)),
             Token<BodySymbol>(source: "6. Аренда головного склада\t7.000\t\t",
                               symbol: .item(itemNumber: 6, title: "Аренда головного склада", value: 7_000, note: nil)),
             Token<BodySymbol>(source: "ИТОГ:\t65.167\t\t",
                               symbol: .footer(title: "ИТОГ:", value: 65_167))],

            // group 2
            [Token<BodySymbol>(source: "Зарплата:\t\t22%\t",
                               symbol: .header(title: "Зарплата", plan: 0.22, fact: nil)),
             Token<BodySymbol>(source: "1.ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)\t\t",
                               symbol: .item(itemNumber: 1, title: "ФОТ", value: 704_848, note: Optional("( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)"))),
             Token<BodySymbol>(source: "2. ФОТ Бренд, логистика, бухгалтерия\t99.000\t\t",
                               symbol: .item(itemNumber: 2, title: "ФОТ Бренд, логистика, бухгалтерия", value: 99_000, note: nil)),
             Token<BodySymbol>(source: "ИТОГ:\t803.848\t\t",
                               symbol: .footer(title: "ИТОГ:", value: 803_848))],

            // group 3
            [Token<BodySymbol>(source: "Фактический приход товара и оплата товара:\t\t25%\t",
                               symbol: .header(title: "Фактический приход товара и оплата товара", plan: 0.25, fact: nil)),
             Token<BodySymbol>(source: "1. Приход товара по накладным\t922.936р37к (оплаты фактические: 313.570р26к-переводы; 87.091р20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р46к)\t\t",
                               symbol: .item(itemNumber: 1, title: "Приход товара по накладным", value: 498_373.46, note: "922.936р37к (оплаты фактические: 313.570р26к-переводы; 87.091р20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р46к)")),
             Token<BodySymbol>(source: "2. Предоплаченный товар, но не отраженный в приходе\tБейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400\t\t",
                               symbol: .item(itemNumber: 2, title: "Предоплаченный товар, но не отраженный в приходе", value: 40_400, note: "Бейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400")),
             Token<BodySymbol>(source: "ИТОГ:\t538.773р46к\t\t",
                               symbol: .footer(title: "ИТОГ:", value: 538_773.46))],

            // group 4
            [Token<BodySymbol>(source: "Прочие расходы:\t\t8%\t",
                               symbol: .header(title: "Прочие расходы", plan: 0.08, fact: nil)),
             Token<BodySymbol>(source: "1.Налоговые платежи \t13.318р93к\t\t",
                               symbol: .item(itemNumber: 1, title: "Налоговые платежи", value: 13_318.93, note: nil)),
             Token<BodySymbol>(source: "2.Банковское обслуживание\t5.778\t\t",
                               symbol: .item(itemNumber: 2, title: "Банковское обслуживание", value: 5_778, note: nil)),
             Token<BodySymbol>(source: "3.Юридическое сопровождение\t20.000\t\t",
                               symbol: .item(itemNumber: 3, title: "Юридическое сопровождение", value: 20_000, note: nil)),
             Token<BodySymbol>(source: "4.Банковская комиссия 1.6% за эквайринг\t12.785\t\t",
                               symbol: .item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", value: 12_785, note: nil)),
             Token<BodySymbol>(source: "6.Обслуживание кассовой программы\t21.806р20к\t\t",
                               symbol: .item(itemNumber: 6, title: "Обслуживание кассовой программы", value: 21_806.20, note: nil)),
             Token<BodySymbol>(source: "9. Реклама и IT поддержка\t104.000\t\t",
                               symbol: .item(itemNumber: 9, title: "Реклама и IT поддержка", value: 104_000, note: nil)),
             Token<BodySymbol>(source: "14. Контур (эл.отчетность)\t3.000\t\t",
                               symbol: .item(itemNumber: 14, title: "Контур (эл.отчетность)", value: 3_000, note: nil)),
             Token<BodySymbol>(source: "16. Текущие мелкие расходы \t2.910\t\t",
                               symbol: .item(itemNumber: 16, title: "Текущие мелкие расходы", value: 2_910, note: nil)),
             Token<BodySymbol>(source: "18. Регистрация Кассового аппарата (запасной)\t2.000\t\t",
                               symbol: .item(itemNumber: 18, title: "Регистрация Кассового аппарата (запасной)", value: 2_000, note: nil)),
             Token<BodySymbol>(source: "22. Хэдхантер (подбор пероснала)\t3.240\t\t",
                               symbol: .item(itemNumber: 22, title: "Хэдхантер (подбор пероснала)", value: 3_240, note: nil)),
             Token<BodySymbol>(source: "23. Аудит кантора (Бухуслуги)\t60.000\t\t",
                               symbol: .item(itemNumber: 23, title: "Аудит кантора (Бухуслуги)", value: 60_000, note: nil)),
             Token<BodySymbol>(source: "24. Столы Тенгиза\t6.100\t\t",
                               symbol: .item(itemNumber: 24, title: "Столы Тенгиза", value: 6_100, note: nil)),
             Token<BodySymbol>(source: "25. Стол Игорь\t5.470\t\t",
                               symbol: .item(itemNumber: 25, title: "Стол Игорь", value: 5_470, note: nil)),
             Token<BodySymbol>(source: "26. Вино отправляли в подарок\t1.900\t\t",
                               symbol: .item(itemNumber: 26, title: "Вино отправляли в подарок", value: 1_900, note: nil)),
             Token<BodySymbol>(source: "ИТОГ:\t262.308\t\t",
                               symbol: .footer(title: "ИТОГ:", value: 262_308))],

            // group 5
            [Token<BodySymbol>(source: "Расходы на доставку:\t\t\t",
                               symbol: .header(title: "Расходы на доставку", plan: nil, fact: nil)),
             Token<BodySymbol>(source: "2. Агрегаторы\t6.981\t\t",
                               symbol: .item(itemNumber: 2, title: "Агрегаторы", value: 6_981, note: nil)),
             Token<BodySymbol>(source: "ИТОГ:\t6.981\t\t",
                               symbol: .footer(title: "ИТОГ:", value: 6_981))]],

        footer:
            [Token<FooterSymbol>(source: "ИТОГ всех расходов за месяц:\t1.677.077р46к",
                                 symbol: .totalExpenses(title: "ИТОГ всех расходов за месяц", value: 1_677_077.46)),
             Token<FooterSymbol>(source: "Фактический остаток:\t-609.230р46к\t20%",
                                 symbol: .balance(title: "Фактический остаток", value: -609_230.46, percentage: 0.2)),
             Token<FooterSymbol>(source: "-173.753 остаток с июня",
                                 symbol: .openingBalance(title: "-173.753 остаток с июня", value: -173_753)),
             Token<FooterSymbol>(source: "-28.000 субсидия, поступила в июле",
                                 symbol: .extraIncomeExpenses(title: "-28.000 субсидия, поступила в июле", value: -28_000)),
             Token<FooterSymbol>(source: "ИТОГ:\t-407.477р46к",
                                 symbol: .runningBalance(title: "ИТОГ", value: -407_477.46))
            ]
    )
}
