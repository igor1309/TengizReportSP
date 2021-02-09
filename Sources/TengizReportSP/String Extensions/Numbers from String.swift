//
//  Numbers from String.swift
//  
//
//  Created by Igor Malyarov on 25.12.2020.
//

import Foundation

extension String {

    // MARK: - Conversion

    func numberWithSign() -> Double? {
        var sign: Double = 1
        if firstMatch(for: Patterns.minus) != nil { sign = -1 }

        if let math = firstMatch(for: Patterns.math) {
            return math.listMatches(for: Patterns.itemNumber).compactMap { $0.numberWithSign() }.reduce(0, +)
        }

        if let rubliIKopeiki = rubliKopeikiToDouble() {
            return sign * rubliIKopeiki
        }

        if let doubleString = firstMatch(for: Patterns.itemNumber),
           let double = Double(doubleString.replacingOccurrences(of: ".", with: "")) {
            return sign * double
        }

        return nil
    }

    func rubliKopeikiToDouble() -> Double? {
        guard let integerString = replaceFirstMatch(for: Patterns.rubliKopeiki, withGroup: "integer"),
              let integer = Double(integerString.replacingOccurrences(of: ".", with: ""))
        else { return nil }

        guard let decimalString = replaceFirstMatch(for: Patterns.rubliKopeiki, withGroup: "decimal"),
              let decimal = Double(decimalString)
        else { return integer }

        return integer + decimal / 100
    }

    func percentageStringToDouble() -> Double? {
        guard last == "%",
              let percentage = Double(dropLast()) else { return nil }
        return percentage / 100
    }

    func numberWithoutSign() -> Double? {
        if let numberString = firstMatch(for: Patterns.itemNumber),
           let double = Double(numberString.replacingOccurrences(of: ".", with: "")) {
            return double
        }
        return nil
    }

}
