//
//  saperavi_2020_06.swift
//  UsingTengizReportSPTests
//
//  Created by Igor Malyarov on 14.02.2021.
//

@testable import Model

extension TokenizedReport {
    static let saperavi_2020_06 = TokenizedReport(
        header: [
            Token<HeaderSymbol>(
                source: "Название объекта: Саперави Аминьевка",
                symbol: .company(name: "Саперави Аминьевка")),
            Token<HeaderSymbol>(
                source: "Месяц: июнь2020 (с 24 по 30 июня)",
                symbol: .month(monthStr: "июнь2020 (с 24 по 30 июня)")),
            Token<HeaderSymbol>(
                source: "Оборот:266.285",
                symbol: .revenue(266_285)),
            Token<HeaderSymbol>(
                source: "Средний показатель: 38.040",
                symbol: .dailyAverage(38_040))],

        body: [
            [Token<BodySymbol>(source: "Основные расходы:\t\t25%\t",
                               symbol: BodySymbol.header(title: "Основные расходы", plan: 0.25, fact: nil)),
             Token<BodySymbol>(source: "5. Аренда головного офиса\t11.500\t\t",
                               symbol: BodySymbol.item(itemNumber: 5, title: "Аренда головного офиса", value: 11_500, note: nil)),
             Token<BodySymbol>(source: "ИТОГ:\t11.500\t\t",
                               symbol: BodySymbol.footer(title: "ИТОГ:", value: 11_500))],
            [Token<BodySymbol>(source: "Зарплата:\t\t22%\t",
                               symbol: BodySymbol.header(title: "Зарплата", plan: 0.22, fact: nil)),
             Token<BodySymbol>(source: "1.ФОТ\t19.721 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)\t\t",
                               symbol: BodySymbol.item(itemNumber: 1, title: "ФОТ", value: 19_721, note: "( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)")),
             Token<BodySymbol>(source: "ИТОГ:\t19.721\t\t",
                               symbol: BodySymbol.footer(title: "ИТОГ:", value: 19_721.0))],
            [Token<BodySymbol>(source: "Фактический приход товара и оплата товара:\t\t25%\t",
                               symbol: BodySymbol.header(title: "Фактический приход товара и оплата товара", plan: 0.25, fact:
                                                            nil)),
             Token<BodySymbol>(source: "1. Приход товара по накладным\t451.198р41к (из них у нас оплачено фактический 21.346р15к)\t\t",
                               symbol: BodySymbol.item(itemNumber: 1, title: "Приход товара по накладным", value: 21_346.15, note: "451.198р41к (из них у нас оплачено фактический 21.346р15к)")),
             Token<BodySymbol>(source: "2. Предоплаченный товар, но не отраженный в приходе\t15.800\t\t",
                               symbol: BodySymbol.item(itemNumber: 2, title: "Предоплаченный товар, но не отраженный в приходе", value: 15_800, note: nil)),
             Token<BodySymbol>(source: "ИТОГ:\t37.146р15к\t\t",
                               symbol: BodySymbol.footer(title: "ИТОГ:", value: 37_146.15))],
            [Token<BodySymbol>(source: "Прочие расходы:\t\t8%\t",
                               symbol: BodySymbol.header(title: "Прочие расходы", plan: 0.08, fact: nil)),
             Token<BodySymbol>(source: "2.Банковское обслуживание\t4.544\t\t",
                               symbol: BodySymbol.item(itemNumber: 2, title: "Банковское обслуживание", value: 4_544, note: nil)),
             Token<BodySymbol>(source: "4.Банковская комиссия 1.6% за эквайринг\t2.120\t\t",
                               symbol: BodySymbol.item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", value: 2_120, note: nil)),
             Token<BodySymbol>(source: "9. Реклама и IT поддержка\t16.300\t\t",
                               symbol: BodySymbol.item(itemNumber: 9, title: "Реклама и IT поддержка", value: 16_300, note: nil)),
             Token<BodySymbol>(source: "16. Текущие мелкие расходы \t1.200\t\t",
                               symbol: BodySymbol.item(itemNumber: 16, title: "Текущие мелкие расходы", value: 1_200, note: nil)),
             Token<BodySymbol>(source: "ИТОГ:\t24.164\t\t",
                               symbol: BodySymbol.footer(title: "ИТОГ:", value: 24_164.0))],
            [Token<BodySymbol>(source: "Расходы на доставку:\t\t\t",
                               symbol: BodySymbol.header(title: "Расходы на доставку", plan: nil, fact: nil))]
        ],

        footer: [
            Token<FooterSymbol>(
                source: "ИТОГ всех расходов за месяц:\t92.531р15к",
                symbol: FooterSymbol.totalExpenses(title: "ИТОГ всех расходов за месяц", value: 92531.15)),
            Token<FooterSymbol>(
                source: "Фактический остаток:\t173.753 \t20%",
                symbol: FooterSymbol.balance(title: "Фактический остаток", value: 173_753, percentage: 0.2))]
    )
}

