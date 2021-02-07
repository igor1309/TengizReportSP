//
//  FooterItem.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 07.02.2021.
//

import Foundation

struct FooterItem: Equatable {
    let title: String
    let value: Double?
    let percentage: Double?
}

extension String {
    func footerItem() -> FooterItem? {
        let components = components(separatedBy: "\t")
        switch components.count {
            case 1: return FooterItem(title: components[0],
                                      value: nil,
                                      percentage: nil)
            case 2: return FooterItem(title: components[0],
                                      value: components[1].numberWithSign(),
                                      percentage: nil)
            case 3...: return FooterItem(title: components[0],
                                         value: components[1].numberWithSign(),
                                         percentage: components[2].percentageStringToDouble())
            default: return nil
        }
    }
}
