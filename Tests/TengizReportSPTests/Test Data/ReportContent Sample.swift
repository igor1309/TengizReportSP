//
//  ReportContent Sample.swift
//  TextViewAppUnitTests
//
//  Created by Igor Malyarov on 06.01.2021.
//

import Foundation
@testable import TengizReportSP

extension ReportContent {
    static var sampleContents: [ReportContent] {
        [ReportContent.reportContent202006,
         ReportContent.reportContent202007,
         ReportContent.reportContent202008,
         ReportContent.reportContent202009,
         ReportContent.reportContent202010,
         ReportContent.reportContent202011,
         ReportContent.reportContent202012,
         ReportContent.reportContent202013,
         ReportContent.reportContent202014
        ]
    }

    static var reportContent202006: ReportContent {
        ReportContent(
            header: [
                "Название объекта: Саперави Аминьевка",
                "Месяц: июнь2020 (с 24 по 30 июня)",
                "Оборот:266.285",
                "Средний показатель: 38.040"
                ],
            body: [
                "Основные расходы:\t\t25%\t\n1. Аренда торгового помещения\t-----------------------------\t\t\n2. Эксплуатационные расходы\t-----------------------------\t\t\n3. Электричество\t-----------------------------\t\t\n4. Водоснабжение\t-----------------------------\t\t\n5. Аренда головного офиса\t11.500\t\t\n6. Аренда головного склада\t-----------------------------\t\t\n7.Вывоз мусора\t-----------------------------\t\t\nИТОГ:\t11.500\t\t",
                "Зарплата:\t\t22%\t\n1.ФОТ\t19.721 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)\t\t\n\t\t\t\n\t\t\t\nИТОГ:\t19.721\t\t",
                "Фактический приход товара и оплата товара:\t\t25%\t\n1. Приход товара по накладным\t451.198р41к (из них у нас оплачено фактический 21.346р15к)\t\t\n2. Предоплаченный товар, но не отраженный в приходе\t15.800\t\t\nИТОГ:\t37.146р15к\t\t",
                "Прочие расходы:\t\t8%\t\n1.Налоговые платежи \t----------------------------\t\t\n2.Банковское обслуживание\t4.544\t\t\n3.Юридическое сопровождение\t-----------------------------\t\t\n4.Банковская комиссия 1.6% за эквайринг\t2.120\t\t\n5. Тайный гость\t-----------------------------\t\t\n6.Обслуживание кассовой программы\t----------------------------\t\t\n7. Обслуживание хостинга\t----------------------------\t\t\n8.Обслуживание мобильного приложения\t----------------------------\t\t\n9. Реклама и IT поддержка\t16.300\t\t\n10.Обслуживание пожарной охраны\t-----------------------------\t\t\n11.Вневедомственная охрана помещения\t-----------------------------\t\t\n12.Интернет\t-----------------------------\t\t\n13.Дезобработка помещения\t-----------------------------\t\t\n14.-----------------------------------------------------------------\t-----------------------------\t\t\n15.Аренда зарядных устройств и раций\t-----------------------------\t\t\n16. Текущие мелкие расходы \t1.200\t\t\n17. Обслуживание Жироуловителей\t-----------------------------\t\t\n18. -----------------------------------------------------------------\t-----------------------------\t\t\n19. Ремонт оборудования\t-----------------------------\t\t\n20. Чистка вентиляции\t-----------------------------\t\t\n21. Обслуживание банкетов\t-----------------------------\t\t\nИТОГ:\t24.164\t\t",
                "Расходы на доставку:\t\t\t\n1. Курьеры\t-----------------------------\t\t\n2. Агрегаторы\t-----------------------------\t\t\nИТОГ:\t\t\t"
            ],
            footer: [
                "ИТОГ всех расходов за месяц:\t92.531р15к",
                "Фактический остаток:\t173.753 \t20%"
            ]
        )
    }

