//
//  saperavi_2020_09.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 11.02.2021.
//

@testable import TengizReportModel

extension TokenizedReport {
    static let saperavi_2020_09 = TokenizedReport(
        header:
            [Token<HeaderSymbol>(source: "Название объекта: Саперави Аминьевка",
                                 symbol: .company(name: "Саперави Аминьевка")),
             Token<HeaderSymbol>(source: "Месяц: сентябрь2020",
                                 symbol: .month(monthStr: "сентябрь2020")),
             Token<HeaderSymbol>(source: "Оборот:2.440.021",
                                 symbol: .revenue(2_440_021)),
             Token<HeaderSymbol>(source: "Средний показатель: 81.334",
                                 symbol: .dailyAverage(81_334))],

        body: [
            [Token<BodySymbol>(source: "Основные расходы:\t\t20%\t8.95%",
                               symbol: .header(title: "Основные расходы", plan: 0.2, fact: 0.0895)),
             Token<BodySymbol>(source: "1. Аренда торгового помещения\t 200.000 (за август)\t\t",
                               symbol: .item(itemNumber: 1, title: "Аренда торгового помещения", value: 200_000, note: "(за август)")),
             Token<BodySymbol>(source: "5. Аренда головного офиса\t11.500\t\t",
                               symbol: .item(itemNumber: 5, title: "Аренда головного офиса", value: 11_500, note: nil)),
             Token<BodySymbol>(source: "6. Аренда головного склада\t7.000\t\t",
                               symbol: .item(itemNumber: 6, title: "Аренда головного склада", value: 7_000, note: nil)),
             Token<BodySymbol>(source: "ИТОГ:\t218.500\t\t",
                               symbol: .footer(title: "ИТОГ:", value: 218_500))],

            [Token<BodySymbol>(source: "Зарплата:\t\t20%\t43.4%",
                               symbol: .header(title: "Зарплата", plan: 0.2, fact: 0.434)),
             Token<BodySymbol>(source: "1.ФОТ\t 960.056( за вторую часть августа и первую  часть сентября)\t\t",
                               symbol: .item(itemNumber: 1, title: "ФОТ", value: 960_056, note: "( за вторую часть августа и первую  часть сентября)")),
             Token<BodySymbol>(source: "2. ФОТ Бренд, логистика, бухгалтерия\t99.000\t\t",
                               symbol: .item(itemNumber: 2, title: "ФОТ Бренд, логистика, бухгалтерия", value: 99_000, note: nil)),
             Token<BodySymbol>(source: "ИТОГ:\t1.059.056\t\t",
                               symbol: .footer(title: "ИТОГ:", value: 1_059_056))],

            [Token<BodySymbol>(source: "Фактический приход товара и оплата товара:\t946.056р\t25%\t",
                               symbol: .header(title: "Фактический приход товара и оплата товара", plan: 0.25, fact: nil)),
             Token<BodySymbol>(source: "1. Приход товара по накладным\t 946.056р (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)\t\t",
                               symbol: .item(itemNumber: 1, title: "Приход товара по накладным", value: 632_684.37, note: "946.056р (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)")),
             Token<BodySymbol>(source: "2. Предоплаченный товар, но не отраженный в приходе\tСтудиопак Итого 12.500 (влажные салфетки);\t\t",
                               symbol: .item(itemNumber: 2, title: "Предоплаченный товар, но не отраженный в приходе", value: 12_500, note: "Студиопак Итого 12.500 (влажные салфетки);")),
             Token<BodySymbol>(source: "ИТОГ:\t645.184р37к\t\t",
                               symbol: .footer(title: "ИТОГ:", value: 645_184.37))],

            [Token<BodySymbol>(source: "Прочие расходы:\t\t15%\t16.5%",
                               symbol: .header(title: "Прочие расходы", plan: 0.15, fact: 0.165)),
             Token<BodySymbol>(source: "1.Налоговые платежи \t26.964\t\t",
                               symbol: .item(itemNumber: 1, title: "Налоговые платежи", value: 26_964, note: nil)),
             Token<BodySymbol>(source: "2.Банковское обслуживание\t6.419\t\t",
                               symbol: .item(itemNumber: 2, title: "Банковское обслуживание", value: 6_419, note: nil)),
             Token<BodySymbol>(source: "3.Юридическое сопровождение\t40.000\t\t",
                               symbol: .item(itemNumber: 3, title: "Юридическое сопровождение", value: 40_000, note: nil)),
             Token<BodySymbol>(source: "4.Банковская комиссия 1.6% за эквайринг\t26.581\t\t",
                               symbol: .item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", value: 26_581, note: nil)),
             Token<BodySymbol>(source: "6.Обслуживание кассовой программы Айко\t16.336\t\t",
                               symbol: .item(itemNumber: 6, title: "Обслуживание кассовой программы Айко", value: 16_336, note: nil)),
             Token<BodySymbol>(source: "8.Обслуживание мобильного приложения\t9.200\t\t",
                               symbol: .item(itemNumber: 8, title: "Обслуживание мобильного приложения", value: 9_200, note: nil)),
             Token<BodySymbol>(source: "9.Реклама и IT поддержка\t65.000\t\t",
                               symbol: .item(itemNumber: 9, title: "Реклама и IT поддержка", value: 65_000, note: nil)),
             Token<BodySymbol>(source: "12.Интернет\t9.000\t\t",
                               symbol: .item(itemNumber: 12, title: "Интернет", value: 9_000, note: nil)),
             Token<BodySymbol>(source: "16. Текущие мелкие расходы \t1.600\t\t",
                               symbol: .item(itemNumber: 16, title: "Текущие мелкие расходы", value: 1_600, note: nil)),
             Token<BodySymbol>(source: "20. Чистка вентиляции\t26.250\t\t",
                               symbol: .item(itemNumber: 20, title: "Чистка вентиляции", value: 26_250, note: nil)),
             Token<BodySymbol>(source: "21. Обслуживание банкетов\t15.250\t\t",
                               symbol: .item(itemNumber: 21, title: "Обслуживание банкетов", value: 15_250, note: nil)),
             Token<BodySymbol>(source: "22. Хэдхантер (подбор пероснала)\t9.720\t\t",
                               symbol: .item(itemNumber: 22, title: "Хэдхантер (подбор пероснала)", value: 9_720, note: nil)),
             Token<BodySymbol>(source: "23. Аудит кантора (Бухуслуги)\t60.000\t\t",
                               symbol: .item(itemNumber: 23, title: "Аудит кантора (Бухуслуги)", value: 60_000, note: nil)),
             Token<BodySymbol>(source: "24. Стол Тенгиз\t17.905\t\t",
                               symbol: .item(itemNumber: 24, title: "Стол Тенгиз", value: 17_905, note: nil)),
             Token<BodySymbol>(source: "25. Стол Игорь\t47.090\t\t",
                               symbol: .item(itemNumber: 25, title: "Стол Игорь", value: 47_090, note: nil)),
             Token<BodySymbol>(source: "26. Стол Андрей\t9.550\t\t",
                               symbol: .item(itemNumber: 26, title: "Стол Андрей", value: 9_550, note: nil)),
             Token<BodySymbol>(source: "27. Сервис Гуру (система аттестации, за 1 год)\t12.655\t\t",
                               symbol: .item(itemNumber: 27, title: "Сервис Гуру (система аттестации, за 1 год)", value: 12_655, note: nil)),
             Token<BodySymbol>(source: "ИТОГ:\t402.520\t\t",
                               symbol: .footer(title: "ИТОГ:", value: 402_520))],

            [Token<BodySymbol>(source: "Расходы на доставку:\t\t\t",
                               symbol: .header(title: "Расходы на доставку", plan: nil, fact: nil)),
             Token<BodySymbol>(source: "2. Агрегаторы\t18.132\t\t",
                               symbol: .item(itemNumber: 2, title: "Агрегаторы", value: 18_132, note: nil)),
             Token<BodySymbol>(source: "ИТОГ:\t18.132\t\t",
                               symbol: .footer(title: "ИТОГ:", value: 18_132))]
        ],

        footer:

            [Token<FooterSymbol>(source: "ИТОГ всех расходов за месяц:\t2.343.392р 37к",
                                 symbol: .totalExpenses(title: "ИТОГ всех расходов за месяц", value: 2343392.37)),
             Token<FooterSymbol>(source: "Фактический остаток:\t96.628р 63к\t20%",
                                 symbol: .balance(title: "Фактический остаток", value: 96628.63, percentage: Optional(0.2))),
             Token<FooterSymbol>(source: "Минус с августа переходит 739.626р 06к",
                                 symbol: .openingBalance(title: "Минус с августа переходит 739.626р 06к", value: -739626.06)),
             Token<FooterSymbol>(source: "ИТОГ:\tМинус 642.997р 43к",
                                 symbol: .runningBalance(title: "ИТОГ", value: -642997.43))]
    )
}
