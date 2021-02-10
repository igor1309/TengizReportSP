//
//  Саперави 10 2020.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 09.02.2021.
//

import XCTest
@testable import TengizReportSP

extension TokenizedReportTests {
    func test_init_Saperavi_10_2020() throws {
        let sample = TokenizedReport(
            header: [Token<HeaderSymbol>(source: "Название объекта: Саперави Аминьевка",
                                         symbol: .company(name: "Саперави Аминьевка")),
                     Token<HeaderSymbol>(source: "Октябрь2020",
                                         symbol: .month(monthStr: "Октябрь2020")),
                     Token<HeaderSymbol>(source: "Оборот:2.587.735",
                                         symbol: .revenue(2_587_735)),
                     Token<HeaderSymbol>(source: "Средний показатель: 83.475",
                                         symbol: .dailyAverage(83_475))]
            ,
            body: [
                [Token<BodySymbol>(source: "Основные расходы:\t\t20%",
                                   symbol: .header(title: "Основные расходы", plan: 0.2, fact: nil)),
                 Token<BodySymbol>(source: "1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)",
                                   symbol: .item(itemNumber: 1, title: "Аренда торгового помещения", value: 600_000, comment: Optional("200.000 (за август) +400.000 (за сентябрь)"))),
                 Token<BodySymbol>(source: "2. Эксплуатационные расходы\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "3. Электричество\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "4. Водоснабжение\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "5. Аренда головного офиса\t11.500",
                                   symbol: .item(itemNumber: 5, title: "Аренда головного офиса", value: 11_500, comment: nil)),
                 Token<BodySymbol>(source: "6. Аренда головного склада\t7.000",
                                   symbol: .item(itemNumber: 6, title: "Аренда головного склада", value: 7_000, comment: nil)),
                 Token<BodySymbol>(source: "7. Вывоз мусора\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "ИТОГ:\t618.500",
                                   symbol: .footer(title: "ИТОГ:", value: 618_500))],
                [Token<BodySymbol>(source: "Зарплата:\t\t20%",
                                   symbol: .header(title: "Зарплата", plan: 0.2, fact: nil)),
                 Token<BodySymbol>(source: "1.ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)",
                                   symbol: .item(itemNumber: 1, title: "ФОТ", value: 1_147_085, comment: Optional("( за вторую часть сентября и первую  часть октября)"))),
                 Token<BodySymbol>(source: "2. ФОТ Бренд, логистика, бухгалтерия\t99.000",
                                   symbol: .item(itemNumber: 2, title: "ФОТ Бренд, логистика, бухгалтерия", value: 99_000, comment: nil)),
                 Token<BodySymbol>(source: "ИТОГ:\t1.246.085",
                                   symbol: .footer(title: "ИТОГ:", value: 1_246__085))],
                [Token<BodySymbol>(source: "Фактический приход товара и оплата товара:\t\t25%",
                                   symbol: .header(title: "Фактический приход товара и оплата товара", plan: 0.25, fact: nil)),
                 Token<BodySymbol>(source: "1. Приход товара по накладным\t 907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)",
                                   symbol: .item(itemNumber: 1, title: "Приход товара по накладным", value: 628_215.74, comment: Optional("907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)"))),
                 Token<BodySymbol>(source: "2. Предоплаченный товар, но не отраженный в приходе",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "ИТОГ:\t628.215р 74к",
                                   symbol: .footer(title: "ИТОГ:", value: 628215.74))],
                [Token<BodySymbol>(source: "Прочие расходы:\t\t15%",
                                   symbol: .header(title: "Прочие расходы", plan: 0.15, fact: nil)),
                 Token<BodySymbol>(source: "1.Налоговые платежи \t35.311",
                                   symbol: .item(itemNumber: 1, title: "Налоговые платежи", value: 35_311, comment: nil)),
                 Token<BodySymbol>(source: "2.Банковское обслуживание\t6.279",
                                   symbol: .item(itemNumber: 2, title: "Банковское обслуживание", value: 6_279, comment: nil)),
                 Token<BodySymbol>(source: "3.Юридическое сопровождение\t40.000",
                                   symbol: .item(itemNumber: 3, title: "Юридическое сопровождение", value: 40_000, comment: nil)),
                 Token<BodySymbol>(source: "4.Банковская комиссия 1.6% за эквайринг\t31.587",
                                   symbol: .item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", value: 31_587, comment: nil)),
                 Token<BodySymbol>(source: "5.Тайный гость\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "6.Обслуживание кассовой программы Айко\t8.435",
                                   symbol: .item(itemNumber: 6, title: "Обслуживание кассовой программы Айко", value: 8_435, comment: nil)),
                 Token<BodySymbol>(source: "7.Обслуживание хостинга\t----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "8.Обслуживание мобильного приложения\t9.200",
                                   symbol: .item(itemNumber: 8, title: "Обслуживание мобильного приложения", value: 9_200, comment: nil)),
                 Token<BodySymbol>(source: "9.Реклама и IT поддержка\t85.000",
                                   symbol: .item(itemNumber: 9, title: "Реклама и IT поддержка", value: 85_000, comment: nil)),
                 Token<BodySymbol>(source: "10.Обслуживание пожарной охраны\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "11.Вневедомственная охрана помещения\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "12.Интернет\t----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "13.Дезобработка помещения\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "14. Вышивка логотипа на одежде\t2.836",
                                   symbol: .item(itemNumber: 14, title: "Вышивка логотипа на одежде", value: 2_836, comment: nil)),
                 Token<BodySymbol>(source: "15.Аренда зарядных устройств и раций\t10.000",
                                   symbol: .item(itemNumber: 15, title: "Аренда зарядных устройств и раций", value: 10_000, comment: nil)),
                 Token<BodySymbol>(source: "16. Текущие мелкие расходы \t5.460",
                                   symbol: .item(itemNumber: 16, title: "Текущие мелкие расходы", value: 5_460, comment: nil)),
                 Token<BodySymbol>(source: "17. Обслуживание Жироуловителей\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "18. Аренда оборудования д/питьевой воды\t5.130",
                                   symbol: .item(itemNumber: 18, title: "Аренда оборудования д/питьевой воды", value: 5_130, comment: nil)),
                 Token<BodySymbol>(source: "19. Ремонт оборудования\t6.610",
                                   symbol: .item(itemNumber: 19, title: "Ремонт оборудования", value: 6_610, comment: nil)),
                 Token<BodySymbol>(source: "20. Чистка вентиляции\t35.000",
                                   symbol: .item(itemNumber: 20, title: "Чистка вентиляции", value: 35_000, comment: nil)),
                 Token<BodySymbol>(source: "21. Обслуживание банкетов\t5.625",
                                   symbol: .item(itemNumber: 21, title: "Обслуживание банкетов", value: 5_625, comment: nil)),
                 Token<BodySymbol>(source: "22. Хэдхантер (подбор пероснала)\t4.227",
                                   symbol: .item(itemNumber: 22, title: "Хэдхантер (подбор пероснала)", value: 4_227, comment: nil)),
                 Token<BodySymbol>(source: "23. Аудит кантора (Бухуслуги)\t60.000",
                                   symbol: .item(itemNumber: 23, title: "Аудит кантора (Бухуслуги)", value: 60_000, comment: nil)),
                 Token<BodySymbol>(source: "24. ---------\t-------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "25. --------\t-------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "26. ---------\t-------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "27. ---------\t------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "ИТОГ:\t350.700",
                                   symbol: .footer(title: "ИТОГ:", value: 350_700))],
                [Token<BodySymbol>(source: "Расходы на доставку:",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "1. Курьеры\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "2. Агрегаторы\t21.541",
                                   symbol: .item(itemNumber: 2, title: "Агрегаторы", value: 21_541, comment: nil)),
                 Token<BodySymbol>(source: "ИТОГ:\t21.541",
                                   symbol: .footer(title: "ИТОГ:", value: 21_541))]
            ],
            footer: [Token<FooterSymbol>(source: "ИТОГ всех расходов за месяц:\t2.865.042р 74к",
                                         symbol: .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 286_5042.74)),
                     Token<FooterSymbol>(source: "Фактический остаток:\tМинус 277.306р 74к\t20%",
                                         symbol: .balance(title: "Фактический остаток", value: -277306.74, percentage: 0.2)),
                     Token<FooterSymbol>(source: "Переходит минус с сентября 642.997р 43к",
                                         symbol: .openingBalance(title: "Переходит минус с сентября 642.997р 43к", value: -642_997.43)),
                     Token<FooterSymbol>(source: "ИТОГ:\tМинус 920.304р 17к",
                                         symbol: .runningBalance(title: "ИТОГ", value: -920_304.17))]

        )

        let contents = try filenames[4].contentsOfFile().clearReport()
        let reportContent = ReportContent(stringLiteral: contents)
        XCTAssertNotEqual(reportContent.footer, [])

        let report = TokenizedReport(stringLiteral: contents)
        XCTAssertEqual(report, sample)

        // header
        XCTAssertEqual(report.header, sample.header)
        XCTAssertEqual(report.header.count, sample.header.count)
        zip(report.header, sample.header).forEach { XCTAssertEqual($0, $1) }

        // body
        XCTAssertEqual(report.body, sample.body)
        XCTAssertEqual(report.body.count, sample.body.count)

        zip(report.body, sample.body).forEach { group, sample in
            XCTAssertEqual(group, sample)
            XCTAssertEqual(group.count, sample.count)

            zip(group, sample).forEach { token, sample in
                XCTAssertEqual(token, sample)
                XCTAssertEqual(token.source, sample.source)
                XCTAssertEqual(token.symbol, sample.symbol)
            }
        }

        // footer
        XCTAssertEqual(report.footer, sample.footer)
        XCTAssertEqual(report.footer.count, sample.footer.count)
        // XCTAssertNil(report.footer)
        zip(report.footer, sample.footer).forEach { XCTAssertEqual($0, $1) }
    }

}