    static var reportContent202007: ReportContent {
        ReportContent(
            header: [
                "Название объекта: Саперави Аминьевка",
                "Месяц: июль2020",
                "Оборот:1.067.807",
                "Средний показатель: 34.445"
            ],
            body: [
                "Основные расходы:\t\t25%\t\n1. Аренда торгового помещения\t46.667 (за июнь)\t\t\n2. Эксплуатационные расходы\t-----------------------------\t\t\n3. Электричество\t-----------------------------\t\t\n4. Водоснабжение\t-----------------------------\t\t\n5. Аренда головного офиса\t11.500\t\t\n6. Аренда головного склада\t7.000\t\t\n7. Вывоз мусора\t-----------------------------\t\t\nИТОГ:\t65.167\t\t",
                "Зарплата:\t\t22%\t\n1.ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)\t\t\nФОТ Бренд, логистика, бухгалтерия\t99.000\t\t\n\t\t\t\nИТОГ:\t803.848\t\t",
                "Фактический приход товара и оплата товара:\t\t25%\t\n1. Приход товара по накладным\t922.936р37к (оплаты фактические: 313.570р26к-переводы; 87.091р20к-корпоративная карта; 97.712-наличные из кассы; Итого-498.373р46к)\t\t\n2. Предоплаченный товар, но не отраженный в приходе\tБейсболки персонал-18.000; Подушки в зал-22.400; Итого-40.400\t\t\nИТОГ:\t538.773р46к\t\t",
                "Прочие расходы:\t\t8%\t\n1.Налоговые платежи \t13.318р93к\t\t\n2.Банковское обслуживание\t5.778\t\t\n3.Юридическое сопровождение\t20.000\t\t\n4.Банковская комиссия 1.6% за эквайринг\t12.785\t\t\n5. Тайный гость\t-----------------------------\t\t\n6.Обслуживание кассовой программы\t21.806р20к\t\t\n7. Обслуживание хостинга\t----------------------------\t\t\n8.Обслуживание мобильного приложения\t----------------------------\t\t\n9. Реклама и IT поддержка\t104.000\t\t\n10.Обслуживание пожарной охраны\t-----------------------------\t\t\n11.Вневедомственная охрана помещения\t-----------------------------\t\t\n12.Интернет\t-----------------------------\t\t\n13.Дезобработка помещения\t-----------------------------\t\t\n14. Контур (эл.отчетность)\t3.000\t\t\n15.Аренда зарядных устройств и раций\t-----------------------------\t\t\n16. Текущие мелкие расходы \t2.910\t\t\n17. Обслуживание Жироуловителей\t-----------------------------\t\t\n18. Регистрация Кассового аппарата (запасной)\t2.000\t\t\n19. Ремонт оборудования\t-----------------------------\t\t\n20. Чистка вентиляции\t-----------------------------\t\t\n21. Обслуживание банкетов\t-----------------------------\t\t\n22. Хэдхантер (подбор пероснала)\t3.240\t\t\n23. Аудит кантора (Бухуслуги)\t60.000\t\t\n24. Столы Тенгиза\t6.100\t\t\n25. Стол Игорь\t5.470\t\t\n26. Вино отправляли в подарок\t1.900\t\t\nИТОГ:\t262.308\t\t",
                "Расходы на доставку:\t\t\t\n1. Курьеры\t-----------------------------\t\t\n2. Агрегаторы\t6.981\t\t\nИТОГ:\t6.981\t\t"
            ],
            footer: ["ИТОГ всех расходов за месяц:\t1.677.077р46к", "Фактический остаток:\t-609.230р46к\t20%", "-173.753 остаток с июня", "-28.000 субсидия, поступила в июле", "ИТОГ:\t-407.477р46к"]
        )
    }

