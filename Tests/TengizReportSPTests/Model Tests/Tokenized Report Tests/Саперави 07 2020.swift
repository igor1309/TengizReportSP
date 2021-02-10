//
//  Саперави 07 2020.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 09.02.2021.
//

import XCTest
@testable import TengizReportSP

extension TokenizedReportTests {
    func test_init_Saperavi_07_2020() throws {
        let sample = TokenizedReport(
            header: [
                Token<HeaderSymbol>(source: "Название объекта: Саперави Аминьевка",
                                    symbol: .company(name: "Саперави Аминьевка")),
                Token<HeaderSymbol>(source: "Месяц: июль2020",
                                    symbol: .month(monthStr: "июль2020")),
                Token<HeaderSymbol>(source: "Оборот:1.067.807",
                                    symbol: .revenue(1_067_807)),
                Token<HeaderSymbol>(source: "Средний показатель: 34.445",
                                    symbol: .dailyAverage(34_445))],
            body: [
                [Token<BodySymbol>(source: "Основные расходы:\t\t25%",
                                   symbol: .header(title: "Основные расходы", plan: 0.25, fact: nil)),
                 Token<BodySymbol>(source: "1. Аренда торгового помещения\t46.667 (за июнь)",
                                   symbol: .item(title: "1. Аренда торгового помещения", value: 46_667, comment: "(за июнь)")),
                 Token<BodySymbol>(source: "2. Эксплуатационные расходы\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "3. Электричество\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "4. Водоснабжение\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "5. Аренда головного офиса\t11.500",
                                   symbol: .item(title: "5. Аренда головного офиса", value: 11_500, comment: nil)),
                 Token<BodySymbol>(source: "6. Аренда головного склада\t7.000",
                                   symbol: .item(title: "6. Аренда головного склада", value: 7_000, comment: nil)),
                 Token<BodySymbol>(source: "7. Вывоз мусора\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "ИТОГ:\t65.167",
                                   symbol: .footer(title: "ИТОГ:", value: 65_167))],
                [Token<BodySymbol>(source: "Зарплата:\t\t22%",
                                   symbol: .header(title: "Зарплата", plan: 0.22, fact: nil)),
                 Token<BodySymbol>(source: "1.ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)",
                                   symbol: .item(title: "1.ФОТ", value: 704_848, comment: "( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)")),
                 Token<BodySymbol>(source: "2. ФОТ Бренд, логистика, бухгалтерия\t99.000",
                                   symbol: .item(title: "2. ФОТ Бренд, логистика, бухгалтерия", value: 99_000, comment: nil)),
                 //                 Token<BodySymbol>(source: "",
                 //                                   symbol: .empty),
                 Token<BodySymbol>(source: "ИТОГ:\t803.848",
                                   symbol: .footer(title: "ИТОГ:", value: 803_848))],
                [Token<BodySymbol>(source: "Фактический приход товара и оплата товара:\t\t25%",
                                   symbol: .header(title: "Фактический приход товара и оплата товара", plan: 0.25, fact: nil)),
                 Token<BodySymbol>(source: "1. Приход товара по накладным\t922.936р37к (оплаты фактические: 313.570р26к-переводы; 87.091р20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р46к)",
                                   symbol: .item(title: "1. Приход товара по накладным", value: 498_373.46, comment: "922.936р37к (оплаты фактические: 313.570р26к-переводы; 87.091р20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р46к)")),
                 Token<BodySymbol>(source: "2. Предоплаченный товар, но не отраженный в приходе\tБейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400",
                                   symbol: .item(title: "2. Предоплаченный товар, но не отраженный в приходе", value: 40_400, comment: "Бейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400")),
                 Token<BodySymbol>(source: "ИТОГ:\t538.773р46к",
                                   symbol: .footer(title: "ИТОГ:", value: 538_773.46))],
                [Token<BodySymbol>(source: "Прочие расходы:\t\t8%",
                                   symbol: .header(title: "Прочие расходы", plan: 0.08, fact: nil)),
                 Token<BodySymbol>(source: "1.Налоговые платежи \t13.318р93к",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "2.Банковское обслуживание\t5.778",
                                   symbol: .item(title: "2.Банковское обслуживание", value: 5_778, comment: nil)),
                 Token<BodySymbol>(source: "3.Юридическое сопровождение\t20.000",
                                   symbol: .item(title: "3.Юридическое сопровождение", value: 20_000, comment: nil)),
                 Token<BodySymbol>(source: "4.Банковская комиссия 1.6% за эквайринг\t12.785",
                                   symbol: .item(title: "4.Банковская комиссия 1.6% за эквайринг", value: 12_785, comment: nil)),
                 Token<BodySymbol>(source: "5. Тайный гость\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "6.Обслуживание кассовой программы\t21.806р20к",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "7. Обслуживание хостинга\t----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "8.Обслуживание мобильного приложения\t----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "9. Реклама и IT поддержка\t104.000",
                                   symbol: .item(title: "9. Реклама и IT поддержка", value: 104_000, comment: nil)),
                 Token<BodySymbol>(source: "10.Обслуживание пожарной охраны\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "11.Вневедомственная охрана помещения\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "12.Интернет\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "13.Дезобработка помещения\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "14. Контур (эл.отчетность)\t3.000",
                                   symbol: .item(title: "14. Контур (эл.отчетность)", value: 3_000, comment: nil)),
                 Token<BodySymbol>(source: "15.Аренда зарядных устройств и раций\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "16. Текущие мелкие расходы \t2.910",
                                   symbol: .item(title: "16. Текущие мелкие расходы", value: 2_910, comment: nil)),
                 Token<BodySymbol>(source: "17. Обслуживание Жироуловителей\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "18. Регистрация Кассового аппарата (запасной)\t2.000",
                                   symbol: .item(title: "18. Регистрация Кассового аппарата (запасной)", value: 2_000, comment: nil)),
                 Token<BodySymbol>(source: "19. Ремонт оборудования\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "20. Чистка вентиляции\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "21. Обслуживание банкетов\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "22. Хэдхантер (подбор пероснала)\t3.240",
                                   symbol: .item(title: "22. Хэдхантер (подбор пероснала)", value: 3_240, comment: nil)),
                 Token<BodySymbol>(source: "23. Аудит кантора (Бухуслуги)\t60.000",
                                   symbol: .item(title: "23. Аудит кантора (Бухуслуги)", value: 60_000, comment: nil)),
                 Token<BodySymbol>(source: "24. Столы Тенгиза\t6.100",
                                   symbol: .item(title: "24. Столы Тенгиза", value: 6_100, comment: nil)),
                 Token<BodySymbol>(source: "25. Стол Игорь\t5.470",
                                   symbol: .item(title: "25. Стол Игорь", value: 5_470, comment: nil)),
                 Token<BodySymbol>(source: "26. Вино отправляли в подарок\t1.900",
                                   symbol: .item(title: "26. Вино отправляли в подарок", value: 1_900, comment: nil)),
                 Token<BodySymbol>(source: "ИТОГ:\t262.308",
                                   symbol: .footer(title: "ИТОГ:", value: 262_308))],
                [Token<BodySymbol>(source: "Расходы на доставку:",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "1. Курьеры\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "2. Агрегаторы\t6.981",
                                   symbol: .item(title: "2. Агрегаторы", value: 6_981, comment: nil)),
                 Token<BodySymbol>(source: "ИТОГ:\t6.981",
                                   symbol: .footer(title: "ИТОГ:", value: 6_981)),]
            ],
            footer: [
                Token<FooterSymbol>(source: "ИТОГ всех расходов за месяц:\t1.677.077р46к",
                                    symbol: .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 1_677_077.46)),
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

        let contents = try filenames[1].contentsOfFile().clearReport()
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
