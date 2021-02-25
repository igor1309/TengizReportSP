//
//  SplitReportPatternsTests.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 29.01.2021.
//

import XCTest
import TextReports
import RegexTools
@testable import Model

final class SplitReportPatternsTests: XCTestCase {
    func testReport_header() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.header, #"(?m)(^(.*)\n)+?(?=Статья расхода:)"#)

        // MARK: match
        XCTAssertEqual("""
            Название объекта: Саперави Аминьевка
            Декабрь2020     Оборот:2.318.274    Средний показатель: 74.783

            Статья расхода:\t
            """.firstMatch(for: Patterns.header),
                       "Название объекта: Саперави Аминьевка\nДекабрь2020     Оборот:2.318.274    Средний показатель: 74.783\n\n")

        // MARK: no match
        XCTAssertNil("""
            Название объекта: Саперави Аминьевка
            Декабрь2020     Оборот:2.318.274    Средний показатель: 74.783
            """.firstMatch(for: Patterns.header),
                     "No match without 'Статья расхода:'")

        XCTAssertNil("""
            1. Аренда торгового помещения     500.000 (за ноябрь)
            2. Эксплуатационные расходы    -----------------------------
            3. Электричество    -----------------------------
            4. Водоснабжение    -----------------------------
            """.firstMatch(for: Patterns.header),
                     "No match without 'Статья расхода:'")
    }

    func testReport_footer() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.footer, #"(?m)^ИТОГ всех расходов за месяц(?:.|\n)*$"#)

        // MARK: match
        XCTAssertEqual("""
            ИТОГ всех расходов за месяц:    2.432.175р89к

            Фактический остаток:    Минус 113.901р89к    20%
            Переходящий минус 1.065.596р 76к

            ИТОГ:    Минус 1.179.498р65к
            """.firstMatch(for: Patterns.footer),
                       "ИТОГ всех расходов за месяц:    2.432.175р89к\n\nФактический остаток:    Минус 113.901р89к    20%\nПереходящий минус 1.065.596р 76к\n\nИТОГ:    Минус 1.179.498р65к")

        XCTAssertEqual("""
            ИТОГ:    19.131
            ИТОГ всех расходов за месяц:    2.432.175р89к

            Фактический остаток:    Минус 113.901р89к    20%
            Переходящий минус 1.065.596р 76к

            ИТОГ:    Минус 1.179.498р65к
            """.firstMatch(for: Patterns.footer),
                       "ИТОГ всех расходов за месяц:    2.432.175р89к\n\nФактический остаток:    Минус 113.901р89к    20%\nПереходящий минус 1.065.596р 76к\n\nИТОГ:    Минус 1.179.498р65к")

        // MARK: no match
        XCTAssertNil("""

            Фактический остаток:    Минус 113.901р89к    20%
            Переходящий минус 1.065.596р 76к

            ИТОГ:    Минус 1.179.498р65к

            """.firstMatch(for: Patterns.footer),
                     "No match without 'ИТОГ всех расходов за месяц:'")
    }

    func test_columnTitleRow() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.columnTitleRow,
                       #"(?m)^Статья расхода:\s*Сумма расхода:\s*План %\s*Факт %\s*\n"#)

        // MARK: match
        XCTAssertEqual("""
            Статья расхода:    Сумма расхода:    План %     Факт %\n
            """.firstMatch(for: Patterns.columnTitleRow),
                       "Статья расхода:    Сумма расхода:    План %     Факт %\n")

        // MARK: no match
        XCTAssertNil("""
            1.ФОТ    595.360 ( за первую часть ноября)\n
            """.firstMatch(for: Patterns.columnTitleRow))
    }

    func testReport_body() throws {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.body,
                       #"(?m)(?:^[А-Яа-я ]+:.*$)(?:\n.*$)+?\nИТОГ:.*"#)

        // MARK: match
        XCTAssertEqual("""
            Статья расхода:    Сумма расхода:    План %     Факт %
            Основные расходы:        20%
            1. Аренда торгового помещения     500.000 (за ноябрь)
            7. Вывоз мусора    -----------------------------
            ИТОГ:    518.500
            Зарплата:        20%
            ФОТ Бренд, логистика, бухгалтерия    99.000
            """.firstMatch(for: Patterns.body),
                       "Статья расхода:    Сумма расхода:    План %     Факт %\nОсновные расходы:        20%\n1. Аренда торгового помещения     500.000 (за ноябрь)\n7. Вывоз мусора    -----------------------------\nИТОГ:    518.500")

        XCTAssertEqual("""
            Основные расходы:        20%
            1. Аренда торгового помещения     500.000 (за ноябрь)
            7. Вывоз мусора    -----------------------------
            ИТОГ:    518.500
            Зарплата:        20%
            ФОТ Бренд, логистика, бухгалтерия    99.000
            """.firstMatch(for: Patterns.body),
                       "Основные расходы:        20%\n1. Аренда торгового помещения     500.000 (за ноябрь)\n7. Вывоз мусора    -----------------------------\nИТОГ:    518.500")

        XCTAssertEqual("""
            ИТОГ:    518.500
            Зарплата:        20%
            ФОТ Бренд, логистика, бухгалтерия    99.000
            ИТОГ:
            """.firstMatch(for: Patterns.body),
                       "ИТОГ:    518.500\nЗарплата:        20%\nФОТ Бренд, логистика, бухгалтерия    99.000\nИТОГ:")

        //        let contents = try ContentLoader.saperavi_2020_07.contentsOfFile()
        //        XCTAssertNil([contents])
        var input = FileContent.saperavi_2020_07_body_group1
        XCTAssertEqual(input.firstMatch(for: Patterns.body), input)
        XCTAssertEqual("\(input)\n".firstMatch(for: Patterns.body), input, "Final '\n' not included into pattern")

        input = FileContent.saperavi_2020_07_body_group2
        XCTAssertEqual(input.firstMatch(for: Patterns.body), input)

        input = FileContent.saperavi_2020_07_body_group3
        XCTAssertEqual(input.firstMatch(for: Patterns.body), input)

        input = FileContent.saperavi_2020_07_body_group4
        XCTAssertEqual(input.firstMatch(for: Patterns.body), input)

        // MARK: no match
        XCTAssertNil("""
            ИТОГ:    518.500
            Зарплата:        20%
            ФОТ Бренд, логистика, бухгалтерия    99.000
            """.firstMatch(for: Patterns.body))

        XCTAssertNotEqual(FileContent.saperavi_2020_07.listMatches(for: Patterns.body),
                          FileContent.saperavi_2020_07_body_groups, "'Patterns.body' gets report header not just body groups")
    }

    func test_MOVE_IT_TO_GET_SOURCES_AND_RENAME() throws {
        XCTAssertEqual(ContentLoader.allFilenames.count, 11, "Might have been added new report(s).")

        let rows = try ContentLoader.allFilenames.flatMap { filename -> [String] in
            let contents = try ContentLoader.contentsOfFile(filename).get()
            return contents.components(separatedBy: "\n")
        }
        .filter { !$0.isEmpty}
        .filter { $0 != "\t\t\t" }
        .removingDuplicates()
        .sorted()

        XCTAssertEqual(rows.count, 361)
        XCTAssertEqual(rows, FileContent.allRows)
        let firstPart = Array(rows.prefix(200))
        XCTAssertEqual(firstPart, FileContent.firstPart)
        let secondPart = Array(rows.dropFirst(200))
        XCTAssertEqual(secondPart, FileContent.secondPart)
    }

}

