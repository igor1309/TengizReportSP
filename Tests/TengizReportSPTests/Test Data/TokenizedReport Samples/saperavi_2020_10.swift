//
//  saperavi_2020_10.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 11.02.2021.
//

import XCTest
@testable import Model

extension TokenizedReport {
    static let saperavi_2020_10 = TokenizedReport(
        header: [
            Token<HeaderSymbol>(source: "Название объекта: Саперави Аминьевка",
                                symbol: .company(name: "Саперави Аминьевка")),
            Token<HeaderSymbol>(source: "Октябрь2020",
                                symbol: .month(monthStr: "Октябрь2020")),
            Token<HeaderSymbol>(source: "Оборот:2.587.735",
                                symbol: .revenue(2587_735)),
            Token<HeaderSymbol>(source: "Средний показатель: 83.475",
                                symbol: .dailyAverage(83_475)),
        ],

        body: [
            [Token<BodySymbol>(source: "Основные расходы:\t\t20%\t",
                               symbol: .header(title: "Основные расходы", plan: 0.2, fact: nil)),
             Token<BodySymbol>(source: "1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)\t\t",
                               symbol: .item(itemNumber: 1, title: "Аренда торгового помещения", value: 600_000, note: "200.000 (за август) +400.000 (за сентябрь)")),
             Token<BodySymbol>(source: "5. Аренда головного офиса\t11.500\t\t",
                               symbol: .item(itemNumber: 5, title: "Аренда головного офиса", value: 11_500, note: nil)),
             Token<BodySymbol>(source: "6. Аренда головного склада\t7.000\t\t",
                               symbol: .item(itemNumber: 6, title: "Аренда головного склада", value: 7_000, note: nil)),
             Token<BodySymbol>(source: "ИТОГ:\t618.500\t\t",
                               symbol: .footer(title: "ИТОГ:", value: 618_500)),
            ],
            [Token<BodySymbol>(source: "Зарплата:\t\t20%\t",
                               symbol: .header(title: "Зарплата", plan: 0.2, fact: nil)),
             Token<BodySymbol>(source: "1.ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)\t\t",
                               symbol: .item(itemNumber: 1, title: "ФОТ", value: 1147_085, note: "( за вторую часть сентября и первую  часть октября)")),
             Token<BodySymbol>(source: "2. ФОТ Бренд, логистика, бухгалтерия\t99.000\t\t",
                               symbol: .item(itemNumber: 2, title: "ФОТ Бренд, логистика, бухгалтерия", value: 99_000, note: nil)),
             Token<BodySymbol>(source: "ИТОГ:\t1.246.085\t\t",
                               symbol: .footer(title: "ИТОГ:", value: 1246_085)),
            ],
            [Token<BodySymbol>(source: "Фактический приход товара и оплата товара:\t\t25%\t",
                               symbol: .header(title: "Фактический приход товара и оплата товара", plan: 0.25, fact: nil)),
             Token<BodySymbol>(source: "1. Приход товара по накладным\t 907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)\t\t",
                               symbol: .item(itemNumber: 1, title: "Приход товара по накладным", value: 628215.74, note: "907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)")),
             Token<BodySymbol>(source: "ИТОГ:\t628.215р 74к\t\t",
                               symbol: .footer(title: "ИТОГ:", value: 628215.74)),
            ],
            [Token<BodySymbol>(source: "Прочие расходы:\t\t15%\t",
                               symbol: .header(title: "Прочие расходы", plan: 0.15, fact: nil)),
             Token<BodySymbol>(source: "1.Налоговые платежи \t35.311\t\t",
                               symbol: .item(itemNumber: 1, title: "Налоговые платежи", value: 35_311, note: nil)),
             Token<BodySymbol>(source: "2.Банковское обслуживание\t6.279\t\t",
                               symbol: .item(itemNumber: 2, title: "Банковское обслуживание", value: 6_279, note: nil)),
             Token<BodySymbol>(source: "3.Юридическое сопровождение\t40.000\t\t",
                               symbol: .item(itemNumber: 3, title: "Юридическое сопровождение", value: 40_000, note: nil)),
             Token<BodySymbol>(source: "4.Банковская комиссия 1.6% за эквайринг\t31.587\t\t",
                               symbol: .item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", value: 31_587, note: nil)),
             Token<BodySymbol>(source: "6.Обслуживание кассовой программы Айко\t8.435\t\t",
                               symbol: .item(itemNumber: 6, title: "Обслуживание кассовой программы Айко", value: 8_435, note: nil)),
             Token<BodySymbol>(source: "8.Обслуживание мобильного приложения\t9.200\t\t",
                               symbol: .item(itemNumber: 8, title: "Обслуживание мобильного приложения", value: 9_200, note: nil)),
             Token<BodySymbol>(source: "9.Реклама и IT поддержка\t85.000\t\t",
                               symbol: .item(itemNumber: 9, title: "Реклама и IT поддержка", value: 85_000, note: nil)),
             Token<BodySymbol>(source: "14. Вышивка логотипа на одежде\t2.836\t\t",
                               symbol: .item(itemNumber: 14, title: "Вышивка логотипа на одежде", value: 2_836, note: nil)),
             Token<BodySymbol>(source: "15.Аренда зарядных устройств и раций\t10.000\t\t",
                               symbol: .item(itemNumber: 15, title: "Аренда зарядных устройств и раций", value: 10_000, note: nil)),
             Token<BodySymbol>(source: "16. Текущие мелкие расходы \t5.460\t\t",
                               symbol: .item(itemNumber: 16, title: "Текущие мелкие расходы", value: 5_460, note: nil)),
             Token<BodySymbol>(source: "18. Аренда оборудования д/питьевой воды\t5.130\t\t",
                               symbol: .item(itemNumber: 18, title: "Аренда оборудования д/питьевой воды", value: 5_130, note: nil)),
             Token<BodySymbol>(source: "19. Ремонт оборудования\t6.610\t\t",
                               symbol: .item(itemNumber: 19, title: "Ремонт оборудования", value: 6_610, note: nil)),
             Token<BodySymbol>(source: "20. Чистка вентиляции\t35.000\t\t",
                               symbol: .item(itemNumber: 20, title: "Чистка вентиляции", value: 35_000, note: nil)),
             Token<BodySymbol>(source: "21. Обслуживание банкетов\t5.625\t\t",
                               symbol: .item(itemNumber: 21, title: "Обслуживание банкетов", value: 5_625, note: nil)),
             Token<BodySymbol>(source: "22. Хэдхантер (подбор пероснала)\t4.227\t\t",
                               symbol: .item(itemNumber: 22, title: "Хэдхантер (подбор пероснала)", value: 4_227, note: nil)),
             Token<BodySymbol>(source: "23. Аудит кантора (Бухуслуги)\t60.000\t\t",
                               symbol: .item(itemNumber: 23, title: "Аудит кантора (Бухуслуги)", value: 60_000, note: nil)),
             Token<BodySymbol>(source: "ИТОГ:\t350.700\t\t",
                               symbol: .footer(title: "ИТОГ:", value: 350_700))
            ],
            [Token<BodySymbol>(source: "Расходы на доставку:\t\t\t",
                               symbol: .header(title: "Расходы на доставку", plan: nil, fact: nil)),
             Token<BodySymbol>(source: "2. Агрегаторы\t21.541\t\t",
                               symbol: .item(itemNumber: 2, title: "Агрегаторы", value: 21_541, note: nil)),
             Token<BodySymbol>(source: "ИТОГ:\t21.541\t\t",
                               symbol: .footer(title: "ИТОГ:", value: 21_541)),
            ]
        ],

        footer: [Token<FooterSymbol>(source: "ИТОГ всех расходов за месяц:\t2.865.042р 74к",
                                     symbol: .totalExpenses(title: "ИТОГ всех расходов за месяц", value: 2_865_042.74)),
                 Token<FooterSymbol>(source: "Фактический остаток:\tМинус 277.306р 74к\t20%",
                                     symbol: .balance(title: "Фактический остаток", value: -277_306.74, percentage: 0.2)),
                 Token<FooterSymbol>(source: "Переходит минус с сентября 642.997р 43к",
                                     symbol: .openingBalance(title: "Переходит минус с сентября 642.997р 43к", value: -642_997.43)),
                 Token<FooterSymbol>(source: "ИТОГ:\tМинус 920.304р 17к",
                                     symbol: .runningBalance(title: "ИТОГ", value: -920_304.17)),
        ]
    )

}
