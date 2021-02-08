//
//  TokenizedReportTests.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 08.02.2021.
//

import XCTest
@testable import TengizReportSP

final class TokenizedReportTests: XCTestCase {
    func test_init() throws {
        XCTAssertNotNil(TokenizedReport(header: [], body: [], footer: []))
        XCTAssertNotNil(TokenizedReport(""))
        XCTAssertNotNil(TokenizedReport(stringLiteral: ""))

        let sample = TokenizedReport(
            header: [
                Token<HeaderSymbol>(source: "Название объекта: Саперави Аминьевка", symbol: HeaderSymbol.company(name: "Саперави Аминьевка")),
                Token<HeaderSymbol>(source: "Месяц: июль2020", symbol: HeaderSymbol.month(monthStr: "июль2020")),
                Token<HeaderSymbol>(source: "Оборот:1.067.807", symbol: HeaderSymbol.revenue(1067807.0)),
                Token<HeaderSymbol>(source: "Средний показатель: 34.445", symbol: HeaderSymbol.dailyAverage(34445.0))],
            body: [
                Token<BodySymbol>(source: "Основные расходы:\t\t25%\t\n1. Аренда торгового помещения\t46.667 (за июнь)\t\t\n2. Эксплуатационные расходы\t-----------------------------\t\t\n3. Электричество\t-----------------------------\t\t\n4. Водоснабжение\t-----------------------------\t\t\n5. Аренда головного офиса\t11.500\t\t\n6. Аренда головного склада\t7.000\t\t\n7. Вывоз мусора\t-----------------------------\t\t\nИТОГ:\t65.167\t\t", symbol: BodySymbol.empty),
                Token<BodySymbol>(source: "Зарплата:\t\t22%\t\n1.ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)\t\t\nФОТ Бренд, логистика, бухгалтерия\t99.000\t\t\n\t\t\t\nИТОГ:\t803.848\t\t", symbol: BodySymbol.empty),
                Token<BodySymbol>(source: "Фактический приход товара и оплата товара:\t\t25%\t\n1. Приход товара по накладным\t922.936р37к (оплаты фактические: 313.570р26к-переводы; 87.091р20к-корпоративная карта; 97.712-наличные из кассы; Итого-498.373р46к)\t\t\n2. Предоплаченный товар, но не отраженный в приходе\tБейсболки персонал-18.000; Подушки в зал-22.400; Итого-40.400\t\t\nИТОГ:\t538.773р46к\t\t", symbol: BodySymbol.empty),
                Token<BodySymbol>(source: "Прочие расходы:\t\t8%\t\n1.Налоговые платежи \t13.318р93к\t\t\n2.Банковское обслуживание\t5.778\t\t\n3.Юридическое сопровождение\t20.000\t\t\n4.Банковская комиссия 1.6% за эквайринг\t12.785\t\t\n5. Тайный гость\t-----------------------------\t\t\n6.Обслуживание кассовой программы\t21.806р20к\t\t\n7. Обслуживание хостинга\t----------------------------\t\t\n8.Обслуживание мобильного приложения\t----------------------------\t\t\n9. Реклама и IT поддержка\t104.000\t\t\n10.Обслуживание пожарной охраны\t-----------------------------\t\t\n11.Вневедомственная охрана помещения\t-----------------------------\t\t\n12.Интернет\t-----------------------------\t\t\n13.Дезобработка помещения\t-----------------------------\t\t\n14. Контур (эл.отчетность)\t3.000\t\t\n15.Аренда зарядных устройств и раций\t-----------------------------\t\t\n16. Текущие мелкие расходы \t2.910\t\t\n17. Обслуживание Жироуловителей\t-----------------------------\t\t\n18. Регистрация Кассового аппарата (запасной)\t2.000\t\t\n19. Ремонт оборудования\t-----------------------------\t\t\n20. Чистка вентиляции\t-----------------------------\t\t\n21. Обслуживание банкетов\t-----------------------------\t\t\n22. Хэдхантер (подбор пероснала)\t3.240\t\t\n23. Аудит кантора (Бухуслуги)\t60.000\t\t\n24. Столы Тенгиза\t6.100\t\t\n25. Стол Игорь\t5.470\t\t\n26. Вино отправляли в подарок\t1.900\t\t\nИТОГ:\t262.308\t\t", symbol: BodySymbol.empty),
                Token<BodySymbol>(source: "Расходы на доставку:\t\t\t\n1. Курьеры\t-----------------------------\t\t\n2. Агрегаторы\t6.981\t\t\nИТОГ:\t6.981\t\t", symbol: BodySymbol.empty)],
            footer: [
                Token<FooterSymbol>(source: "ИТОГ всех расходов за месяц:\t1.677.077р46к", symbol: FooterSymbol.expensesTotal(title: "ИТОГ всех расходов за месяц", value: 1677077.46)),
                Token<FooterSymbol>(source: "Фактический остаток:\t-609.230р46к\t20%", symbol: FooterSymbol.balance(title: "Фактический остаток", value: -609230.46, percentage: Optional(0.2))),
                Token<FooterSymbol>(source: "-173.753 остаток с июня", symbol: FooterSymbol.openingBalance(title: "-173.753 остаток с июня", value: -173753.0)),
                Token<FooterSymbol>(source: "-28.000 субсидия, поступила в июле", symbol: FooterSymbol.extraIncomeExpenses(title: "-28.000 субсидия, поступила в июле", value: -28000.0)),
                Token<FooterSymbol>(source: "ИТОГ:\t-407.477р46к", symbol: FooterSymbol.runningBalance(title: "ИТОГ", value: -407477.46))])

        let report = try filenames[1].contentsOfFile()
        XCTAssertEqual(TokenizedReport(stringLiteral: report), sample)
    }
}