    static var reportContent202008: ReportContent {
        ReportContent(
            header: [
                "Название объекта: Саперави Аминьевка",
                "Месяц: август2020",
                "Оборот:1.738.788",
                "Средний показатель: 56.089"
                ],
            body: [
                "Основные расходы:\t\t20%\t12.56%\n1. Аренда торгового помещения\t 200.000 (за июль)\t\t\n2. Эксплуатационные расходы\t-----------------------------\t\t\n3. Электричество\t-----------------------------\t\t\n4. Водоснабжение\t-----------------------------\t\t\n5. Аренда головного офиса\t11.500\t\t\n6. Аренда головного склада\t7.000\t\t\n7. Вывоз мусора\t-----------------------------\t\t\nИТОГ:\t218.500\t\t",
                "Зарплата:\t\t20%\t57.13%\n1.ФОТ\t 894.510( за вторую часть июля и первая часть августа)\t\t\nФОТ Бренд, логистика, бухгалтерия\t99.000\t\t\n\t-10.000 за перерасход питание персонала в июле\t\t\nИТОГ:\t983.510\t\t",
                "Фактический приход товара и оплата товара:\t\t25%\t\n1. Приход товара по накладным\t 753.950р74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого-521.519р 36к)\t\t\n2. Предоплаченный товар, но не отраженный в приходе\t КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого-23.600\t\t\nИТОГ:\t545.119р 36к\t\t",
                "Прочие расходы:\t\t15%\t\n1.Налоговые платежи \t20.614\t\t\n2.Банковское обслуживание\t7.234\t\t\n3.Юридическое сопровождение\t40.000\t\t\n4.Банковская комиссия 1.6% за эквайринг\t19.769\t\t\n5.Тайный гость\t-----------------------------\t\t\n6.Обслуживание кассовой программы\t14.866\t\t\n7.Обслуживание хостинга\t----------------------------\t\t\n8.Обслуживание мобильного приложения\t----------------------------\t\t\n9.Реклама и IT поддержка\t53.500\t\t\n10.Обслуживание пожарной охраны\t-----------------------------\t\t\n11.Вневедомственная охрана помещения\t-----------------------------\t\t\n12.Интернет\t7.701+4.500\t\t\n13.Дезобработка помещения\t-----------------------------\t\t\n14. РПК Ника (крепления д/телевизоров и монтаж)\t30.000\t\t\n15.Аренда зарядных устройств и раций\t5.000\t\t\n16. Текущие мелкие расходы \t2.250\t\t\n17. Обслуживание Жироуловителей\t-----------------------------\t\t\n18. Аренда оборудования д/питьевой воды\t5.130\t\t\n19. Ремонт оборудования\t-----------------------------\t\t\n20. Чистка вентиляции\t-----------------------------\t\t\n21. Обслуживание банкетов\t-----------------------------\t\t\n22. Хэдхантер (подбор пероснала)\t----------------------------\t\t\n23. Аудит кантора (Бухуслуги)\t60.000\t\t\n24. Стол Тенгиз\t10.552\t\t\n25. Стол Игорь\t45.440\t\t\n26. ---------------------------------\t-----------------------------\t\t\nИТОГ:\t326.556\t\t",
                "Расходы на доставку:\t\t\t\n1. Курьеры\t-----------------------------\t\t\n2. Агрегаторы\t20.586\t\t\nИТОГ:\t20.586\t\t"
            ],
            footer: ["ИТОГ всех расходов за месяц:\t2.094.271р 36к", "Фактический остаток:\t-355.483р 36к\t20%", "Минус с июля 407.477р 46 к., переходит", "+23.334р 76к остаток с инвестиций", "ИТОГ:\t-739.626р 06к"]
        )
    }

