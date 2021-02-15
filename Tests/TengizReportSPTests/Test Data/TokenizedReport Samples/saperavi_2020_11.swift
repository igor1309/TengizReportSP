//
//  saperavi_2020_11.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 15.02.2021.
//

import XCTest
@testable import TengizReportSP

#warning("write a test for these static vars: body.map(token.source) = Source.body.components(separatedBy: '\n')")
extension TokenizedReport {
    static let saperavi_2020_11 = TokenizedReport(
        header: [Token<HeaderSymbol>(
                    source: "Название объекта: Саперави Аминьевка",
                    symbol: HeaderSymbol.company(name: "Саперави Аминьевка")),
                 Token<HeaderSymbol>(
                    source: "Ноябрь2020",
                    symbol: HeaderSymbol.month(monthStr: "Ноябрь2020")),
                 Token<HeaderSymbol>(
                    source: "Оборот:1.885.280",
                    symbol: HeaderSymbol.revenue(1885280.0)),
                 Token<HeaderSymbol>(
                    source: "Средний показатель: 62.842",
                    symbol: HeaderSymbol.dailyAverage(62842.0))],

        body: [
            [Token<BodySymbol>(
                source: "Основные расходы:\t\t20%\t",
                symbol: BodySymbol.header(title: "Основные расходы", plan: 0.2, fact: nil)),
             Token<BodySymbol>(
                source: "1. Аренда торгового помещения\t 500.000 (за октябрь)\t\t",
                symbol: BodySymbol.item(itemNumber: 1, title: "Аренда торгового помещения", value: 500_000, note: Optional("(за октябрь)"))),
             Token<BodySymbol>(
                source: "5. Аренда головного офиса\t11.500\t\t",
                symbol: BodySymbol.item(itemNumber: 5, title: "Аренда головного офиса", value: 11_500, note: nil)),
             Token<BodySymbol>(
                source: "6. Аренда головного склада\t7.000\t\t",
                symbol: BodySymbol.item(itemNumber: 6, title: "Аренда головного склада", value: 7_000, note: nil)),
             Token<BodySymbol>(
                source: "ИТОГ:\t518.500\t\t",
                symbol: BodySymbol.footer(title: "ИТОГ:", value: 518500.0))],
            [Token<BodySymbol>(
                source: "Зарплата:\t\t20%\t",
                symbol: BodySymbol.header(title: "Зарплата", plan: 0.2, fact: nil)),
             Token<BodySymbol>(
                source: "1.ФОТ\t 564.678( за вторую часть октября) \t\t",
                symbol: BodySymbol.item(itemNumber: 1, title: "ФОТ", value: 564_678, note: "( за вторую часть октября)")),
             Token<BodySymbol>(
                source: "2. ФОТ Бренд, логистика, бухгалтерия\t99.000\t\t",
                symbol: BodySymbol.item(itemNumber: 2, title: "ФОТ Бренд, логистика, бухгалтерия", value: 99_000, note: nil)),
             Token<BodySymbol>(
                source: "ИТОГ:\t663.678\t\t",
                symbol: BodySymbol.footer(title: "ИТОГ:", value: 663678.0))],
            [Token<BodySymbol>(
                source: "Фактический приход товара и оплата товара:\t\t25%\t",
                symbol: BodySymbol.header(title: "Фактический приход товара и оплата товара", plan: 0.25, fact: nil)),
             Token<BodySymbol>(
                source: "1. Приход товара по накладным\t 739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого 437.474р 47к)\t\t",
                symbol: BodySymbol.item(itemNumber: 1, title: "Приход товара по накладным", value: 437474.47, note: "739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого 437.474р 47к)")),
             Token<BodySymbol>(
                source: "ИТОГ:\t437.474р47к\t\t",
                symbol: BodySymbol.footer(title: "ИТОГ:", value: 437474.47))],
            [Token<BodySymbol>(
                source: "Прочие расходы:\t\t15%\t",
                symbol: BodySymbol.header(title: "Прочие расходы", plan: 0.15, fact: nil)),
             Token<BodySymbol>(
                source: "1.Налоговые платежи \t31.949р38к\t\t",
                symbol: BodySymbol.item(itemNumber: 1, title: "Налоговые платежи", value: 31_949.38, note: nil)),
             Token<BodySymbol>(
                source: "2.Банковское обслуживание\t5.863р74к\t\t",
                symbol: BodySymbol.item(itemNumber: 2, title: "Банковское обслуживание", value: 5_863.74, note: nil)),
             Token<BodySymbol>(
                source: "3.Юридическое сопровождение\t40.000\t\t",
                symbol: BodySymbol.item(itemNumber: 3, title: "Юридическое сопровождение", value: 40_000, note: nil)),
             Token<BodySymbol>(
                source: "4.Банковская комиссия 1.6% за эквайринг\t22.653\t\t",
                symbol: BodySymbol.item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", value: 22_653, note: nil)),
             Token<BodySymbol>(
                source: "6.Обслуживание кассовой программы Айко\t12.000\t\t",
                symbol: BodySymbol.item(itemNumber: 6, title: "Обслуживание кассовой программы Айко", value: 12_000, note: nil)),
             Token<BodySymbol>(
                source: "8.Обслуживание мобильного приложения\t9.200\t\t",
                symbol: BodySymbol.item(itemNumber: 8, title: "Обслуживание мобильного приложения", value: 9_200, note: nil)),
             Token<BodySymbol>(
                source: "9.Реклама и IT поддержка\t90.000\t\t",
                symbol: BodySymbol.item(itemNumber: 9, title: "Реклама и IT поддержка", value: 90_000, note: nil)),
             Token<BodySymbol>(
                source: "12.Интернет\t4.500\t\t",
                symbol: BodySymbol.item(itemNumber: 12, title: "Интернет", value: 4_500, note: nil)),
             Token<BodySymbol>(
                source: "14. Поверка весов\t3.400\t\t",
                symbol: BodySymbol.item(itemNumber: 14, title: "Поверка весов", value: 3_400, note: nil)),
             Token<BodySymbol>(
                source: "15.Аренда зарядных устройств и раций\t5.000\t\t",
                symbol: BodySymbol.item(itemNumber: 15, title: "Аренда зарядных устройств и раций", value: 5_000, note: nil)),
             Token<BodySymbol>(
                source: "16. Текущие мелкие расходы \t6.690\t\t",
                symbol: BodySymbol.item(itemNumber: 16, title: "Текущие мелкие расходы", value: 6_690, note: nil)),
             Token<BodySymbol>(
                source: "18. Аренда оборудования д/питьевой воды\t5.130\t\t",
                symbol: BodySymbol.item(itemNumber: 18, title: "Аренда оборудования д/питьевой воды", value: 5_130, note: nil)),
             Token<BodySymbol>(
                source: "20. Чистка вентиляции\t35.000\t\t",
                symbol: BodySymbol.item(itemNumber: 20, title: "Чистка вентиляции", value: 35_000, note: nil)),
             Token<BodySymbol>(
                source: "22. Хэдхантер (подбор пероснала)\t9.720\t\t",
                symbol: BodySymbol.item(itemNumber: 22, title: "Хэдхантер (подбор пероснала)", value: 9_720, note: nil)),
             Token<BodySymbol>(
                source: "23. Аудит кантора (Бухуслуги)\t60.000\t\t",
                symbol: BodySymbol.item(itemNumber: 23, title: "Аудит кантора (Бухуслуги)", value: 60_000, note: nil)),
             Token<BodySymbol>(
                source: "24. Яндекс карты\t51.975\t\t",
                symbol: BodySymbol.item(itemNumber: 24, title: "Яндекс карты", value: 51_975, note: nil)),
             Token<BodySymbol>(
                source: "ИТОГ:\t393.081р12к\t\t",
                symbol: BodySymbol.footer(title: "ИТОГ:", value: 393081.12))],
            [Token<BodySymbol>(
                source: "Расходы на доставку:\t\t\t",
                symbol: BodySymbol.header(title: "Расходы на доставку", plan: nil, fact: nil)),
             Token<BodySymbol>(
                source: "2. Агрегаторы\t17.839\t\t",
                symbol: BodySymbol.item(itemNumber: 2, title: "Агрегаторы", value: 17_839, note: nil)),
             Token<BodySymbol>(
                source: "ИТОГ:\t17.839\t\t",
                symbol: BodySymbol.footer(title: "ИТОГ:", value: 17839.0))]
        ],

        footer: [Token<FooterSymbol>(
                    source: "ИТОГ всех расходов за месяц:\t2.030.572р59к",
                    symbol: FooterSymbol.totalExpenses(title: "ИТОГ всех расходов за месяц", value: 2030572.59)),
                 Token<FooterSymbol>(
                    source: "Фактический остаток:\tМинус 145.292р59к\t20%",
                    symbol: FooterSymbol.balance(title: "Фактический остаток", value: -145292.59, percentage: Optional(0.2))),
                 Token<FooterSymbol>(
                    source: "Переходящий минус 920.304р 17к",
                    symbol: FooterSymbol.openingBalance(title: "Переходящий минус 920.304р 17к", value: -920304.17)),
                 Token<FooterSymbol>(
                    source: "ИТОГ:\tМинус 1.065.596р 76к",
                    symbol: FooterSymbol.runningBalance(title: "ИТОГ", value: -1065596.76))]
    )

}