struct FileContent {
    #warning("finish with this")
    static let saperavi_2020_07 =
        "Название объекта: Саперави Аминьевка\nМесяц: июль2020 \tОборот:1.067.807\tСредний показатель: 34.445\n\nСтатья расхода:\tСумма расхода:\tПлан % \tФакт %\nОсновные расходы:\t\t25%\t\n1. Аренда торгового помещения\t46.667 (за июнь)\t\t\n2. Эксплуатационные расходы\t-----------------------------\t\t\n3. Электричество\t-----------------------------\t\t\n4. Водоснабжение\t-----------------------------\t\t\n5. Аренда головного офиса\t11.500\t\t\n6. Аренда головного склада\t7.000\t\t\n7. Вывоз мусора\t-----------------------------\t\t\nИТОГ:\t65.167\t\t\nЗарплата:\t\t22%\t\n1.ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)\t\t\nФОТ Бренд, логистика, бухгалтерия\t99.000\t\t\n\t\t\t\nИТОГ:\t803.848\t\t\nФактический приход товара и оплата товара:\t\t25%\t\n1. Приход товара по накладным\t922.936р37к (оплаты фактические: 313.570р26к-переводы; 87.091р20к-корпоративная карта; 97.712-наличные из кассы; Итого-498.373р46к)\t\t\n2. Предоплаченный товар, но не отраженный в приходе\tБейсболки персонал-18.000; Подушки в зал-22.400; Итого-40.400\t\t\nИТОГ:\t538.773р46к\t\t\nПрочие расходы:\t\t8%\t\n1.Налоговые платежи \t13.318р93к\t\t\n2.Банковское обслуживание\t5.778\t\t\n3.Юридическое сопровождение\t20.000\t\t\n4.Банковская комиссия 1.6% за эквайринг\t12.785\t\t\n5. Тайный гость\t-----------------------------\t\t\n6.Обслуживание кассовой программы\t21.806р20к\t\t\n7. Обслуживание хостинга\t----------------------------\t\t\n8.Обслуживание мобильного приложения\t----------------------------\t\t\n9. Реклама и IT поддержка\t104.000\t\t\n10.Обслуживание пожарной охраны\t-----------------------------\t\t\n11.Вневедомственная охрана помещения\t-----------------------------\t\t\n12.Интернет\t-----------------------------\t\t\n13.Дезобработка помещения\t-----------------------------\t\t\n14. Контур (эл.отчетность)\t3.000\t\t\n15.Аренда зарядных устройств и раций\t-----------------------------\t\t\n16. Текущие мелкие расходы \t2.910\t\t\n17. Обслуживание Жироуловителей\t-----------------------------\t\t\n18. Регистрация Кассового аппарата (запасной)\t2.000\t\t\n19. Ремонт оборудования\t-----------------------------\t\t\n20. Чистка вентиляции\t-----------------------------\t\t\n21. Обслуживание банкетов\t-----------------------------\t\t\n22. Хэдхантер (подбор пероснала)\t3.240\t\t\n23. Аудит кантора (Бухуслуги)\t60.000\t\t\n24. Столы Тенгиза\t6.100\t\t\n25. Стол Игорь\t5.470\t\t\n26. Вино отправляли в подарок\t1.900\t\t\nИТОГ:\t262.308\t\t\nРасходы на доставку:\t\t\t\n1. Курьеры\t-----------------------------\t\t\n2. Агрегаторы\t6.981\t\t\nИТОГ:\t6.981\t\t\nИТОГ всех расходов за месяц:\t1.677.077р46к\t\t\n\t\t\t\nФактический остаток:\t-609.230р46к\t20%\t\n\t-173.753 остаток с июня\t\t\n\t-28.000 субсидия, поступила в июле\t\t\nИТОГ:\t-407.477р46к\t\t\n"