    static var reportContent202009: ReportContent {
        ReportContent(
            header: [
                "Название объекта: Саперави Аминьевка",
                "Месяц: сентябрь2020",
                "Оборот:2.440.021",
                "Средний показатель: 81.334"
                ],
            body: [
                "Основные расходы:\t\t20%\t8.95%\n1. Аренда торгового помещения\t 200.000 (за август)\t\t\n2. Эксплуатационные расходы\t-----------------------------\t\t\n3. Электричество\t-----------------------------\t\t\n4. Водоснабжение\t-----------------------------\t\t\n\t\t\t\n5. Аренда головного офиса\t11.500\t\t\n6. Аренда головного склада\t7.000\t\t\n7. Вывоз мусора\t-----------------------------\t\t\nИТОГ:\t218.500\t\t",
                "Зарплата:\t\t20%\t43.4%\n1.ФОТ\t 960.056( за вторую часть августа и первую  часть сентября)\t\t\n\t\t\t\nФОТ Бренд, логистика, бухгалтерия\t99.000\t\t\n\t\t\t\nИТОГ:\t1.059.056\t\t",
                "Фактический приход товара и оплата товара:\t946.056р\t25%\t\n1. Приход товара по накладным\t 946.056р (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого-632.684р 37к)\t\t\n2. Предоплаченный товар, но не отраженный в приходе\tСтудиопак-12.500 (влажные салфетки);\t\t\nИТОГ:\t645.184р37к\t\t",
                "Прочие расходы:\t\t15%\t16.5%\n1.Налоговые платежи \t26.964\t\t\n2.Банковское обслуживание\t6.419\t\t\n3.Юридическое сопровождение\t40.000\t\t\n4.Банковская комиссия 1.6% за эквайринг\t26.581\t\t\n5.Тайный гость\t-----------------------------\t\t\n6.Обслуживание кассовой программы Айко\t16.336\t\t\n7.Обслуживание хостинга\t----------------------------\t\t\n8.Обслуживание мобильного приложения\t9.200\t\t\n9.Реклама и IT поддержка\t65.000\t\t\n10.Обслуживание пожарной охраны\t-----------------------------\t\t\n11.Вневедомственная охрана помещения\t-----------------------------\t\t\n12.Интернет\t9.000\t\t\n13.Дезобработка помещения\t-----------------------------\t\t\n14. ----------------------------------\t----------------------------\t\t\n15.Аренда зарядных устройств и раций\t----------------------------\t\t\n16. Текущие мелкие расходы \t1.600\t\t\n17. Обслуживание Жироуловителей\t-----------------------------\t\t\n18. Аренда оборудования д/питьевой воды\t-----------------------------\t\t\n19. Ремонт оборудования\t-----------------------------\t\t\n20. Чистка вентиляции\t26.250\t\t\n21. Обслуживание банкетов\t15.250\t\t\n22. Хэдхантер (подбор пероснала)\t9.720\t\t\n23. Аудит кантора (Бухуслуги)\t60.000\t\t\n24. Стол Тенгиз\t17.905\t\t\n25. Стол Игорь\t47.090\t\t\n26. Стол Андрей\t9.550\t\t\n27. Сервис Гуру (система аттестации, за 1 год)\t12.655\t\t\nИТОГ:\t402.520\t\t",
                "Расходы на доставку:\t\t\t\n1. Курьеры\t-----------------------------\t\t\n2. Агрегаторы\t18.132\t\t\nИТОГ:\t18.132\t\t"
            ],
            footer: ["ИТОГ всех расходов за месяц:\t2.343.392р 37к", "Фактический остаток:\t96.628р 63к\t20%", "Минус с августа переходит 739.626р 06к", "ИТОГ:\tМинус 642.997р 43к"]
        )
    }

