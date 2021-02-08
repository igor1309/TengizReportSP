//
//  TokenizedReportTests.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 08.02.2021.
//

import XCTest
@testable import TengizReportSP

final class TokenizedReportTests: XCTestCase {
    func test_init_dummy() {
        XCTAssertNotNil(TokenizedReport(header: [], body: [], footer: []))
        XCTAssertNotNil(TokenizedReport(""))
        XCTAssertNotNil(TokenizedReport(stringLiteral: ""))
    }

    func test_init_Saperavi_07_2020() throws {
        let sample = TokenizedReport(
            header: [
                Token<HeaderSymbol>(source: "Название объекта: Саперави Аминьевка",
                                    symbol: HeaderSymbol.company(name: "Саперави Аминьевка")),
                Token<HeaderSymbol>(source: "Месяц: июль2020",
                                    symbol: HeaderSymbol.month(monthStr: "июль2020")),
                Token<HeaderSymbol>(source: "Оборот:1.067.807",
                                    symbol: HeaderSymbol.revenue(1_067_807)),
                Token<HeaderSymbol>(source: "Средний показатель: 34.445",
                                    symbol: HeaderSymbol.dailyAverage(34_445))],
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
                                   symbol: .empty)],
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

        XCTAssertEqual(report.header, sample.header)

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
        zip(report.footer, sample.footer).forEach { reportFooter, sampleFooter in
            XCTAssertEqual(reportFooter, sampleFooter)
        }
    }

    func test_init_Saperavi_09_2020() throws {
        let sample = TokenizedReport(
            header: [Token<HeaderSymbol>(source: "Название объекта: Саперави Аминьевка",
                                         symbol: HeaderSymbol.company(name: "Саперави Аминьевка")),
                     Token<HeaderSymbol>(source: "Октябрь2020",
                                         symbol: HeaderSymbol.month(monthStr: "Октябрь2020")),
                     Token<HeaderSymbol>(source: "Оборот:2.587.735",
                                         symbol: HeaderSymbol.revenue(2_587_735)),
                     Token<HeaderSymbol>(source: "Средний показатель: 83.475",
                                         symbol: HeaderSymbol.dailyAverage(83_475))]
            ,
            body: [
                [Token<BodySymbol>(source: "Основные расходы:\t\t20%",
                                   symbol: .header(title: "Основные расходы", plan: 0.2, fact: nil)),
                 Token<BodySymbol>(source: "1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)",
                                   symbol: .item(title: "1. Аренда торгового помещения", value: 600_000, comment: Optional("200.000 (за август) +400.000 (за сентябрь)"))),
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
                 Token<BodySymbol>(source: "ИТОГ:\t618.500",
                                   symbol: .footer(title: "ИТОГ:", value: 618_500))],
                [Token<BodySymbol>(source: "Зарплата:\t\t20%",
                                   symbol: .header(title: "Зарплата", plan: 0.2, fact: nil)),
                 Token<BodySymbol>(source: "1.ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)",
                                   symbol: .item(title: "1.ФОТ", value: 1_147_085, comment: Optional("( за вторую часть сентября и первую  часть октября)"))),
                 Token<BodySymbol>(source: "2. ФОТ Бренд, логистика, бухгалтерия\t99.000",
                                   symbol: .item(title: "2. ФОТ Бренд, логистика, бухгалтерия", value: 99_000, comment: nil)),
                 Token<BodySymbol>(source: "ИТОГ:\t1.246.085",
                                   symbol: .footer(title: "ИТОГ:", value: 1_246__085))],
                [Token<BodySymbol>(source: "Фактический приход товара и оплата товара:\t\t25%",
                                   symbol: .header(title: "Фактический приход товара и оплата товара", plan: 0.25, fact: nil)),
                 Token<BodySymbol>(source: "1. Приход товара по накладным\t 907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)",
                                   symbol: .item(title: "1. Приход товара по накладным", value: 628_215.74, comment: Optional("907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)"))),
                 Token<BodySymbol>(source: "2. Предоплаченный товар, но не отраженный в приходе",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "ИТОГ:\t628.215р 74к",
                                   symbol: .footer(title: "ИТОГ:", value: 628215.74))],
                [Token<BodySymbol>(source: "Прочие расходы:\t\t15%",
                                   symbol: .header(title: "Прочие расходы", plan: 0.15, fact: nil)),
                 Token<BodySymbol>(source: "1.Налоговые платежи \t35.311",
                                   symbol: .item(title: "1.Налоговые платежи", value: 35_311, comment: nil)),
                 Token<BodySymbol>(source: "2.Банковское обслуживание\t6.279",
                                   symbol: .item(title: "2.Банковское обслуживание", value: 6_279, comment: nil)),
                 Token<BodySymbol>(source: "3.Юридическое сопровождение\t40.000",
                                   symbol: .item(title: "3.Юридическое сопровождение", value: 40_000, comment: nil)),
                 Token<BodySymbol>(source: "4.Банковская комиссия 1.6% за эквайринг\t31.587",
                                   symbol: .item(title: "4.Банковская комиссия 1.6% за эквайринг", value: 31_587, comment: nil)),
                 Token<BodySymbol>(source: "5.Тайный гость\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "6.Обслуживание кассовой программы Айко\t8.435",
                                   symbol: .item(title: "6.Обслуживание кассовой программы Айко", value: 8_435, comment: nil)),
                 Token<BodySymbol>(source: "7.Обслуживание хостинга\t----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "8.Обслуживание мобильного приложения\t9.200",
                                   symbol: .item(title: "8.Обслуживание мобильного приложения", value: 9_200, comment: nil)),
                 Token<BodySymbol>(source: "9.Реклама и IT поддержка\t85.000",
                                   symbol: .item(title: "9.Реклама и IT поддержка", value: 85_000, comment: nil)),
                 Token<BodySymbol>(source: "10.Обслуживание пожарной охраны\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "11.Вневедомственная охрана помещения\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "12.Интернет\t----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "13.Дезобработка помещения\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "14. Вышивка логотипа на одежде\t2.836",
                                   symbol: .item(title: "14. Вышивка логотипа на одежде", value: 2_836, comment: nil)),
                 Token<BodySymbol>(source: "15.Аренда зарядных устройств и раций\t10.000",
                                   symbol: .item(title: "15.Аренда зарядных устройств и раций", value: 10_000, comment: nil)),
                 Token<BodySymbol>(source: "16. Текущие мелкие расходы \t5.460",
                                   symbol: .item(title: "16. Текущие мелкие расходы", value: 5_460, comment: nil)),
                 Token<BodySymbol>(source: "17. Обслуживание Жироуловителей\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "18. Аренда оборудования д/питьевой воды\t5.130",
                                   symbol: .item(title: "18. Аренда оборудования д/питьевой воды", value: 5_130, comment: nil)),
                 Token<BodySymbol>(source: "19. Ремонт оборудования\t6.610",
                                   symbol: .item(title: "19. Ремонт оборудования", value: 6_610, comment: nil)),
                 Token<BodySymbol>(source: "20. Чистка вентиляции\t35.000",
                                   symbol: .item(title: "20. Чистка вентиляции", value: 35_000, comment: nil)),
                 Token<BodySymbol>(source: "21. Обслуживание банкетов\t5.625",
                                   symbol: .item(title: "21. Обслуживание банкетов", value: 5_625, comment: nil)),
                 Token<BodySymbol>(source: "22. Хэдхантер (подбор пероснала)\t4.227",
                                   symbol: .item(title: "22. Хэдхантер (подбор пероснала)", value: 4_227, comment: nil)),
                 Token<BodySymbol>(source: "23. Аудит кантора (Бухуслуги)\t60.000",
                                   symbol: .item(title: "23. Аудит кантора (Бухуслуги)", value: 60_000, comment: nil)),
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
                                   symbol: .item(title: "2. Агрегаторы", value: 21_541, comment: nil)),
                 Token<BodySymbol>(source: "ИТОГ:\t21.541",
                                   symbol: .footer(title: "ИТОГ:", value: 21_541))]
            ],
            footer: [Token<FooterSymbol>(source: "ИТОГ всех расходов за месяц:\t2.865.042р 74к",
                                         symbol: FooterSymbol.expensesTotal(title: "ИТОГ всех расходов за месяц", value: 286_5042.74)),
                     Token<FooterSymbol>(source: "Фактический остаток:\tМинус 277.306р 74к\t20%",
                                         symbol: FooterSymbol.balance(title: "Фактический остаток", value: -277306.74, percentage: 0.2)),
                     Token<FooterSymbol>(source: "Переходит минус с сентября 642.997р 43к",
                                         symbol: FooterSymbol.openingBalance(title: "Переходит минус с сентября 642.997р 43к", value: -642_997.43)),
                     Token<FooterSymbol>(source: "ИТОГ:\tМинус 920.304р 17к",
                                         symbol: FooterSymbol.runningBalance(title: "ИТОГ", value: -920_304.17))]

        )

        let contents = try filenames[4].contentsOfFile().clearReport()
        let reportContent = ReportContent(stringLiteral: contents)
        XCTAssertNotEqual(reportContent.footer, [])

        let report = TokenizedReport(stringLiteral: contents)
        XCTAssertEqual(report, sample)

        XCTAssertEqual(report.header, sample.header)

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
        zip(report.footer, sample.footer).forEach { reportFooter, sampleFooter in
            XCTAssertEqual(reportFooter, sampleFooter)
        }
    }

    func test_init_VaiMe_12_2020() throws {
        let sample = TokenizedReport(
            header: [
                Token<HeaderSymbol>(source: "Название объекта: Вай Мэ! Щелково",
                                    symbol: HeaderSymbol.company(name: "Вай Мэ! Щелково")),
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
                                   symbol: .item(title: "5. Аренда головного офиса", value: 11_500, comment: nil)),
                 Token<BodySymbol>(source: "6. Аренда головного склада\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "7.Вывоз мусора\t18.000",
                                   symbol: .item(title: "7.Вывоз мусора", value: 18_000, comment: nil)),
                 Token<BodySymbol>(source: "ИТОГ:\t29.500",
                                   symbol: .footer(title: "ИТОГ:", value: 29_500))],
                [Token<BodySymbol>(source: "Зарплата:\t-----------------------------\t20%",
                                   symbol: .header(title: "Зарплата", plan: 0.2, fact: nil)),
                 Token<BodySymbol>(source: "1.ФОТ общий\t261.978",
                                   symbol: .item(title: "1.ФОТ общий", value: 261_978, comment: nil)),
                 Token<BodySymbol>(source: "2. ФОТ Бренд, логистика, бухгалтерия\t90.000",
                                   symbol: .item(title: "2. ФОТ Бренд, логистика, бухгалтерия", value: 90_000, comment: nil)),
                 Token<BodySymbol>(source: "----------------------------------------------------------------------\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "ИТОГ:\t351.978",
                                   symbol: .footer(title: "ИТОГ:", value: 351_978))],
                [Token<BodySymbol>(source: "Фактический приход товара и оплата товара:\t-----------------------------\t30%",
                                   symbol: .header(title: "Фактический приход товара и оплата товара", plan: 0.3, fact: nil)),
                 Token<BodySymbol>(source: "1. Приход товара по накладным\t473.128р43к(оплаты фактические:231.572р46к-переводы;51.104р93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р39к)",
                                   symbol: .item(title: "1. Приход товара по накладным", value: 285_476.39, comment: Optional("473.128р43к(оплаты фактические:231.572р46к-переводы;51.104р93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р39к)"))),
                 Token<BodySymbol>(source: "ИТОГ:\t285.476р39к",
                                   symbol: .empty)],
                [Token<BodySymbol>(source: "Прочие расходы:\t\t8%",
                                   symbol: .header(title: "Прочие расходы", plan: 0.08, fact: nil)),
                 Token<BodySymbol>(source: "1.Налоговые платежи \t22.282р86к",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "2.Банковское обслуживание\t2.344р29к",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "3.--------------------------------------\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "4.Банковская комиссия 1.6% за эквайринг\t12.111",
                                   symbol: .item(title: "4.Банковская комиссия 1.6% за эквайринг", value: 12_111, comment: nil)),
                 Token<BodySymbol>(source: "5.Юридическое сопровождение\t40.000",
                                   symbol: .item(title: "5.Юридическое сопровождение", value: 40_000, comment: nil)),
                 Token<BodySymbol>(source: "6.Обслуживание кассовой программы\t15.995",
                                   symbol: .item(title: "6.Обслуживание кассовой программы", value: 15_995, comment: nil)),
                 Token<BodySymbol>(source: "7. Обслуживание хостинга\t2.500",
                                   symbol: .item(title: "7. Обслуживание хостинга", value: 2_500, comment: nil)),
                 Token<BodySymbol>(source: "8.Аудит Кантора (бухуслуги)\t60.000",
                                   symbol: .item(title: "8.Аудит Кантора (бухуслуги)", value: 60_000, comment: nil)),
                 Token<BodySymbol>(source: "9. Реклама и IT поддержка\t59.200",
                                   symbol: .item(title: "9. Реклама и IT поддержка", value: 59_200, comment: nil)),
                 Token<BodySymbol>(source: "10.-----------------------\t----------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "11. -----------------------\t-----------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "12.Интернет\t3.500",
                                   symbol: .item(title: "12.Интернет", value: 3_500, comment: nil)),
                 Token<BodySymbol>(source: "13.Дезобработка помещения\t---------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "14.Ремонт оборудования\t--------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "15.Ремонт и чистка вентиляции\t15.000",
                                   symbol: .item(title: "15.Ремонт и чистка вентиляции", value: 15_000, comment: nil)),
                 Token<BodySymbol>(source: "16. Текущие мелкие расходы\t1.400",
                                   symbol: .item(title: "16. Текущие мелкие расходы", value: 1_400, comment: nil)),
                 Token<BodySymbol>(source: "17. Чистка жироуловителей и канализации\t10.139",
                                   symbol: .item(title: "17. Чистка жироуловителей и канализации", value: 10_139, comment: nil)),
                 Token<BodySymbol>(source: "18. Маркетинговый платеж\t--------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "19. ----------------------\t-----------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "20. ----------------------\t----------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "21. -----------------------\t---------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "ИТОГ:\t244.472р15к",
                                   symbol: .empty)],
                [Token<BodySymbol>(source: "Расходы на доставку:\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "1. Курьеры\t-----------------------------",
                                   symbol: .empty),
                 Token<BodySymbol>(source: "2. Агрегаторы\t9.528",
                                   symbol: .item(title: "2. Агрегаторы", value: 9_528, comment: nil)),
                 Token<BodySymbol>(source: "ИТОГ:\t9.528",
                                   symbol: .footer(title: "ИТОГ:", value: 9_528))]
            ],
            footer: [

                Token<FooterSymbol>(source: "ИТОГ всех расходов за месяц:\t920.954р54к",
                                    symbol: .expensesTotal(title: "ИТОГ всех расходов за месяц", value: 920_954.54)),
                Token<FooterSymbol>(source: "Фактический остаток:\t8.670р46к",
                                    symbol: .balance(title: "Фактический остаток", value: 8_670.46, percentage: nil)),
                Token<FooterSymbol>(source: "Остаток с ноября \t684.753р85к",
                                    symbol: .openingBalance(title: "Остаток с ноября \t684.753р85к", value: 684_753.85)),
                Token<FooterSymbol>(source: "ИТОГ:\t693.424р31к переносим на январь",
                                    symbol: .runningBalance(title: "ИТОГ", value: 693_424.31))]

        )

        let contents = try filenames[8].contentsOfFile().clearReport()
        let reportContent = ReportContent(stringLiteral: contents)
        XCTAssertNotEqual(reportContent.footer, [])

        let report = TokenizedReport(stringLiteral: contents)
        XCTAssertEqual(report, sample)

        XCTAssertEqual(report.header, sample.header)

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
        zip(report.footer, sample.footer).forEach { reportFooter, sampleFooter in
            XCTAssertEqual(reportFooter, sampleFooter)
        }
    }
}