    static let saperavi_2020_07_body_groups = [saperavi_2020_07_body_group1,
                                               saperavi_2020_07_body_group2,
                                               saperavi_2020_07_body_group3,
                                               saperavi_2020_07_body_group4,
                                               saperavi_2020_07_body_group5]

    static let saperavi_2020_07_body_group1 = "Основные расходы:\t\t25%\t\n1. Аренда торгового помещения\t46.667 (за июнь)\t\t\n2. Эксплуатационные расходы\t-----------------------------\t\t\n3. Электричество\t-----------------------------\t\t\n4. Водоснабжение\t-----------------------------\t\t\n5. Аренда головного офиса\t11.500\t\t\n6. Аренда головного склада\t7.000\t\t\n7. Вывоз мусора\t-----------------------------\t\t\nИТОГ:\t65.167\t\t"

    static let saperavi_2020_07_body_group2 = "Зарплата:\t\t22%\t\n1.ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)\t\t\nФОТ Бренд, логистика, бухгалтерия\t99.000\t\t\n\t\t\t\nИТОГ:\t803.848\t\t"

    static let saperavi_2020_07_body_group3 = "Фактический приход товара и оплата товара:\t\t25%\t\n1. Приход товара по накладным\t922.936р37к (оплаты фактические: 313.570р26к-переводы; 87.091р20к-корпоративная карта; 97.712-наличные из кассы; Итого-498.373р46к)\t\t\n2. Предоплаченный товар, но не отраженный в приходе\tБейсболки персонал-18.000; Подушки в зал-22.400; Итого-40.400\t\t\nИТОГ:\t538.773р46к\t\t"

    static let saperavi_2020_07_body_group4 =
        "Прочие расходы:\t\t8%\t\n1.Налоговые платежи \t13.318р93к\t\t\n2.Банковское обслуживание\t5.778\t\t\n3.Юридическое сопровождение\t20.000\t\t\n4.Банковская комиссия 1.6% за эквайринг\t12.785\t\t\n5. Тайный гость\t-----------------------------\t\t\n6.Обслуживание кассовой программы\t21.806р20к\t\t\n7. Обслуживание хостинга\t----------------------------\t\t\n8.Обслуживание мобильного приложения\t----------------------------\t\t\n9. Реклама и IT поддержка\t104.000\t\t\n10.Обслуживание пожарной охраны\t-----------------------------\t\t\n11.Вневедомственная охрана помещения\t-----------------------------\t\t\n12.Интернет\t-----------------------------\t\t\n13.Дезобработка помещения\t-----------------------------\t\t\n14. Контур (эл.отчетность)\t3.000\t\t\n15.Аренда зарядных устройств и раций\t-----------------------------\t\t\n16. Текущие мелкие расходы \t2.910\t\t\n17. Обслуживание Жироуловителей\t-----------------------------\t\t\n18. Регистрация Кассового аппарата (запасной)\t2.000\t\t\n19. Ремонт оборудования\t-----------------------------\t\t\n20. Чистка вентиляции\t-----------------------------\t\t\n21. Обслуживание банкетов\t-----------------------------\t\t\n22. Хэдхантер (подбор пероснала)\t3.240\t\t\n23. Аудит кантора (Бухуслуги)\t60.000\t\t\n24. Столы Тенгиза\t6.100\t\t\n25. Стол Игорь\t5.470\t\t\n26. Вино отправляли в подарок\t1.900\t\t\nИТОГ:\t262.308\t\t"

