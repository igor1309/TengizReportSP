//
//  FooterItem.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 07.02.2021.
//

import Foundation
import Toolbox

struct FooterItem: Equatable {
    let title: String
    let value: Double?
    let percentage: Double?
}

extension String {
    func footerItem() -> FooterItem? {
        let elements = components(separatedBy: "\t")
        switch elements.count {
            case 1: return FooterItem(title: elements[0],
                                      value: nil,
                                      percentage: nil)
            case 2: return FooterItem(title: elements[0],
                                      value: elements[1].numberWithSign(),
                                      percentage: nil)
            case 3...: return FooterItem(title: elements[0],
                                         value: elements[1].numberWithSign(),
                                         percentage: elements[2].percentageStringToDouble())
            default: return nil
        }
    }
}
