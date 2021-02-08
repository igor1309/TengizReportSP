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
        XCTAssertNotNil("""
            Название объекта: Саперави Аминьевка
            Декабрь2020     Оборот:2.318.274    Средний показатель: 74.783

            Статья расхода:\t
            """.firstMatch(for: Patterns.headerPattern))

        XCTAssertNil("""
            Название объекта: Саперави Аминьевка
            Декабрь2020     Оборот:2.318.274    Средний показатель: 74.783
            """.firstMatch(for: Patterns.headerPattern))

        XCTAssertNil("""
            1. Аренда торгового помещения     500.000 (за ноябрь)
            2. Эксплуатационные расходы    -----------------------------
            3. Электричество    -----------------------------
            4. Водоснабжение    -----------------------------
            """.firstMatch(for: Patterns.headerPattern))
    }

    func testReport_footerPattern() {
        XCTAssertNotNil("""
            ИТОГ всех расходов за месяц:    2.432.175р89к

            Фактический остаток:    Минус 113.901р89к    20%
            Переходящий минус 1.065.596р 76к

            ИТОГ:    Минус 1.179.498р65к
            """.firstMatch(for: Patterns.footerPattern))

        XCTAssertNotNil("""
            ИТОГ:    19.131
            ИТОГ всех расходов за месяц:    2.432.175р89к

            Фактический остаток:    Минус 113.901р89к    20%
            Переходящий минус 1.065.596р 76к

            ИТОГ:    Минус 1.179.498р65к
            """.firstMatch(for: Patterns.footerPattern))

        XCTAssertNil("""

            Фактический остаток:    Минус 113.901р89к    20%
            Переходящий минус 1.065.596р 76к

            ИТОГ:    Минус 1.179.498р65к

            """.firstMatch(for: Patterns.footerPattern))
    }

    func test_columnTitleRowPattern() {
        XCTAssertNotNil("""
            Статья расхода:    Сумма расхода:    План %     Факт %\n
            """.firstMatch(for: Patterns.columnTitleRowPattern))

        XCTAssertNil("""
            1.ФОТ    595.360 ( за первую часть ноября)\n
            """.firstMatch(for: Patterns.columnTitleRowPattern))
    }

    func testReport_bodyPattern() {
        XCTAssertNotNil("""
            Статья расхода:    Сумма расхода:    План %     Факт %
            Основные расходы:        20%
            1. Аренда торгового помещения     500.000 (за ноябрь)
            7. Вывоз мусора    -----------------------------
            ИТОГ:    518.500
            Зарплата:        20%
            ФОТ Бренд, логистика, бухгалтерия    99.000
            """.firstMatch(for: Patterns.bodyPattern))

        XCTAssertNotNil("""
            Основные расходы:        20%
            1. Аренда торгового помещения     500.000 (за ноябрь)
            7. Вывоз мусора    -----------------------------
            ИТОГ:    518.500
            Зарплата:        20%
            ФОТ Бренд, логистика, бухгалтерия    99.000
            """.firstMatch(for: Patterns.bodyPattern))

        XCTAssertNotNil("""
            ИТОГ:    518.500
            Зарплата:        20%
            ФОТ Бренд, логистика, бухгалтерия    99.000
            ИТОГ:
            """.firstMatch(for: Patterns.bodyPattern))

        XCTAssertNil("""
            ИТОГ:    518.500
            Зарплата:        20%
            ФОТ Бренд, логистика, бухгалтерия    99.000
            """.firstMatch(for: Patterns.bodyPattern))
    }
}