    static let saperavi_2020_07_body_group5 = "Расходы на доставку:\t\t\t\n1. Курьеры\t-----------------------------\t\t\n2. Агрегаторы\t6.981\t\t\nИТОГ:\t6.981\t\t\nИТОГ всех расходов за месяц:\t1.677.077р46к\t\t\n\t\t\t\nФактический остаток:\t-609.230р46к\t20%\t\n\t-173.753 остаток с июня\t\t\n\t-28.000 субсидия, поступила в июле\t\t\nИТОГ:\t-407.477р46к\t\t\n"

    static let firstPart: [String] = [
        "\t+23.334р 76к остаток с инвестиций\t\t",
        "\t-10.000 за перерасход питание персонала в июле\t\t",
        "\t-173.753 остаток с июня\t\t",
        "\t-28.000 субсидия, поступила в июле\t\t",
        "\tМинус с августа переходит 739.626р 06к\t\t",
        "\tМинус с июля 407.477р 46 к., переходит \t\t",
        "\tПереходит минус с сентября 642.997р 43к\t\t",
        "\tПереходящий минус 1.065.596р 76к\t\t",
        "\tПереходящий минус 1.179.498р 65к\t\t",
        "\tПереходящий минус 920.304р 17к\t\t",
        "-------------------------------------------------------------------\t-----------------------------\t\t",
        "----------------------------------------------------------------------\t-----------------------------\t\t",
        "1. Аренда торгового помещения\t 200.000 (за август)\t\t",
        "1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)\t\t",
        "1. Аренда торгового помещения\t 200.000 (за июль)\t\t",
        "1. Аренда торгового помещения\t 500.000 (за ноябрь)\t\t",
        "1. Аренда торгового помещения\t 500.000 (за октябрь)\t\t",
        "1. Аренда торгового помещения\t----------------------------\t\t",
        "1. Аренда торгового помещения\t-----------------------------\t\t",
        "1. Аренда торгового помещения\t46.667 (за июнь)\t\t",
        "1. Курьеры\t-----------------------------\t\t",
        "1. Курьеры\t4.700\t\t",
        "1. Курьеры\t6.400\t\t",
        "1. Приход товара по накладным\t 739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого 437.474р 47к)\t\t",
        "1. Приход товара по накладным\t 753.950р74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)\t\t",
        "1. Приход товара по накладным\t 832.168р88к; (оплаты фактические: 556.331р 58к -переводы; 159.321р20к -корпоративная карта; 153.377р -наличные из кассы; Итого 869.029р 78к)\t\t",
        "1. Приход товара по накладным\t 907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)\t\t",
        "1. Приход товара по накладным\t 946.056р (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)\t\t",
        "1. Приход товара по накладным\t 997.446р; (оплаты фактические: 491.114р 65к -переводы; 114.589р -корпоративная карта; 12.170р -наличные из кассы; Итого 617.873р 65к)\t\t",
        "1. Приход товара по накладным\t179.108р89к+512.293р(оплаты фактические:199.803р80к-переводы;81.225р35к-корпоративная карта;34.202р-наличные из кассы; Итого 315.231р15к)\t\t",
        "1. Приход товара по накладным\t375.116р18к(оплаты фактические:389.218р21к-переводы;57.084р55к-корпоративная карта;27.877р-наличные из кассы; Итого 474.179р76к)\t\t",
        "1. Приход товара по накладным\t451.198р41к (из них у нас оплачено фактический 21.346р15к)\t\t",
        "1. Приход товара по накладным\t473.128р43к(оплаты фактические:231.572р46к-переводы;51.104р93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р39к)\t\t",
        "1. Приход товара по накладным\t922.936р37к (оплаты фактические: 313.570р26к-переводы; 87.091р20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р46к)\t\t",
        "1.Налоговые платежи \t----------------------------\t\t",
        "1.Налоговые платежи \t-----------------------------\t\t",
        "1.Налоговые платежи \t13.318р93к\t\t",
        "1.Налоговые платежи \t20.614\t\t",
        "1.Налоговые платежи \t22.282р86к\t\t",
        "1.Налоговые платежи \t22.895р38к\t\t",
        "1.Налоговые платежи \t23.130р52к\t\t",
        "1.Налоговые платежи \t26.964\t\t",
        "1.Налоговые платежи \t28.480р79к\t\t",
        "1.Налоговые платежи \t31.949р38к\t\t",
        "1.Налоговые платежи \t35.311\t\t",
        "1.ФОТ\t 1.064.769( за вторую  часть ноября и первую часть декабря) \t\t",
        "1.ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)\t\t",
        "1.ФОТ\t 564.678( за вторую часть октября) \t\t",
        "1.ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)\t\t",
        "1.ФОТ\t 894.510( за вторую часть июля и первая часть августа)\t\t",
        "1.ФОТ\t 960.056( за вторую часть августа и первую  часть сентября)\t\t",
        "1.ФОТ\t19.721 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)\t\t",
        "1.ФОТ\t595.360 ( за первую часть ноября) \t\t",
        "1.ФОТ общий\t261.978\t\t",
        "1.ФОТ общий\t503.608\t\t",
        "1.ФОТ общий\t67.894\t\t",
        "10.-----------------------\t----------------\t\t",
        "10.Обслуживание пожарной охраны\t-----------------------------\t\t",
        "11. -----------------------\t-----------------\t\t",
        "11.Вневедомственная охрана помещения\t-----------------------------\t\t",
        "12.Интернет\t----------------------------\t\t",
        "12.Интернет\t-----------------------------\t\t",
        "12.Интернет\t3.500\t\t",
        "12.Интернет\t4.500\t\t",
        "12.Интернет\t6.065\t\t",
        "12.Интернет\t7.701+4.500\t\t",
        "12.Интернет\t9.000\t\t",
        "13.Дезобработка помещения\t---------------------\t\t",
        "13.Дезобработка помещения\t-----------------------------\t\t",
        "13.Дезобработка помещения\t4.500\t\t",
        "14. ---------------\t---------------\t\t",
        "14. ----------------------------------\t----------------------------\t\t",
        "14. Вышивка логотипа на одежде\t2.836\t\t",
        "14. Контур (эл.отчетность)\t3.000\t\t",
        "14. Облачная касса для доставки через сайт\t36.000\t\t",
        "14. Поверка весов\t3.400\t\t",
        "14. РПК Ника (крепления д/телевизоров и монтаж)\t30.000\t\t",
        "14.-----------------------------------------------------------------\t-----------------------------\t\t",
        "14.Ремонт оборудования\t--------------------\t\t",
        "15.Аренда зарядных устройств и раций\t----------------------------\t\t",
        "15.Аренда зарядных устройств и раций\t-----------------------------\t\t",
        "15.Аренда зарядных устройств и раций\t10.000\t\t",
        "15.Аренда зарядных устройств и раций\t5.000\t\t",
        "15.Ремонт и чистка вентиляции\t--------\t\t",
        "15.Ремонт и чистка вентиляции\t---------------------\t\t",
        "15.Ремонт и чистка вентиляции\t15.000\t\t",
        "16. Текущие мелкие расходы\t1.000\t\t",
        "16. Текущие мелкие расходы\t1.400\t\t",
        "16. Текущие мелкие расходы\t1.925\t\t",
        "16. Текущие мелкие расходы \t1.200\t\t",
        "16. Текущие мелкие расходы \t1.600\t\t",
        "16. Текущие мелкие расходы \t2.250\t\t",
        "16. Текущие мелкие расходы \t2.600\t\t",
        "16. Текущие мелкие расходы \t2.910\t\t",
        "16. Текущие мелкие расходы \t4.746\t\t",
        "16. Текущие мелкие расходы \t5.460\t\t",
        "16. Текущие мелкие расходы \t6.690\t\t",
        "17. Обслуживание Жироуловителей\t-----------------------------\t\t",
        "17. Чистка жироуловителей и канализации\t-------------\t\t",
        "17. Чистка жироуловителей и канализации\t---------------------\t\t",
        "17. Чистка жироуловителей и канализации\t10.139\t\t",
        "18. -----------------------------------------------------------------\t-----------------------------\t\t",
        "18. Аренда оборудования д/питьевой воды\t-------------------\t\t",
        "18. Аренда оборудования д/питьевой воды\t-----------------------------\t\t",
        "18. Аренда оборудования д/питьевой воды\t5.130\t\t",
        "18. Маркетинговый платеж\t--------------------\t\t",
        "18. Регистрация Кассового аппарата (запасной)\t2.000\t\t",
        "19. ----------------------\t-----------------\t\t",
        "19. Ремонт оборудования\t\t\t",
        "19. Ремонт оборудования\t----------------------\t\t",
        "19. Ремонт оборудования\t-----------------------------\t\t",
        "19. Ремонт оборудования\t6.610\t\t",
        "2. Агрегаторы\t-----------------------------\t\t",
        "2. Агрегаторы\t14.431\t\t",
        "2. Агрегаторы\t17.839\t\t",
        "2. Агрегаторы\t18.132\t\t",
        "2. Агрегаторы\t20.586\t\t",
        "2. Агрегаторы\t21.541\t\t",
        "2. Агрегаторы\t23.179\t\t",
        "2. Агрегаторы\t6.981\t\t",
        "2. Агрегаторы\t70.291\t\t",
        "2. Агрегаторы\t8.169\t\t",
        "2. Агрегаторы\t9.528\t\t",
        "2. Предоплаченный товар, но не отраженный в приходе\t\t\t",
        "2. Предоплаченный товар, но не отраженный в приходе\t КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого 23.600\t\t",
        "2. Предоплаченный товар, но не отраженный в приходе\t--------------\t\t",
        "2. Предоплаченный товар, но не отраженный в приходе\t15.800\t\t",
        "2. Предоплаченный товар, но не отраженный в приходе\tБейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400\t\t",
        "2. Предоплаченный товар, но не отраженный в приходе\tСтудиопак Итого 12.500 (влажные салфетки);\t\t",
        "2. ФОТ Бренд, логистика, бухгалтерия\t90.000\t\t",
        "2. ФОТ Бренд, логистика, бухгалтерия\t99.000\t\t",
        "2. Эксплуатационные расходы\t-----------------------------\t\t",
        "2.Банковское обслуживание\t2.305р78к\t\t",
        "2.Банковское обслуживание\t2.344р29к\t\t",
        "2.Банковское обслуживание\t2.514\t\t",
        "2.Банковское обслуживание\t4.544\t\t",
        "2.Банковское обслуживание\t5.778\t\t",
        "2.Банковское обслуживание\t5.863р74к\t\t",
        "2.Банковское обслуживание\t6.279\t\t",
        "2.Банковское обслуживание\t6.419\t\t",
        "2.Банковское обслуживание\t6.994р61к\t\t",
        "2.Банковское обслуживание\t7.234\t\t",
        "2.Банковское обслуживание\t7.473р86к\t\t",
        "20. ----------------------\t----------------\t\t",
        "20. Чистка вентиляции\t-----------------------------\t\t",
        "20. Чистка вентиляции\t26.250\t\t",
        "20. Чистка вентиляции\t35.000\t\t",
        "21. -----------------------\t---------------\t\t",
        "21. Обслуживание банкетов\t\t\t",
        "21. Обслуживание банкетов\t----------------\t\t",
        "21. Обслуживание банкетов\t-----------------------------\t\t",
        "21. Обслуживание банкетов\t15.250\t\t",
        "21. Обслуживание банкетов\t5.625\t\t",
        "21. Обслуживание банкетов\t6.750\t\t",
        "22. Хэдхантер (подбор пероснала)\t---------------------\t\t",
        "22. Хэдхантер (подбор пероснала)\t----------------------------\t\t",
        "22. Хэдхантер (подбор пероснала)\t3.240\t\t",
        "22. Хэдхантер (подбор пероснала)\t4.227\t\t",
        "22. Хэдхантер (подбор пероснала)\t9.720\t\t",
        "23. Аудит кантора (Бухуслуги)\t60.000\t\t",
        "24. ---------\t-------------\t\t",
        "24. -----------------------\t---------------\t\t",
        "24. Корректировка ЕГАИС\t10.000\t\t",
        "24. Стол Тенгиз\t10.552\t\t",
        "24. Стол Тенгиз\t17.905\t\t",
        "24. Столы Тенгиза\t6.100\t\t",
        "24. Яндекс карты\t51.975\t\t",
        "25. --------\t-------------\t\t",
        "25. -----------------------\t---------------\t\t",
        "25. Игорь стол\t22.130\t\t",
        "25. Стол Игорь\t45.440\t\t",
        "25. Стол Игорь\t47.090\t\t",
        "25. Стол Игорь\t5.470\t\t",
        "26. ---------\t-------------\t\t",
        "26. ---------------------------------\t-----------------------------\t\t",
        "26. Вино отправляли в подарок\t1.900\t\t",
        "26. Новогодний декор\t169.702\t\t",
        "26. Новогодний декор-демонтаж\t15.900\t\t",
        "26. Стол Андрей\t9.550\t\t",
        "27. ---------\t------------\t\t",
        "27. Сервис Гуру (система аттестации, за 1 год)\t12.655\t\t",
        "3. Электричество\t-----------------------------\t\t",
        "3. Электричество\t------------------------------\t\t",
        "3. Электричество\t150.000\t\t",
        "3.--------------------------------------\t-----------------------------\t\t",
        "3.Юридическое сопровождение\t-----------------------------\t\t",
        "3.Юридическое сопровождение\t20.000\t\t",
        "3.Юридическое сопровождение\t40.000\t\t",
        "4. Водоснабжение\t-----------------------------\t\t",
        "4.Банковская комиссия 1.6% за эквайринг\t11.540\t\t",
        "4.Банковская комиссия 1.6% за эквайринг\t12.111\t\t",
        "4.Банковская комиссия 1.6% за эквайринг\t12.785\t\t",
        "4.Банковская комиссия 1.6% за эквайринг\t15.963\t\t",
        "4.Банковская комиссия 1.6% за эквайринг\t19.769\t\t",
        "4.Банковская комиссия 1.6% за эквайринг\t2.120\t\t",
        "4.Банковская комиссия 1.6% за эквайринг\t22.653\t\t",
        "4.Банковская комиссия 1.6% за эквайринг\t25.785\t\t",
        "4.Банковская комиссия 1.6% за эквайринг\t26.581\t\t",
        "4.Банковская комиссия 1.6% за эквайринг\t26.915\t\t",
        "4.Банковская комиссия 1.6% за эквайринг\t31.587\t\t"
    ]

