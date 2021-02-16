//
//  Sources.swift
//  TengizReportSPTests
//
//  Created by Igor Malyarov on 03.02.2021.
//

import Foundation

let lines = [
    "Основные расходы:\t\t25%",
    "1. Аренда торгового помещения\t-----------------------------",
    "2. Эксплуатационные расходы\t-----------------------------",
    "3. Электричество\t-----------------------------",
    "4. Водоснабжение\t-----------------------------",
    "5. Аренда головного офиса\t11.500",
    "6. Аренда головного склада\t-----------------------------",
    "7. Вывоз мусора\t-----------------------------",
    "ИТОГ:\t11.500",
    "Зарплата:\t\t22%",
    "1. ФОТ\t19.721 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)",
    "ИТОГ:\t19.721",
    "Фактический приход товара и оплата товара:\t\t25%",
    "1. Приход товара по накладным\t451.198р 41к (из них у нас оплачено фактический 21.346р 15к)",
    "2. Предоплаченный товар, но не отраженный в приходе\t15.800",
    "ИТОГ:\t37.146р 15к",
    "Прочие расходы:\t\t8%",
    "1. Налоговые платежи \t----------------------------",
    "2. Банковское обслуживание\t4.544",
    "3. Юридическое сопровождение\t-----------------------------",
    "4. Банковская комиссия 1.6% за эквайринг\t2.120",
    "5. Тайный гость\t-----------------------------",
    "6. Обслуживание кассовой программы\t----------------------------",
    "7. Обслуживание хостинга\t----------------------------",
    "8. Обслуживание мобильного приложения\t----------------------------",
    "9. Реклама и IT поддержка\t16.300",
    "10. Обслуживание пожарной охраны\t-----------------------------",
    "11. Вневедомственная охрана помещения\t-----------------------------",
    "12. Интернет\t-----------------------------",
    "13. Дезобработка помещения\t-----------------------------",
    "14.-----------------------------------------------------------------\t-----------------------------",
    "15. Аренда зарядных устройств и раций\t-----------------------------",
    "16. Текущие мелкие расходы \t1.200",
    "17. Обслуживание Жироуловителей\t-----------------------------",
    "18. -----------------------------------------------------------------\t-----------------------------",
    "19. Ремонт оборудования\t-----------------------------",
    "20. Чистка вентиляции\t-----------------------------",
    "21. Обслуживание банкетов\t-----------------------------",
    "ИТОГ:\t24.164",
    "Расходы на доставку:\t\t\t",
    "1. Курьеры\t-----------------------------",
    "2. Агрегаторы\t-----------------------------",
    "ИТОГ:",
    "Основные расходы:\t\t25%",
    "1. Аренда торгового помещения\t46.667 (за июнь)",
    "2. Эксплуатационные расходы\t-----------------------------",
    "3. Электричество\t-----------------------------",
    "4. Водоснабжение\t-----------------------------",
    "5. Аренда головного офиса\t11.500",
    "6. Аренда головного склада\t7.000",
    "7. Вывоз мусора\t-----------------------------",
    "ИТОГ:\t65.167",
    "Зарплата:\t\t22%",
    "1. ФОТ\t 704.848 ( за вторую часть июня мы выдаем с 10 по 15 июля, а первая часть июля с 25 по 30 июля)",
    "2. ФОТ Бренд, логистика, бухгалтерия\t99.000",
    "ИТОГ:\t803.848",
    "Фактический приход товара и оплата товара:\t\t25%",
    "1. Приход товара по накладным\t922.936р 37к (оплаты фактические: 313.570р 26к-переводы; 87.091р 20к-корпоративная карта; 97.712-наличные из кассы; Итого 498.373р 46к)",
    "2. Предоплаченный товар, но не отраженный в приходе\tБейсболки персонал-18.000; Подушки в зал-22.400; Итого 40.400",
    "ИТОГ:\t538.773р 46к",
    "Прочие расходы:\t\t8%",
    "1. Налоговые платежи \t13.318р 93к",
    "2. Банковское обслуживание\t5.778",
    "3. Юридическое сопровождение\t20.000",
    "4. Банковская комиссия 1.6% за эквайринг\t12.785",
    "5. Тайный гость\t-----------------------------",
    "6. Обслуживание кассовой программы\t21.806р 20к",
    "7. Обслуживание хостинга\t----------------------------",
    "8. Обслуживание мобильного приложения\t----------------------------",
    "9. Реклама и IT поддержка\t104.000",
    "10. Обслуживание пожарной охраны\t-----------------------------",
    "11. Вневедомственная охрана помещения\t-----------------------------",
    "12. Интернет\t-----------------------------",
    "13. Дезобработка помещения\t-----------------------------",
    "14. Контур (эл.отчетность)\t3.000",
    "15. Аренда зарядных устройств и раций\t-----------------------------",
    "16. Текущие мелкие расходы \t2.910",
    "17. Обслуживание Жироуловителей\t-----------------------------",
    "18. Регистрация Кассового аппарата (запасной)\t2.000",
    "19. Ремонт оборудования\t-----------------------------",
    "20. Чистка вентиляции\t-----------------------------",
    "21. Обслуживание банкетов\t-----------------------------",
    "22. Хэдхантер (подбор пероснала)\t3.240",
    "23. Аудит кантора (Бухуслуги)\t60.000",
    "24. Столы Тенгиза\t6.100",
    "25. Стол Игорь\t5.470",
    "26. Вино отправляли в подарок\t1.900",
    "ИТОГ:\t262.308",
    "Расходы на доставку:\t\t\t",
    "1. Курьеры\t-----------------------------",
    "2. Агрегаторы\t6.981",
    "ИТОГ:\t6.981",
    "Основные расходы:\t\t20%\t12.56%",
    "1. Аренда торгового помещения\t 200.000 (за июль)",
    "2. Эксплуатационные расходы\t-----------------------------",
    "3. Электричество\t-----------------------------",
    "4. Водоснабжение\t-----------------------------",
    "5. Аренда головного офиса\t11.500",
    "6. Аренда головного склада\t7.000",
    "7. Вывоз мусора\t-----------------------------",
    "ИТОГ:\t218.500",
    "Зарплата:\t\t20%\t57.13%",
    "1. ФОТ\t 894.510( за вторую часть июля и первая часть августа)",
    "2. ФОТ Бренд, логистика, бухгалтерия\t99.000",
    "-10.000 за перерасход питание персонала в июле",
    "ИТОГ:\t983.510",
    "Фактический приход товара и оплата товара:\t\t25%",
    "1. Приход товара по накладным\t 753.950р 74к(оплаты фактические: 444.719р 16к -переводы; 75.255р 20к-корпоративная карта; 1.545-наличные из кассы; Итого 521.519р 36к)",
    "2. Предоплаченный товар, но не отраженный в приходе\t КНК Групп-17.300 (плейсметы;ИП Максимов-6.300 (шоколад фирм.,);Итого 23.600",
    "ИТОГ:\t545.119р 36к",
    "Прочие расходы:\t\t15%",
    "1. Налоговые платежи \t20.614",
    "2. Банковское обслуживание\t7.234",
    "3. Юридическое сопровождение\t40.000",
    "4. Банковская комиссия 1.6% за эквайринг\t19.769",
    "5. Тайный гость\t-----------------------------",
    "6. Обслуживание кассовой программы\t14.866",
    "7. Обслуживание хостинга\t----------------------------",
    "8. Обслуживание мобильного приложения\t----------------------------",
    "9. Реклама и IT поддержка\t53.500",
    "10. Обслуживание пожарной охраны\t-----------------------------",
    "11. Вневедомственная охрана помещения\t-----------------------------",
    "12. Интернет\t7.701+4.500",
    "13. Дезобработка помещения\t-----------------------------",
    "14. РПК Ника (крепления д/телевизоров и монтаж)\t30.000",
    "15. Аренда зарядных устройств и раций\t5.000",
    "16. Текущие мелкие расходы \t2.250",
    "17. Обслуживание Жироуловителей\t-----------------------------",
    "18. Аренда оборудования д/питьевой воды\t5.130",
    "19. Ремонт оборудования\t-----------------------------",
    "20. Чистка вентиляции\t-----------------------------",
    "21. Обслуживание банкетов\t-----------------------------",
    "22. Хэдхантер (подбор пероснала)\t----------------------------",
    "23. Аудит кантора (Бухуслуги)\t60.000",
    "24. Стол Тенгиз\t10.552",
    "25. Стол Игорь\t45.440",
    "26. ---------------------------------\t-----------------------------",
    "ИТОГ:\t326.556",
    "Расходы на доставку:\t\t\t",
    "1. Курьеры\t-----------------------------",
    "2. Агрегаторы\t20.586",
    "ИТОГ:\t20.586",
    "Основные расходы:\t\t20%\t8.95%",
    "1. Аренда торгового помещения\t 200.000 (за август)",
    "2. Эксплуатационные расходы\t-----------------------------",
    "3. Электричество\t-----------------------------",
    "4. Водоснабжение\t-----------------------------",
    "5. Аренда головного офиса\t11.500",
    "6. Аренда головного склада\t7.000",
    "7. Вывоз мусора\t-----------------------------",
    "ИТОГ:\t218.500",
    "Зарплата:\t\t20%\t43.4%",
    "1. ФОТ\t 960.056( за вторую часть августа и первую  часть сентября)",
    "2. ФОТ Бренд, логистика, бухгалтерия\t99.000",
    "ИТОГ:\t1.059.056",
    "Фактический приход товара и оплата товара:\t946.056р\t25%",
    "1. Приход товара по накладным\t 946.056 (оплаты фактические: 475.228р 52к -переводы; 157.455р 85к-корпоративная карта; 0-наличные из кассы; Итого 632.684р 37к)",
    "2. Предоплаченный товар, но не отраженный в приходе\tСтудиопак Итого 12.500 (влажные салфетки);",
    "ИТОГ:\t645.184р 37к",
    "Прочие расходы:\t\t15%\t16.5%",
    "1. Налоговые платежи \t26.964",
    "2. Банковское обслуживание\t6.419",
    "3. Юридическое сопровождение\t40.000",
    "4. Банковская комиссия 1.6% за эквайринг\t26.581",
    "5. Тайный гость\t-----------------------------",
    "6. Обслуживание кассовой программы Айко\t16.336",
    "7. Обслуживание хостинга\t----------------------------",
    "8. Обслуживание мобильного приложения\t9.200",
    "9. Реклама и IT поддержка\t65.000",
    "10. Обслуживание пожарной охраны\t-----------------------------",
    "11. Вневедомственная охрана помещения\t-----------------------------",
    "12. Интернет\t9.000",
    "13. Дезобработка помещения\t-----------------------------",
    "14. ----------------------------------\t----------------------------",
    "15. Аренда зарядных устройств и раций\t----------------------------",
    "16. Текущие мелкие расходы \t1.600",
    "17. Обслуживание Жироуловителей\t-----------------------------",
    "18. Аренда оборудования д/питьевой воды\t-----------------------------",
    "19. Ремонт оборудования\t-----------------------------",
    "20. Чистка вентиляции\t26.250",
    "21. Обслуживание банкетов\t15.250",
    "22. Хэдхантер (подбор пероснала)\t9.720",
    "23. Аудит кантора (Бухуслуги)\t60.000",
    "24. Стол Тенгиз\t17.905",
    "25. Стол Игорь\t47.090",
    "26. Стол Андрей\t9.550",
    "27. Сервис Гуру (система аттестации, за 1 год)\t12.655",
    "ИТОГ:\t402.520",
    "Расходы на доставку:\t\t\t",
    "1. Курьеры\t-----------------------------",
    "2. Агрегаторы\t18.132",
    "ИТОГ:\t18.132",
    "Основные расходы:\t\t20%",
    "1. Аренда торгового помещения\t 200.000 (за август) +400.000 (за сентябрь)",
    "2. Эксплуатационные расходы\t-----------------------------",
    "3. Электричество\t-----------------------------",
    "4. Водоснабжение\t-----------------------------",
    "5. Аренда головного офиса\t11.500",
    "6. Аренда головного склада\t7.000",
    "7. Вывоз мусора\t-----------------------------",
    "ИТОГ:\t618.500",
    "Зарплата:\t\t20%",
    "1. ФОТ\t 1.147.085( за вторую часть сентября и первую  часть октября)",
    "2. ФОТ Бренд, логистика, бухгалтерия\t99.000",
    "ИТОГ:\t1.246.085",
    "Фактический приход товара и оплата товара:\t\t25%",
    "1. Приход товара по накладным\t 907.841р; (оплаты фактические: 529.875р 50к -переводы; 98.340р 24к-корпоративная карта; 0-наличные из кассы; Итого 628.215р 74к)",
    "2. Предоплаченный товар, но не отраженный в приходе",
    "ИТОГ:\t628.215р 74к",
    "Прочие расходы:\t\t15%",
    "1. Налоговые платежи \t35.311",
    "2. Банковское обслуживание\t6.279",
    "3. Юридическое сопровождение\t40.000",
    "4. Банковская комиссия 1.6% за эквайринг\t31.587",
    "5. Тайный гость\t-----------------------------",
    "6. Обслуживание кассовой программы Айко\t8.435",
    "7. Обслуживание хостинга\t----------------------------",
    "8. Обслуживание мобильного приложения\t9.200",
    "9. Реклама и IT поддержка\t85.000",
    "10. Обслуживание пожарной охраны\t-----------------------------",
    "11. Вневедомственная охрана помещения\t-----------------------------",
    "12. Интернет\t----------------------------",
    "13. Дезобработка помещения\t-----------------------------",
    "14. Вышивка логотипа на одежде\t2.836",
    "15. Аренда зарядных устройств и раций\t10.000",
    "16. Текущие мелкие расходы \t5.460",
    "17. Обслуживание Жироуловителей\t-----------------------------",
    "18. Аренда оборудования д/питьевой воды\t5.130",
    "19. Ремонт оборудования\t6.610",
    "20. Чистка вентиляции\t35.000",
    "21. Обслуживание банкетов\t5.625",
    "22. Хэдхантер (подбор пероснала)\t4.227",
    "23. Аудит кантора (Бухуслуги)\t60.000",
    "24. ---------\t-------------",
    "25. --------\t-------------",
    "26. ---------\t-------------",
    "27. ---------\t------------",
    "ИТОГ:\t350.700",
    "Расходы на доставку:\t\t\t",
    "1. Курьеры\t-----------------------------",
    "2. Агрегаторы\t21.541",
    "ИТОГ:\t21.541",
    "Основные расходы:\t\t20%",
    "1. Аренда торгового помещения\t 500.000 (за октябрь)",
    "2. Эксплуатационные расходы\t-----------------------------",
    "3. Электричество\t-----------------------------",
    "4. Водоснабжение\t-----------------------------",
    "5. Аренда головного офиса\t11.500",
    "6. Аренда головного склада\t7.000",
    "7. Вывоз мусора\t-----------------------------",
    "ИТОГ:\t518.500",
    "Зарплата:\t\t20%",
    "1. ФОТ\t 564.678( за вторую часть октября)",
    "2. ФОТ Бренд, логистика, бухгалтерия\t99.000",
    "ИТОГ:\t663.678",
    "Фактический приход товара и оплата товара:\t\t25%",
    "1. Приход товара по накладным\t 739.457; (оплаты фактические: 357.254р 17к -переводы; 80.220р 30к-корпоративная карта; 0-наличные из кассы; Итого 437.474р 47к)",
    "2. Предоплаченный товар, но не отраженный в приходе\t--------------",
    "ИТОГ:\t437.474р 47к",
    "Прочие расходы:\t\t15%",
    "1. Налоговые платежи \t31.949р 38к",
    "2. Банковское обслуживание\t5.863р 74к",
    "3. Юридическое сопровождение\t40.000",
    "4. Банковская комиссия 1.6% за эквайринг\t22.653",
    "5. Тайный гость\t-----------------------------",
    "6. Обслуживание кассовой программы Айко\t12.000",
    "7. Обслуживание хостинга\t----------------------------",
    "8. Обслуживание мобильного приложения\t9.200",
    "9. Реклама и IT поддержка\t90.000",
    "10. Обслуживание пожарной охраны\t-----------------------------",
    "11. Вневедомственная охрана помещения\t-----------------------------",
    "12. Интернет\t4.500",
    "13. Дезобработка помещения\t-----------------------------",
    "14. Поверка весов\t3.400",
    "15. Аренда зарядных устройств и раций\t5.000",
    "16. Текущие мелкие расходы \t6.690",
    "17. Обслуживание Жироуловителей\t-----------------------------",
    "18. Аренда оборудования д/питьевой воды\t5.130",
    "19. Ремонт оборудования",
    "20. Чистка вентиляции\t35.000",
    "21. Обслуживание банкетов",
    "22. Хэдхантер (подбор пероснала)\t9.720",
    "23. Аудит кантора (Бухуслуги)\t60.000",
    "24. Яндекс карты\t51.975",
    "25. --------\t-------------",
    "26. ---------\t-------------",
    "27. ---------\t------------",
    "ИТОГ:\t393.081р 12к",
    "Расходы на доставку:\t\t\t",
    "1. Курьеры\t-----------------------------",
    "2. Агрегаторы\t17.839",
    "ИТОГ:\t17.839",
    "Основные расходы:\t\t20%",
    "1. Аренда торгового помещения\t 500.000 (за ноябрь)",
    "2. Эксплуатационные расходы\t-----------------------------",
    "3. Электричество\t-----------------------------",
    "4. Водоснабжение\t-----------------------------",
    "5. Аренда головного офиса\t11.500",
    "6. Аренда головного склада\t7.000",
    "7. Вывоз мусора\t-----------------------------",
    "ИТОГ:\t518.500",
    "Зарплата:\t\t20%",
    "1. ФОТ\t595.360 ( за первую часть ноября)",
    "2. ФОТ Бренд, логистика, бухгалтерия\t99.000",
    "ИТОГ:\t694.360",
    "Фактический приход товара и оплата товара:\t\t25%",
    "1. Приход товара по накладным\t 997.446р; (оплаты фактические: 491.114р 65к -переводы; 114.589 -корпоративная карта; 12.170 -наличные из кассы; Итого 617.873р 65к)",
    "2. Предоплаченный товар, но не отраженный в приходе\t--------------",
    "ИТОГ:\t617.873р 65к",
    "Прочие расходы:\t\t15%",
    "1. Налоговые платежи \t22.895р 38к",
    "2. Банковское обслуживание\t7.473р 86к",
    "3. Юридическое сопровождение\t40.000",
    "4. Банковская комиссия 1.6% за эквайринг\t26.915",
    "5. Тайный гость\t-----------------------------",
    "6. Обслуживание кассовой программы Айко\t4.500+8.700+15.995",
    "7. Обслуживание хостинга\t----------------------------",
    "8. Печать рекламных буклетов и их раздача\t7.300",
    "9. Реклама и IT поддержка\t82.000",
    "10. Обслуживание пожарной охраны\t-----------------------------",
    "11. Вневедомственная охрана помещения\t-----------------------------",
    "12. Интернет\t4.500",
    "13. Дезобработка помещения\t-----------------------------",
    "14. Облачная касса для доставки через сайт\t36.000",
    "15. Аренда зарядных устройств и раций\t5.000",
    "16. Текущие мелкие расходы \t2.600",
    "17. Обслуживание Жироуловителей\t-----------------------------",
    "18. Аренда оборудования д/питьевой воды\t5.130",
    "19. Ремонт оборудования\t----------------------",
    "20. Чистка вентиляции\t35.000",
    "21. Обслуживание банкетов\t6.750",
    "22. Хэдхантер (подбор пероснала)\t9.720",
    "23. Аудит кантора (Бухуслуги)\t60.000",
    "24. Корректировка ЕГАИС\t10.000",
    "25. Игорь стол\t22.130",
    "26. Новогодний декор\t169.702",
    "27. ---------\t------------",
    "ИТОГ:\t582.311р 24к",
    "Расходы на доставку:\t\t\t",
    "1. Курьеры\t4.700",
    "2. Агрегаторы\t14.431",
    "ИТОГ:\t19.131",
    "Основные расходы:\t-----------------------------\t25%/25%",
    "1. Аренда торгового помещения\t-----------------------------",
    "2. Эксплуатационные расходы\t-----------------------------",
    "3. Электричество\t------------------------------",
    "4. Водоснабжение\t-----------------------------",
    "5. Аренда головного офиса\t11.500",
    "6. Аренда головного склада\t-----------------------------",
    "7. Вывоз мусора\t15.800",
    "ИТОГ:\t27.300",
    "Зарплата:\t-----------------------------\t20%",
    "1. ФОТ общий\t67.894",
    "2. ФОТ Бренд, логистика, бухгалтерия\t90.000",
    "----------------------------------------------------------------------\t-----------------------------",
    "ИТОГ:\t157.894",
    "Фактический приход товара и оплата товара:\t-----------------------------\t30%",
    "1. Приход товара по накладным\t179.108р 89к+512.293р(оплаты фактические:199.803р 80к-переводы;81.225р 35к-корпоративная карта;34.202р-наличные из кассы; Итого 315.231р 15к)",
    "ИТОГ:\t315.231р 15к",
    "Прочие расходы:\t\t8%",
    "1. Налоговые платежи \t-----------------------------",
    "2. Банковское обслуживание\t2.514",
    "3.--------------------------------------\t-----------------------------",
    "4. Банковская комиссия 1.6% за эквайринг\t15.963",
    "5. Юридическое сопровождение\t40.000",
    "6. Обслуживание кассовой программы\t11.500",
    "7. Обслуживание хостинга\t2.500",
    "8. Аудит Кантора (бухуслуги)\t60.000",
    "9. Реклама и IT поддержка\t75.000",
    "10.-----------------------\t----------------",
    "11. -----------------------\t-----------------",
    "12. Интернет\t6.065",
    "13. Дезобработка помещения\t---------------------",
    "14. Ремонт оборудования\t--------------------",
    "15. Ремонт и чистка вентиляции\t---------------------",
    "16. Текущие мелкие расходы\t1.000",
    "17. Чистка жироуловителей и канализации\t---------------------",
    "18. Маркетинговый платеж\t--------------------",
    "19. ----------------------\t-----------------",
    "20. ----------------------\t----------------",
    "21. -----------------------\t---------------",
    "ИТОГ:\t214.542",
    "Расходы на доставку:\t-----------------------------\t\t",
    "1. Курьеры\t-----------------------------",
    "2. Агрегаторы\t8.169",
    "ИТОГ:\t8.169",
    "Основные расходы:\t-----------------------------\t25%",
    "1. Аренда торгового помещения\t-----------------------------",
    "2. Эксплуатационные расходы\t-----------------------------",
    "3. Электричество\t------------------------------",
    "4. Водоснабжение\t-----------------------------",
    "5. Аренда головного офиса\t11.500",
    "6. Аренда головного склада\t-----------------------------",
    "7. Вывоз мусора\t18.000",
    "ИТОГ:\t29.500",
    "Зарплата:\t-----------------------------\t20%",
    "1. ФОТ общий\t261.978",
    "2. ФОТ Бренд, логистика, бухгалтерия\t90.000",
    "----------------------------------------------------------------------\t-----------------------------",
    "ИТОГ:\t351.978",
    "Фактический приход товара и оплата товара:\t-----------------------------\t30%",
    "1. Приход товара по накладным\t473.128р 43к(оплаты фактические:231.572р 46к-переводы;51.104р 93к-корпоративная карта;2.799р-наличные из кассы; Итого 285.476р 39к)",
    "ИТОГ:\t285.476р 39к",
    "Прочие расходы:\t\t8%",
    "1. Налоговые платежи \t22.282р 86к",
    "2. Банковское обслуживание\t2.344р 29к",
    "3.--------------------------------------\t-----------------------------",
    "4. Банковская комиссия 1.6% за эквайринг\t12.111",
    "5. Юридическое сопровождение\t40.000",
    "6. Обслуживание кассовой программы\t15.995",
    "7. Обслуживание хостинга\t2.500",
    "8. Аудит Кантора (бухуслуги)\t60.000",
    "9. Реклама и IT поддержка\t59.200",
    "10.-----------------------\t----------------",
    "11. -----------------------\t-----------------",
    "12. Интернет\t3.500",
    "13. Дезобработка помещения\t---------------------",
    "14. Ремонт оборудования\t--------------------",
    "15. Ремонт и чистка вентиляции\t15.000",
    "16. Текущие мелкие расходы\t1.400",
    "17. Чистка жироуловителей и канализации\t10.139",
    "18. Маркетинговый платеж\t--------------------",
    "19. ----------------------\t-----------------",
    "20. ----------------------\t----------------",
    "21. -----------------------\t---------------",
    "ИТОГ:\t244.472р 15к",
    "Расходы на доставку:\t-----------------------------\t\t",
    "1. Курьеры\t-----------------------------",
    "2. Агрегаторы\t9.528",
    "ИТОГ:\t9.528"
]

