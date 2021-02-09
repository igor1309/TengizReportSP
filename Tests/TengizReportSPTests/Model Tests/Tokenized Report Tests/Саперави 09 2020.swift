//
//  Саперави 09 2020.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 09.02.2021.
//

import XCTest
@testable import TengizReportSP

extension TokenizedReportTests {
    func test_init_Saperavi_09_2020() throws {
        let sample = TokenizedReport(
            header: [
                Token<HeaderSymbol>(source: "Название объекта: Саперави Аминьевка",
                                    symbol: HeaderSymbol.company(name: "Саперави Аминьевка")),
                Token<HeaderSymbol>(source: "Месяц: сентябрь2020",
                                    symbol: HeaderSymbol.month(monthStr: "сентябрь2020")),
                Token<HeaderSymbol>(source: "Оборот:2.440.021",
                                    symbol: HeaderSymbol.revenue(2_440_021)),
                Token<HeaderSymbol>(source: "Средний показатель: 81.334",
                                    symbol: HeaderSymbol.dailyAverage(81_334))]
            ,
            body: [
                [Token<BodySymbol>(source: "Основные расходы:\t\t20%\t8.95%",
                                   symbol: BodySymbol.header(title: "Основные расходы", plan: 0.2, fact: 0.0895)),
                 Token<BodySymbol>(source: "1. Аренда торгового помещения\t 200.000 (за август)",
                                   symbol: BodySymbol.item(title: "1. Аренда торгового помещения", value: 200_000, comment: "(за август)")),
                 Token<BodySymbol>(source: "2. Эксплуатационные расходы\t-----------------------------",
                                   symbol: BodySymbol.empty),
                 Token<BodySymbol>(source: "3. Электричество\t-----------------------------",
                                   symbol: BodySymbol.empty),
                 Token<BodySymbol>(source: "4. Водоснабжение\t-----------------------------",
                                   symbol: BodySymbol.empty),
                 Token<BodySymbol>(source: "5. Аренда головного офиса\t11.500",
                                   symbol: BodySymbol.item(title: "5. Аренда головного офиса", value: 11_500, comment: nil)),
                 Token<BodySymbol>(source: "6. Аренда головного склада\t7.000",
                                   symbol: BodySymbol.item(title: "6. Аренда головного склада", value: 7_000, comment: nil)),
                 Token<BodySymbol>(source: "7. Вывоз мусора\t-----------------------------",
                                   symbol: BodySymbol.empty),
                 Token<BodySymbol>(source: "ИТОГ:\t218.500",
                                   symbol: BodySymbol.footer(title: "ИТОГ:", value: 218_500))],
                [Token<BodySymbol>(source: "Зарплата:\t\t20%\t43.4%",
                                   symbol: BodySymbol.header(title: "Зарплата", plan: 0.2, fact: 0.434)),
                 Token<BodySymbol>(source: "1.ФОТ\t 960.056( за вторую часть августа и первую  часть сентября)",
                                   symbol: BodySymbol.item(title: "1.ФОТ", value: 960_056, comment: "( за вторую часть августа и первую  часть сентября)")),
                 Token<BodySymbol>(source: "2. ФОТ Бренд, логистика, бухгалтерия\t99.000",
                                   symbol: BodySymbol.item(title: "2. ФОТ Бренд, логистика, бухгалтерия", value: 99_000, comment: nil)),
                 Token<BodySymbol>(source: "ИТОГ:\t1.059.056",
                                   symbol: BodySymbol.footer(title: "ИТОГ:", value: 1_059_056))],
                [Token<BodySymbol>(source: "Фактический приход товара и оплата товара:\t946.056р\t25%",
                                   symbol: BodySymbol.header(title: "Фактический приход товара и оплата товара", plan: 0.25, fact: nil)),
                 Token<BodySymbol>(source: "1. Приход товара по накладным\t 946.056р (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)",
                                   symbol: BodySymbol.item(title: "1. Приход товара по накладным", value: 632684.37, comment: "946.056р (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)")),
                 Token<BodySymbol>(source: "2. Предоплаченный товар, но не отраженный в приходе\tСтудиопак Итого 12.500 (влажные салфетки);",
                                   symbol: BodySymbol.item(title: "2. Предоплаченный товар, но не отраженный в приходе", value: 12_500, comment: "Студиопак Итого 12.500 (влажные салфетки);")),
                 Token<BodySymbol>(source: "ИТОГ:\t645.184р37к",
                                   symbol: BodySymbol.footer(title: "ИТОГ:", value: 645184.37))],
                [Token<BodySymbol>(source: "Прочие расходы:\t\t15%\t16.5%",
                                   symbol: BodySymbol.header(title: "Прочие расходы", plan: 0.15, fact: 0.165)),
                 Token<BodySymbol>(source: "1.Налоговые платежи \t26.964",
                                   symbol: BodySymbol.item(title: "1.Налоговые платежи", value: 26_964, comment: nil)),
                 Token<BodySymbol>(source: "2.Банковское обслуживание\t6.419",
                                   symbol: BodySymbol.item(title: "2.Банковское обслуживание", value: 6_419, comment: nil)),
                 Token<BodySymbol>(source: "3.Юридическое сопровождение\t40.000",
                                   symbol: BodySymbol.item(title: "3.Юридическое сопровождение", value: 40_000, comment: nil)),
                 Token<BodySymbol>(source: "4.Банковская комиссия 1.6% за эквайринг\t26.581",
                                   symbol: BodySymbol.item(title: "4.Банковская комиссия 1.6% за эквайринг", value: 26_581, comment: nil)),
                 Token<BodySymbol>(source: "5.Тайный гость\t-----------------------------",
                                   symbol: BodySymbol.empty),
                 Token<BodySymbol>(source: "6.Обслуживание кассовой программы Айко\t16.336",
                                   symbol: BodySymbol.item(title: "6.Обслуживание кассовой программы Айко", value: 16_336, comment: nil)),
                 Token<BodySymbol>(source: "7.Обслуживание хостинга\t----------------------------",
                                   symbol: BodySymbol.empty),
                 Token<BodySymbol>(source: "8.Обслуживание мобильного приложения\t9.200",
                                   symbol: BodySymbol.item(title: "8.Обслуживание мобильного приложения", value: 9_200, comment: nil)),
                 Token<BodySymbol>(source: "9.Реклама и IT поддержка\t65.000",
                                   symbol: BodySymbol.item(title: "9.Реклама и IT поддержка", value: 65_000, comment: nil)),
                 Token<BodySymbol>(source: "10.Обслуживание пожарной охраны\t-----------------------------",
                                   symbol: BodySymbol.empty),
                 Token<BodySymbol>(source: "11.Вневедомственная охрана помещения\t-----------------------------",
                                   symbol: BodySymbol.empty),
                 Token<BodySymbol>(source: "12.Интернет\t9.000",
                                   symbol: BodySymbol.item(title: "12.Интернет", value: 9_000, comment: nil)),
                 Token<BodySymbol>(source: "13.Дезобработка помещения\t-----------------------------",
                                   symbol: BodySymbol.empty),
                 Token<BodySymbol>(source: "14. ----------------------------------\t----------------------------",
                                   symbol: BodySymbol.empty),
                 Token<BodySymbol>(source: "15.Аренда зарядных устройств и раций\t----------------------------",
                                   symbol: BodySymbol.empty),
                 Token<BodySymbol>(source: "16. Текущие мелкие расходы \t1.600",
                                   symbol: BodySymbol.item(title: "16. Текущие мелкие расходы", value: 1_600, comment: nil)),
                 Token<BodySymbol>(source: "17. Обслуживание Жироуловителей\t-----------------------------",
                                   symbol: BodySymbol.empty),
                 Token<BodySymbol>(source: "18. Аренда оборудования д/питьевой воды\t-----------------------------",
                                   symbol: BodySymbol.empty),
                 Token<BodySymbol>(source: "19. Ремонт оборудования\t-----------------------------",
                                   symbol: BodySymbol.empty),
                 Token<BodySymbol>(source: "20. Чистка вентиляции\t26.250",
                                   symbol: BodySymbol.item(title: "20. Чистка вентиляции", value: 26_250, comment: nil)),
                 Token<BodySymbol>(source: "21. Обслуживание банкетов\t15.250",
                                   symbol: BodySymbol.item(title: "21. Обслуживание банкетов", value: 15_250, comment: nil)),
                 Token<BodySymbol>(source: "22. Хэдхантер (подбор пероснала)\t9.720",
                                   symbol: BodySymbol.item(title: "22. Хэдхантер (подбор пероснала)", value: 9_720, comment: nil)),
                 Token<BodySymbol>(source: "23. Аудит кантора (Бухуслуги)\t60.000",
                                   symbol: BodySymbol.item(title: "23. Аудит кантора (Бухуслуги)", value: 60_000, comment: nil)),
                 Token<BodySymbol>(source: "24. Стол Тенгиз\t17.905",
                                   symbol: BodySymbol.item(title: "24. Стол Тенгиз", value: 17_905, comment: nil)),
                 Token<BodySymbol>(source: "25. Стол Игорь\t47.090",
                                   symbol: BodySymbol.item(title: "25. Стол Игорь", value: 47_090, comment: nil)),
                 Token<BodySymbol>(source: "26. Стол Андрей\t9.550",
                                   symbol: BodySymbol.item(title: "26. Стол Андрей", value: 9_550, comment: nil)),
                 Token<BodySymbol>(source: "27. Сервис Гуру (система аттестации, за 1 год)\t12.655",
                                   symbol: BodySymbol.item(title: "27. Сервис Гуру (система аттестации, за 1 год)", value: 12_655, comment: nil)),
                 Token<BodySymbol>(source: "ИТОГ:\t402.520",
                                   symbol: BodySymbol.footer(title: "ИТОГ:", value: 402_520))],
                [Token<BodySymbol>(source: "Расходы на доставку:",
                                   symbol: BodySymbol.empty),
                 Token<BodySymbol>(source: "1. Курьеры\t-----------------------------",
                                   symbol: BodySymbol.empty),
                 Token<BodySymbol>(source: "2. Агрегаторы\t18.132",
                                   symbol: BodySymbol.item(title: "2. Агрегаторы", value: 18_132, comment: nil)),
                 Token<BodySymbol>(source: "ИТОГ:\t18.132",
                                   symbol: BodySymbol.footer(title: "ИТОГ:", value: 18_132))],
            ],
            footer: [
                Token<FooterSymbol>(source: "ИТОГ всех расходов за месяц:\t2.343.392р 37к",
                                    symbol: FooterSymbol.expensesTotal(title: "ИТОГ всех расходов за месяц", value: 2_343_392.37)),
                Token<FooterSymbol>(source: "Фактический остаток:\t96.628р 63к\t20%",
                                    symbol: FooterSymbol.balance(title: "Фактический остаток", value: 96_628.63, percentage: 0.2)),
                Token<FooterSymbol>(source: "Минус с августа переходит 739.626р 06к",
                                    symbol: FooterSymbol.openingBalance(title: "Минус с августа переходит 739.626р 06к", value: -739_626.06)),
                Token<FooterSymbol>(source: "ИТОГ:\tМинус 642.997р 43к",
                                    symbol: FooterSymbol.runningBalance(title: "ИТОГ", value: -642_997.43))]

        )

        let contents = try filenames[3].contentsOfFile().clearReport()
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