    static var reportContent202010: ReportContent {
        ReportContent(
            header: [
                "Название объекта: Саперави Аминьевка",
                "Октябрь2020",
                "Оборот:2.587.735",
                "Средний показатель: 83.475"
                ],
            body: [
                "Основные расходы:\t\t20%\t\n1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)\t\t\n2. Эксплуатационные расходы\t-----------------------------\t\t\n3. Электричество\t-----------------------------\t\t\n4. Водоснабжение\t-----------------------------\t\t\n5. Аренда головного офиса\t11.500\t\t\n6. Аренда головного склада\t7.000\t\t\n7. Вывоз мусора\t-----------------------------\t\t\nИТОГ:\t618.500\t\t",
                "Зарплата:\t\t20%\t\n1.ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)\t\t\nФОТ Бренд, логистика, бухгалтерия\t99.000\t\t\n\t\t\t\nИТОГ:\t1.246.085\t\t",
                "Фактический приход товара и оплата товара:\t\t25%\t\n1. Приход товара по накладным\t 907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого-628.215р 74к)\t\t\n2. Предоплаченный товар, но не отраженный в приходе\t\t\t\nИТОГ:\t628.215р 74к\t\t",
                "Прочие расходы:\t\t15%\t\n1.Налоговые платежи \t35.311\t\t\n2.Банковское обслуживание\t6.279\t\t\n3.Юридическое сопровождение\t40.000\t\t\n4.Банковская комиссия 1.6% за эквайринг\t31.587\t\t\n5.Тайный гость\t-----------------------------\t\t\n6.Обслуживание кассовой программы Айко\t8.435\t\t\n7.Обслуживание хостинга\t----------------------------\t\t\n8.Обслуживание мобильного приложения\t9.200\t\t\n9.Реклама и IT поддержка\t85.000\t\t\n10.Обслуживание пожарной охраны\t-----------------------------\t\t\n11.Вневедомственная охрана помещения\t-----------------------------\t\t\n12.Интернет\t----------------------------\t\t\n13.Дезобработка помещения\t-----------------------------\t\t\n14. Вышивка логотипа на одежде\t2.836\t\t\n15.Аренда зарядных устройств и раций\t10.000\t\t\n16. Текущие мелкие расходы \t5.460\t\t\n17. Обслуживание Жироуловителей\t-----------------------------\t\t\n18. Аренда оборудования д/питьевой воды\t5.130\t\t\n19. Ремонт оборудования\t6.610\t\t\n20. Чистка вентиляции\t35.000\t\t\n21. Обслуживание банкетов\t5.625\t\t\n22. Хэдхантер (подбор пероснала)\t4.227\t\t\n23. Аудит кантора (Бухуслуги)\t60.000\t\t\n24. ---------\t-------------\t\t\n25. --------\t-------------\t\t\n26. ---------\t-------------\t\t\n27. ---------\t------------\t\t\nИТОГ:\t350.700\t\t",
                "Расходы на доставку:\t\t\t\n1. Курьеры\t-----------------------------\t\t\n2. Агрегаторы\t21.541\t\t\nИТОГ:\t21.541\t\t"
            ],
            footer: [
                "ИТОГ всех расходов за месяц:\t2.865.042р 74к",
                "Фактический остаток:\tМинус 277.306р 74к\t20%",
                "Переходит минус с сентября 642.997р 43к",
                "ИТОГ:\tМинус 920.304р 17к"
            ]
        )
    }