    static let secondPart: [String] = [
        "5. Аренда головного офиса\t11.500\t\t",
        "5. Тайный гость\t-----------------------------\t\t",
        "5.Тайный гость\t-----------------------------\t\t",
        "5.Юридическое сопровождение\t40.000\t\t",
        "6. Аренда головного склада\t-----------------------------\t\t",
        "6. Аренда головного склада\t7.000\t\t",
        "6.Обслуживание кассовой программы\t----------------------------\t\t",
        "6.Обслуживание кассовой программы\t11.500\t\t",
        "6.Обслуживание кассовой программы\t14.866\t\t",
        "6.Обслуживание кассовой программы\t15.995\t\t",
        "6.Обслуживание кассовой программы\t21.806р20к\t\t",
        "6.Обслуживание кассовой программы\t6.250+18.130\t\t",
        "6.Обслуживание кассовой программы Айко\t12.000\t\t",
        "6.Обслуживание кассовой программы Айко\t16.336\t\t",
        "6.Обслуживание кассовой программы Айко\t4.500+8.700+15.995\t\t",
        "6.Обслуживание кассовой программы Айко\t6.250+9.000\t\t",
        "6.Обслуживание кассовой программы Айко\t8.435\t\t",
        "7. Вывоз мусора\t-----------------------------\t\t",
        "7. Обслуживание хостинга\t----------------------------\t\t",
        "7. Обслуживание хостинга\t2.500\t\t",
        "7.Вывоз мусора\t-----------------------------\t\t",
        "7.Вывоз мусора\t14.500\t\t",
        "7.Вывоз мусора\t15.800\t\t",
        "7.Вывоз мусора\t18.000\t\t",
        "7.Обслуживание хостинга\t----------------------------\t\t",
        "8.Аудит Кантора (бухуслуги)\t60.000\t\t",
        "8.Обслуживание мобильного приложения\t----------------------------\t\t",
        "8.Обслуживание мобильного приложения\t9.200\t\t",
        "8.Печать рекламных буклетов и их раздача\t7.300\t\t",
        "9. Реклама и IT поддержка\t104.000\t\t",
        "9. Реклама и IT поддержка\t16.300\t\t",
        "9. Реклама и IT поддержка\t59.200\t\t",
        "9. Реклама и IT поддержка\t65.000\t\t",
        "9. Реклама и IT поддержка\t75.000\t\t",
        "9.Реклама и IT поддержка\t53.500\t\t",
        "9.Реклама и IT поддержка\t65.000\t\t",
        "9.Реклама и IT поддержка\t70.500\t\t",
        "9.Реклама и IT поддержка\t82.000\t\t",
        "9.Реклама и IT поддержка\t85.000\t\t",
        "9.Реклама и IT поддержка\t90.000\t\t",
        "Декабрь2020\tОборот факт:929.625\tСредний показатель:29.987",
        "Декабрь2020 \tОборот:2.318.274\tСредний показатель: 74.783",
        "Зарплата:\t\t20%\t",
        "Зарплата:\t\t20%\t43.4%",
        "Зарплата:\t\t20%\t57.13%",
        "Зарплата:\t\t22%\t",
        "Зарплата:\t-----------------------------\t20%\t",
        "ИТОГ всех расходов за месяц:\t1.402.860р06к\t\t",
        "ИТОГ всех расходов за месяц:\t1.677.077р46к\t\t",
        "ИТОГ всех расходов за месяц:\t2.030.572р59к\t\t",
        "ИТОГ всех расходов за месяц:\t2.094.271р 36к\t\t",
        "ИТОГ всех расходов за месяц:\t2.343.392р 37к\t\t",
        "ИТОГ всех расходов за месяц:\t2.432.175р89к\t\t",
        "ИТОГ всех расходов за месяц:\t2.550.334р18к\t\t",
        "ИТОГ всех расходов за месяц:\t2.865.042р 74к\t\t",
        "ИТОГ всех расходов за месяц:\t695.836р15к\t\t",
        "ИТОГ всех расходов за месяц:\t92.531р15к\t\t",
        "ИТОГ всех расходов за месяц:\t920.954р54к\t\t",
        "ИТОГ:\t\t\t",
        "ИТОГ:\t-407.477р46к\t\t",
        "ИТОГ:\t-739.626р 06к\t\t",
        "ИТОГ:\t1.059.056\t\t",
        "ИТОГ:\t1.163.769\t\t",
        "ИТОГ:\t1.246.085\t\t",
        "ИТОГ:\t11.500\t\t",
        "ИТОГ:\t157.894\t\t",
        "ИТОГ:\t168.500\t\t",
        "ИТОГ:\t17.839\t\t",
        "ИТОГ:\t18.132\t\t",
        "ИТОГ:\t19.131\t\t",
        "ИТОГ:\t19.721\t\t",
        "ИТОГ:\t20.586\t\t",
        "ИТОГ:\t21.541\t\t",
        "ИТОГ:\t214.542\t\t",
        "ИТОГ:\t218.500\t\t",
        "ИТОГ:\t238.781р30к\t\t",
        "ИТОГ:\t24.164\t\t",
        "ИТОГ:\t244.472р15к\t\t",
        "ИТОГ:\t26.000\t\t",
        "ИТОГ:\t262.308\t\t",
        "ИТОГ:\t27.300\t\t",
        "ИТОГ:\t285.476р39к\t\t",
        "ИТОГ:\t29.500\t\t",
        "ИТОГ:\t29.579\t\t",
        "ИТОГ:\t315.231р15к\t\t",
        "ИТОГ:\t319.456р40к\t\t",
        "ИТОГ:\t326.556\t\t",
        "ИТОГ:\t350.700\t\t",
        "ИТОГ:\t351.978\t\t",
        "ИТОГ:\t356.139р25к переносим на февраль\t\t",
        "ИТОГ:\t37.146р15к\t\t",
        "ИТОГ:\t393.081р12к\t\t",
        "ИТОГ:\t402.520\t\t",
        "ИТОГ:\t437.474р47к\t\t",
        "ИТОГ:\t474.179р76к\t\t",
        "ИТОГ:\t518.500\t\t",
        "ИТОГ:\t538.773р46к\t\t",
        "ИТОГ:\t545.119р 36к\t\t",
        "ИТОГ:\t582.311р24к\t\t",
        "ИТОГ:\t593.608\t\t",
        "ИТОГ:\t6.981\t\t",
        "ИТОГ:\t617.873р65к\t\t",
        "ИТОГ:\t618.500\t\t",
        "ИТОГ:\t628.215р 74к\t\t",
        "ИТОГ:\t645.184р37к\t\t",
        "ИТОГ:\t65.167\t\t",
        "ИТОГ:\t663.678\t\t",
        "ИТОГ:\t684.753р85к переносится на декабрь месяц\t\t",
        "ИТОГ:\t693.424р31к переносим на январь\t\t",
        "ИТОГ:\t694.360\t\t",
        "ИТОГ:\t70.291\t\t",
        "ИТОГ:\t8.169\t\t",
        "ИТОГ:\t803.848\t\t",
        "ИТОГ:\t869.029р78к\t\t",
        "ИТОГ:\t9.528\t\t",
        "ИТОГ:\t983.510\t\t",
        "ИТОГ:\tМинус 1.065.596р 76к\t\t",
        "ИТОГ:\tМинус 1.179.498р65к\t\t",
        "ИТОГ:\tМинус 1.422.601р83к\t\t",
        "ИТОГ:\tМинус 642.997р 43к\t\t",
        "ИТОГ:\tМинус 920.304р 17к\t\t",
        "Месяц: август2020 \tОборот:1.738.788\tСредний показатель: 56.089",
        "Месяц: июль2020 \tОборот:1.067.807\tСредний показатель: 34.445",
        "Месяц: июнь2020 (с 24 по 30 июня)\tОборот:266.285\tСредний показатель: 38.040",
        "Месяц: сентябрь2020 \tОборот:2.440.021\tСредний показатель: 81.334",
        "Название объекта: Вай Мэ! Щелково",
        "Название объекта: Саперави Аминьевка",
        "Ноябрь2020 \tОборот:1.885.280\tСредний показатель: 62.842",
        "Октябрь+Ноябрь2020\tОборот факт:141.690+1.238.900=1.380.590\tСредний показатель:41.836",
        "Октябрь2020 \tОборот:2.587.735\tСредний показатель: 83.475",
        "Основные расходы:\t\t20%\t",
        "Основные расходы:\t\t20%\t12.56%",
        "Основные расходы:\t\t20%\t8.95%",
        "Основные расходы:\t\t25%\t",
        "Основные расходы:\t-----------------------------\t25%\t",
        "Основные расходы:\t-----------------------------\t25%/25%\t",
        "Остаток с декабря\t693.424р31к\t\t",
        "Остаток с ноября \t684.753р85к\t\t",
        "Прочие расходы:\t\t15%\t",
        "Прочие расходы:\t\t15%\t16.5%",
        "Прочие расходы:\t\t8%\t",
        "Расходы на доставку:\t\t\t",
        "Расходы на доставку:\t-----------------------------\t\t",
        "Статья расхода:\tСумма расхода:\tПлан %\tФакт %",
        "Статья расхода:\tСумма расхода:\tПлан % \tФакт %",
        "Фактический остаток:\t-355.483р 36к\t20%\t",
        "Фактический остаток:\t-609.230р46к\t20%\t",
        "Фактический остаток:\t173.753 \t20%\t",
        "Фактический остаток:\t684.753р85к\t\t",
        "Фактический остаток:\t8.670р46к\t\t",
        "Фактический остаток:\t96.628р 63к\t20%\t",
        "Фактический остаток:\tМинус 113.901р89к\t20%\t",
        "Фактический остаток:\tМинус 145.292р59к\t20%\t",
        "Фактический остаток:\tМинус 243.103р18к\t20%\t",
        "Фактический остаток:\tМинус 277.306р 74к\t20%\t",
        "Фактический остаток:\tМинус 337.285р06к\t\t",
        "Фактический приход товара и оплата товара:\t\t25%\t",
        "Фактический приход товара и оплата товара:\t-----------------------------\t30%\t",
        "Фактический приход товара и оплата товара:\t946.056р\t25%\t",
        "Январь2020 \tОборот:2.307.231\tСредний показатель: 74.426",
        "Январь2021\tОборот факт:1.065.575\tСредний показатель:34.373"]

    static let allRows: [String] = firstPart + secondPart
}

