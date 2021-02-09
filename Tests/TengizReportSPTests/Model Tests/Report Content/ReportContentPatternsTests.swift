//
//  ReportContentPatternsTests.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 29.01.2021.
//

import XCTest
@testable import TengizReportSP

final class ReportContentPatternsTests: XCTestCase {
    func testReport_headerPattern() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.headerPattern, #"(?m)(^(.*)\n)+?(?=Статья расхода:)"#)

        // MARK: match
        XCTAssertEqual("""
            Название объекта: Саперави Аминьевка
            Декабрь2020     Оборот:2.318.274    Средний показатель: 74.783

            Статья расхода:\t
            """.firstMatch(for: Patterns.headerPattern),
                       "Название объекта: Саперави Аминьевка\nДекабрь2020     Оборот:2.318.274    Средний показатель: 74.783\n\n")

        // MARK: no match
        XCTAssertNil("""
            Название объекта: Саперави Аминьевка
            Декабрь2020     Оборот:2.318.274    Средний показатель: 74.783
            """.firstMatch(for: Patterns.headerPattern),
                     "No match without 'Статья расхода:'")

        XCTAssertNil("""
            1. Аренда торгового помещения     500.000 (за ноябрь)
            2. Эксплуатационные расходы    -----------------------------
            3. Электричество    -----------------------------
            4. Водоснабжение    -----------------------------
            """.firstMatch(for: Patterns.headerPattern),
                     "No match without 'Статья расхода:'")
    }

    func testReport_footerPattern() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.footerPattern, #"(?m)^ИТОГ всех расходов за месяц(?:.|\n)*$"#)

        // MARK: match
        XCTAssertEqual("""
            ИТОГ всех расходов за месяц:    2.432.175р89к

            Фактический остаток:    Минус 113.901р89к    20%
            Переходящий минус 1.065.596р 76к

            ИТОГ:    Минус 1.179.498р65к
            """.firstMatch(for: Patterns.footerPattern),
                       "ИТОГ всех расходов за месяц:    2.432.175р89к\n\nФактический остаток:    Минус 113.901р89к    20%\nПереходящий минус 1.065.596р 76к\n\nИТОГ:    Минус 1.179.498р65к")

        XCTAssertEqual("""
            ИТОГ:    19.131
            ИТОГ всех расходов за месяц:    2.432.175р89к

            Фактический остаток:    Минус 113.901р89к    20%
            Переходящий минус 1.065.596р 76к

            ИТОГ:    Минус 1.179.498р65к
            """.firstMatch(for: Patterns.footerPattern),
                       "ИТОГ всех расходов за месяц:    2.432.175р89к\n\nФактический остаток:    Минус 113.901р89к    20%\nПереходящий минус 1.065.596р 76к\n\nИТОГ:    Минус 1.179.498р65к")

        // MARK: no match
        XCTAssertNil("""

            Фактический остаток:    Минус 113.901р89к    20%
            Переходящий минус 1.065.596р 76к

            ИТОГ:    Минус 1.179.498р65к

            """.firstMatch(for: Patterns.footerPattern),
                     "No match without 'ИТОГ всех расходов за месяц:'")
    }

    func test_columnTitleRowPattern() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.columnTitleRowPattern,
                       #"(?m)^Статья расхода:\s*Сумма расхода:\s*План %\s*Факт %\s*\n"#)

        // MARK: match
        XCTAssertEqual("""
            Статья расхода:    Сумма расхода:    План %     Факт %\n
            """.firstMatch(for: Patterns.columnTitleRowPattern),
                       "Статья расхода:    Сумма расхода:    План %     Факт %\n")

        // MARK: no match
        XCTAssertNil("""
            1.ФОТ    595.360 ( за первую часть ноября)\n
            """.firstMatch(for: Patterns.columnTitleRowPattern))
    }

    func testReport_bodyPattern() {
        // MARK: pattern (regex)
        XCTAssertEqual(Patterns.bodyPattern,
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
            """.firstMatch(for: Patterns.bodyPattern),
                       "Статья расхода:    Сумма расхода:    План %     Факт %\nОсновные расходы:        20%\n1. Аренда торгового помещения     500.000 (за ноябрь)\n7. Вывоз мусора    -----------------------------\nИТОГ:    518.500")

        XCTAssertEqual("""
            Основные расходы:        20%
            1. Аренда торгового помещения     500.000 (за ноябрь)
            7. Вывоз мусора    -----------------------------
            ИТОГ:    518.500
            Зарплата:        20%
            ФОТ Бренд, логистика, бухгалтерия    99.000
            """.firstMatch(for: Patterns.bodyPattern),
                       "Основные расходы:        20%\n1. Аренда торгового помещения     500.000 (за ноябрь)\n7. Вывоз мусора    -----------------------------\nИТОГ:    518.500")

        XCTAssertEqual("""
            ИТОГ:    518.500
            Зарплата:        20%
            ФОТ Бренд, логистика, бухгалтерия    99.000
            ИТОГ:
            """.firstMatch(for: Patterns.bodyPattern),
                       "ИТОГ:    518.500\nЗарплата:        20%\nФОТ Бренд, логистика, бухгалтерия    99.000\nИТОГ:")

        // MARK: no match
        XCTAssertNil("""
            ИТОГ:    518.500
            Зарплата:        20%
            ФОТ Бренд, логистика, бухгалтерия    99.000
            """.firstMatch(for: Patterns.bodyPattern))
    }
}