    static var reportContent202011: ReportContent {
        ReportContent(
            header: [
                "Название объекта: Саперави Аминьевка",
                "Ноябрь2020",
                "Оборот:1.885.280",
                "Средний показатель: 62.842"
                ],
            body: [
                "Основные расходы:\t\t20%\t\n1. Аренда торгового помещения\t 500.000 (за октябрь)\t\t\n2. Эксплуатационные расходы\t-----------------------------\t\t\n3. Электричество\t-----------------------------\t\t\n4. Водоснабжение\t-----------------------------\t\t\n5. Аренда головного офиса\t11.500\t\t\n6. Аренда головного склада\t7.000\t\t\n7. Вывоз мусора\t-----------------------------\t\t\nИТОГ:\t518.500\t\t",
                "Зарплата:\t\t20%\t\n1.ФОТ\t 564.678( за вторую часть октября) \t\t\nФОТ Бренд, логистика, бухгалтерия\t99.000\t\t\n\t\t\t\nИТОГ:\t663.678\t\t",
                "Фактический приход товара и оплата товара:\t\t25%\t\n1. Приход товара по накладным\t 739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого-437.474р 47к)\t\t\n2. Предоплаченный товар, но не отраженный в приходе\t--------------\t\t\nИТОГ:\t437.474р47к\t\t",
                "Прочие расходы:\t\t15%\t\n1.Налоговые платежи \t31.949р38к\t\t\n2.Банковское обслуживание\t5.863р74к\t\t\n3.Юридическое сопровождение\t40.000\t\t\n4.Банковская комиссия 1.6% за эквайринг\t22.653\t\t\n5.Тайный гость\t-----------------------------\t\t\n6.Обслуживание кассовой программы Айко\t12.000\t\t\n7.Обслуживание хостинга\t----------------------------\t\t\n8.Обслуживание мобильного приложения\t9.200\t\t\n9.Реклама и IT поддержка\t90.000\t\t\n10.Обслуживание пожарной охраны\t-----------------------------\t\t\n11.Вневедомственная охрана помещения\t-----------------------------\t\t\n12.Интернет\t4.500\t\t\n13.Дезобработка помещения\t-----------------------------\t\t\n14. Поверка весов\t3.400\t\t\n15.Аренда зарядных устройств и раций\t5.000\t\t\n16. Текущие мелкие расходы \t6.690\t\t\n17. Обслуживание Жироуловителей\t-----------------------------\t\t\n18. Аренда оборудования д/питьевой воды\t5.130\t\t\n19. Ремонт оборудования\t\t\t\n20. Чистка вентиляции\t35.000\t\t\n21. Обслуживание банкетов\t\t\t\n22. Хэдхантер (подбор пероснала)\t9.720\t\t\n23. Аудит кантора (Бухуслуги)\t60.000\t\t\n24. Яндекс карты\t51.975\t\t\n25. --------\t-------------\t\t\n26. ---------\t-------------\t\t\n27. ---------\t------------\t\t\nИТОГ:\t393.081р12к\t\t",
                "Расходы на доставку:\t\t\t\n1. Курьеры\t-----------------------------\t\t\n2. Агрегаторы\t17.839\t\t\nИТОГ:\t17.839\t\t"
            ],
            footer: ["ИТОГ всех расходов за месяц:\t2.030.572р59к", "Фактический остаток:\tМинус 145.292р59к\t20%", "Переходящий минус 920.304р 17к", "ИТОГ:\tМинус 1.065.596р 76к"]
        )
    }

    static var reportContent202012: ReportContent {
        ReportContent(
            header: [
                "Название объекта: Саперави Аминьевка",
                "Декабрь2020",
                "Оборот:2.318.274",
                "Средний показатель: 74.783"
                ],
            body: ["Основные расходы:\t\t20%\t\n1. Аренда торгового помещения\t 500.000 (за ноябрь)\t\t\n2. Эксплуатационные расходы\t-----------------------------\t\t\n3. Электричество\t-----------------------------\t\t\n4. Водоснабжение\t-----------------------------\t\t\n5. Аренда головного офиса\t11.500\t\t\n6. Аренда головного склада\t7.000\t\t\n7. Вывоз мусора\t-----------------------------\t\t\nИТОГ:\t518.500\t\t", "Зарплата:\t\t20%\t\n1.ФОТ\t595.360 ( за первую часть ноября) \t\t\nФОТ Бренд, логистика, бухгалтерия\t99.000\t\t\n\t\t\t\nИТОГ:\t694.360\t\t", "Фактический приход товара и оплата товара:\t\t25%\t\n1. Приход товара по накладным\t 997.446р; (оплаты фактические: 491.114р 65к -переводы; 114.589р -корпоративная карта; 12.170р -наличные из кассы; Итого-617.873р 65к)\t\t\n2. Предоплаченный товар, но не отраженный в приходе\t--------------\t\t\nИТОГ:\t617.873р65к\t\t", "Прочие расходы:\t\t15%\t\n1.Налоговые платежи \t22.895р38к\t\t\n2.Банковское обслуживание\t7.473р86к\t\t\n3.Юридическое сопровождение\t40.000\t\t\n4.Банковская комиссия 1.6% за эквайринг\t26.915\t\t\n5.Тайный гость\t-----------------------------\t\t\n6.Обслуживание кассовой программы Айко\t4.500+8.700+15.995\t\t\n7.Обслуживание хостинга\t----------------------------\t\t\n8.Печать рекламных буклетов и их раздача\t7.300\t\t\n9.Реклама и IT поддержка\t82.000\t\t\n10.Обслуживание пожарной охраны\t-----------------------------\t\t\n11.Вневедомственная охрана помещения\t-----------------------------\t\t\n12.Интернет\t4.500\t\t\n13.Дезобработка помещения\t-----------------------------\t\t\n14. Облачная касса для доставки через сайт\t36.000\t\t\n15.Аренда зарядных устройств и раций\t5.000\t\t\n16. Текущие мелкие расходы \t2.600\t\t\n17. Обслуживание Жироуловителей\t-----------------------------\t\t\n18. Аренда оборудования д/питьевой воды\t5.130\t\t\n19. Ремонт оборудования\t----------------------\t\t\n20. Чистка вентиляции\t35.000\t\t\n21. Обслуживание банкетов\t6.750\t\t\n22. Хэдхантер (подбор пероснала)\t9.720\t\t\n23. Аудит кантора (Бухуслуги)\t60.000\t\t\n24. Корректировка ЕГАИС\t10.000\t\t\n25. Игорь стол\t22.130\t\t\n26. Новогодний декор\t169.702\t\t\n27. ---------\t------------\t\t\nИТОГ:\t582.311р24к\t\t", "Расходы на доставку:\t\t\t\n1. Курьеры\t4.700\t\t\n2. Агрегаторы\t14.431\t\t\nИТОГ:\t19.131\t\t"],
            footer: [
                "ИТОГ всех расходов за месяц:\t2.432.175р89к",
                "Фактический остаток:\tМинус 113.901р89к\t20%",
                "Переходящий минус 1.065.596р 76к",
                "ИТОГ:\tМинус 1.179.498р65к"
            ]
        )
    }

