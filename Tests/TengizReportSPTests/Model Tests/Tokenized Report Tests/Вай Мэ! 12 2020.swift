//
//  Вай Мэ! 12 2020.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 09.02.2021.
//

import XCTest
@testable import TengizReportSP

extension TokenizedReportTests {
    func test_init_VaiMe_12_2020() throws {
        let sample = TokenizedReport(
            header: [
                Token<HeaderSymbol>(source: "Название объекта: Вай Мэ! Щелково",
                                    symbol: .company(name: "Вай Мэ! Щелково")),
                Token<HeaderSymbol>(source: "Декабрь2020",
                                    symbol: .month(monthStr: "Декабрь2020")),
                Token<HeaderSymbol>(source: "Оборот факт:929.625",
                                    symbol: .revenue(929_625)),
                Token<HeaderSymbol>(source: "Средний показатель:29.987",
                                    symbol: .dailyAverage(29_987))],
            body: [
                [Token<BodySymbol>(source: "Основные расходы:\t-----------------------------\t25%",
                                   symbol: .header(title: "Основные расходы", plan: 0.25, fact: nil)),
                 Token<BodySymbol>(source: "1. Аренда торгового помещения\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "2. Эксплуатационные расходы\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "3. Электричество\t------------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "4. Водоснабжение\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "5. Аренда головного офиса\t11.500",
                                   symbol: .item(itemNumber: 5, title: "Аренда головного офиса", value: 11_500, note: nil)),
                 Token<BodySymbol>(source: "6. Аренда головного склада\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "7.Вывоз мусора\t18.000",
                                   symbol: .item(itemNumber: 7, title: "Вывоз мусора", value: 18_000, note: nil)),
                 Token<BodySymbol>(source: "ИТОГ:\t29.500",
                                   symbol: .footer(title: "ИТОГ:", value: 29_500))],
                [Token<BodySymbol>(source: "Зарплата:\t-----------------------------\t20%",
                                   symbol: .header(title: "Зарплата", plan: 0.2, fact: nil)),
                 Token<BodySymbol>(source: "1.ФОТ общий\t261.978",
                                   symbol: .item(itemNumber: 1, title: "ФОТ общий", value: 261_978, note: nil)),
                 Token<BodySymbol>(source: "2. ФОТ Бренд, логистика, бухгалтерия\t90.000",
                                   symbol: .item(itemNumber: 2, title: "ФОТ Бренд, логистика, бухгалтерия", value: 90_000, note: nil)),
                 Token<BodySymbol>(source: "----------------------------------------------------------------------\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "ИТОГ:\t351.978",
                                   symbol: .footer(title: "ИТОГ:", value: 351_978))],
                [Token<BodySymbol>(source: "Фактический приход товара и оплата товара:\t-----------------------------\t30%",
                                   symbol: .header(title: "Фактический приход товара и оплата товара", plan: 0.3, fact: nil)),
                 Token<BodySymbol>(source: "1. Приход товара по накладным\t473.128р43к(оплаты фактические:231.572р46к-переводы;51.104р93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р39к)",
                                   symbol: .item(itemNumber: 1, title: "Приход товара по накладным", value: 285_476.39, note: Optional("473.128р43к(оплаты фактические:231.572р46к-переводы;51.104р93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р39к)"))),
                 Token<BodySymbol>(source: "ИТОГ:\t285.476р39к",
                                   symbol: .footer(title: "ИТОГ:", value: 285_476.39))],
                [Token<BodySymbol>(source: "Прочие расходы:\t\t8%",
                                   symbol: .header(title: "Прочие расходы", plan: 0.08, fact: nil)),
                 Token<BodySymbol>(source: "1.Налоговые платежи \t22.282р86к",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "2.Банковское обслуживание\t2.344р29к",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "3.--------------------------------------\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "4.Банковская комиссия 1.6% за эквайринг\t12.111",
                                   symbol: .item(itemNumber: 4, title: "Банковская комиссия 1.6% за эквайринг", value: 12_111, note: nil)),
                 Token<BodySymbol>(source: "5.Юридическое сопровождение\t40.000",
                                   symbol: .item(itemNumber: 5, title: "Юридическое сопровождение", value: 40_000, note: nil)),
                 Token<BodySymbol>(source: "6.Обслуживание кассовой программы\t15.995",
                                   symbol: .item(itemNumber: 6, title: "Обслуживание кассовой программы", value: 15_995, note: nil)),
                 Token<BodySymbol>(source: "7. Обслуживание хостинга\t2.500",
                                   symbol: .item(itemNumber: 7, title: "Обслуживание хостинга", value: 2_500, note: nil)),
                 Token<BodySymbol>(source: "8.Аудит Кантора (бухуслуги)\t60.000",
                                   symbol: .item(itemNumber: 8, title: "Аудит Кантора (бухуслуги)", value: 60_000, note: nil)),
                 Token<BodySymbol>(source: "9. Реклама и IT поддержка\t59.200",
                                   symbol: .item(itemNumber: 9, title: "Реклама и IT поддержка", value: 59_200, note: nil)),
                 Token<BodySymbol>(source: "10.-----------------------\t----------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "11. -----------------------\t-----------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "12.Интернет\t3.500",
                                   symbol: .item(itemNumber: 12, title: "Интернет", value: 3_500, note: nil)),
                 Token<BodySymbol>(source: "13.Дезобработка помещения\t---------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "14.Ремонт оборудования\t--------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "15.Ремонт и чистка вентиляции\t15.000",
                                   symbol: .item(itemNumber: 15, title: "Ремонт и чистка вентиляции", value: 15_000, note: nil)),
                 Token<BodySymbol>(source: "16. Текущие мелкие расходы\t1.400",
                                   symbol: .item(itemNumber: 16, title: "Текущие мелкие расходы", value: 1_400, note: nil)),
                 Token<BodySymbol>(source: "17. Чистка жироуловителей и канализации\t10.139",
                                   symbol: .item(itemNumber: 17, title: "Чистка жироуловителей и канализации", value: 10_139, note: nil)),
                 Token<BodySymbol>(source: "18. Маркетинговый платеж\t--------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "19. ----------------------\t-----------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "20. ----------------------\t----------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "21. -----------------------\t---------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "ИТОГ:\t244.472р15к",
                                   symbol: .footer(title: "ИТОГ:", value: 244472.15))],
                [Token<BodySymbol>(source: "Расходы на доставку:\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "1. Курьеры\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "2. Агрегаторы\t9.528",
                                   symbol: .item(itemNumber: 2, title: "Агрегаторы", value: 9_528, note: nil)),
                 Token<BodySymbol>(source: "ИТОГ:\t9.528",
                                   symbol: .footer(title: "ИТОГ:", value: 9_528))]
            ],
            footer: [

                Token<FooterSymbol>(source: "ИТОГ всех расходов за месяц:\t920.954р54к",
                                    symbol: .totalExpenses(title: "ИТОГ всех расходов за месяц", value: 920_954.54)),
                Token<FooterSymbol>(source: "Фактический остаток:\t8.670р46к",
                                    symbol: .balance(title: "Фактический остаток", value: 8_670.46, percentage: nil)),
                Token<FooterSymbol>(source: "Остаток с ноября \t684.753р85к",
                                    symbol: .openingBalance(title: "Остаток с ноября \t684.753р85к", value: 684_753.85)),
                Token<FooterSymbol>(source: "ИТОГ:\t693.424р31к переносим на январь",
                                    symbol: .runningBalance(title: "ИТОГ", value: 693_424.31))]

        )

        let contents = try filenames[8].contentsOfFile()
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
