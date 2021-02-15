//
//  cleanContent.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 15.02.2021.
//

import Foundation

extension String {
    func cleanContent() -> String {
        self
            //.clearWhitespacesAndNewlines()
            /// fix special line(s)
            .replaceMatches(for: #"\s*ВМ ЩК\s*"#,
                            withString: "Название объекта: Вай Мэ! Щелково\n")
            .replaceMatches(for: #"(?m)^ФОТ Бренд, логистика, бухгалтерия"#,
                            withString: "2. ФОТ Бренд, логистика, бухгалтерия")
            .replaceMatches(for: "Итого-",
                            withString: "Итого ")
            .replaceMatches(for: "Студиопак-",
                            withString: "Студиопак Итого ")
            // Щелково январь 21
            .replaceMatches(for: "Январь2020\tОборот факт:1.065.575",
                            withString: "Январь2021\tОборот факт:1.065.575")
            .replaceMatches(for: "375.116р18к(оплаты фактические:389.218р21к-переводы;57.084р55к-корпоративная карта;27.877р-наличные из кассы; Итого-285.476р39к",
                            withString: "375.116р18к(оплаты фактические:389.218р21к-переводы;57.084р55к-корпоративная карта;27.877р-наличные из кассы; Итого-474.179р76к")
    }

}
