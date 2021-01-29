//
//  getFirstMatchAndRemains.swift
//  TengizReportSP
//
//  Created by Igor Malyarov on 28.01.2021.
//

import Foundation

extension String {

    /// Get first match from string and cut match from string to give remains
    /// Handle head (match) and tail in closure
    /// - Parameters:
    ///   - patterns: array of regular expression patterns to apple to string (order matters!)
    ///   - completion: closure to work with non empty head and tail
    func getFirstMatchAndRemains(patterns: [String], completion: (String?, String?) -> Void) {
        var match: String?
        var remains: String?

        for pattern in patterns {
            guard let regex = try? NSRegularExpression(pattern: pattern, options: []),
                  let headString = self.firstMatch(for: regex),
                  let tailString = self.replaceFirstMatch(for: regex, withString: "") else { continue }

            match = headString.trimmingCharacters(in: .whitespaces)
            remains = tailString.trimmingCharacters(in: .whitespaces)
            break
        }

        completion(match, remains)
    }

}