    static var reportContent202013: ReportContent {
        ReportContent(
            header: [
                "ВМ ЩК",
                "Октябрь+Ноябрь2020",
                "Оборот факт:141.690+1.238.900=1.380.590",
                "Средний показатель:41.836"
                ],
            body: ["Основные расходы:\t-----------------------------\t25%/25%\t\n1. Аренда торгового помещения\t-----------------------------\t\t\n2. Эксплуатационные расходы\t-----------------------------\t\t\n3. Электричество\t------------------------------\t\t\n4. Водоснабжение\t-----------------------------\t\t\n5. Аренда головного офиса\t11.500\t\t\n6. Аренда головного склада\t-----------------------------\t\t\n7.Вывоз мусора\t15.800\t\t\nИТОГ:\t27.300\t\t", "Зарплата:\t-----------------------------\t20%\t\n1.ФОТ общий\t67.894\t\t\n2. ФОТ Бренд, логистика, бухгалтерия\t90.000\t\t\n----------------------------------------------------------------------\t-----------------------------\t\t\nИТОГ:\t157.894\t\t", "Фактический приход товара и оплата товара:\t-----------------------------\t30%\t\n1. Приход товара по накладным\t179.108р89к+512.293р(оплаты фактические:199.803р80к-переводы;81.225р35к-корпоративная карта;34.202р-наличные из кассы; Итого-315.231р15к)\t\t\n\t\t\t\nИТОГ:\t315.231р15к\t\t", "Прочие расходы:\t\t8%\t\n1.Налоговые платежи \t-----------------------------\t\t\n2.Банковское обслуживание\t2.514\t\t\n3.--------------------------------------\t-----------------------------\t\t\n4.Банковская комиссия 1.6% за эквайринг\t15.963\t\t\n5.Юридическое сопровождение\t40.000\t\t\n6.Обслуживание кассовой программы\t11.500\t\t\n7. Обслуживание хостинга\t2.500\t\t\n8.Аудит Кантора (бухуслуги)\t60.000\t\t\n9. Реклама и IT поддержка\t75.000\t\t\n10.-----------------------\t----------------\t\t\n11. -----------------------\t-----------------\t\t\n12.Интернет\t6.065\t\t\n13.Дезобработка помещения\t---------------------\t\t\n14.Ремонт оборудования\t--------------------\t\t\n15.Ремонт и чистка вентиляции\t---------------------\t\t\n16. Текущие мелкие расходы\t1.000\t\t\n17. Чистка жироуловителей и канализации\t---------------------\t\t\n18. Маркетинговый платеж\t--------------------\t\t\n19. ----------------------\t-----------------\t\t\n20. ----------------------\t----------------\t\t\n21. -----------------------\t---------------\t\t\nИТОГ:\t214.542\t\t", "Расходы на доставку:\t-----------------------------\t\t\n1. Курьеры\t-----------------------------\t\t\n2. Агрегаторы\t8.169\t\t\nИТОГ:\t8.169\t\t"],
            footer: ["ИТОГ всех расходов за месяц:\t695.836р15к", "Фактический остаток:\t684.753р85к", "ИТОГ:\t684.753р85к переносится на декабрь месяц"]
        )
    }

    static var reportContent202014: ReportContent {
        ReportContent(
            header: [
                "ВМ ЩК",
                "Декабрь2020",
                "Оборот факт:929.625",
                "Средний показатель:29.987"
                ],
            body: ["Основные расходы:\t-----------------------------\t25%\t\n1. Аренда торгового помещения\t-----------------------------\t\t\n2. Эксплуатационные расходы\t-----------------------------\t\t\n3. Электричество\t------------------------------\t\t\n4. Водоснабжение\t-----------------------------\t\t\n5. Аренда головного офиса\t11.500\t\t\n6. Аренда головного склада\t-----------------------------\t\t\n7.Вывоз мусора\t18.000\t\t\nИТОГ:\t29.500\t\t", "Зарплата:\t-----------------------------\t20%\t\n1.ФОТ общий\t261.978\t\t\n2. ФОТ Бренд, логистика, бухгалтерия\t90.000\t\t\n----------------------------------------------------------------------\t-----------------------------\t\t\nИТОГ:\t351.978\t\t", "Фактический приход товара и оплата товара:\t-----------------------------\t30%\t\n1. Приход товара по накладным\t473.128р43к(оплаты фактические:231.572р46к-переводы;51.104р93к-корпоративная карта;2.799р-наличные из кассы; Итого-285.476р39к)\t\t\n\t\t\t\nИТОГ:\t285.476р39к\t\t", "Прочие расходы:\t\t8%\t\n1.Налоговые платежи \t22.282р86к\t\t\n2.Банковское обслуживание\t2.344р29к\t\t\n3.--------------------------------------\t-----------------------------\t\t\n4.Банковская комиссия 1.6% за эквайринг\t12.111\t\t\n5.Юридическое сопровождение\t40.000\t\t\n6.Обслуживание кассовой программы\t15.995\t\t\n7. Обслуживание хостинга\t2.500\t\t\n8.Аудит Кантора (бухуслуги)\t60.000\t\t\n9. Реклама и IT поддержка\t59.200\t\t\n10.-----------------------\t----------------\t\t\n11. -----------------------\t-----------------\t\t\n12.Интернет\t3.500\t\t\n13.Дезобработка помещения\t---------------------\t\t\n14.Ремонт оборудования\t--------------------\t\t\n15.Ремонт и чистка вентиляции\t15.000\t\t\n16. Текущие мелкие расходы\t1.400\t\t\n17. Чистка жироуловителей и канализации\t10.139\t\t\n18. Маркетинговый платеж\t--------------------\t\t\n19. ----------------------\t-----------------\t\t\n20. ----------------------\t----------------\t\t\n21. -----------------------\t---------------\t\t\nИТОГ:\t244.472р15к\t\t", "Расходы на доставку:\t-----------------------------\t\t\n1. Курьеры\t-----------------------------\t\t\n2. Агрегаторы\t9.528\t\t\nИТОГ:\t9.528\t\t"],
            footer: [
                "ИТОГ всех расходов за месяц:\t920.954р54к",
                "Фактический остаток:\t8.670р46к",
                "Остаток с ноября \t684.753р85к",
                "ИТОГ:\t693.424р31к переносим на январь"
            ])
    }

}

