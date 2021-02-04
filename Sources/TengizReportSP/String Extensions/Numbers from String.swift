//
//  Numbers from String.swift
//  
//
//  Created by Igor Malyarov on 25.12.2020.
//

import Foundation

public extension String {

    // MARK: - helpers

    func numberAndRemains() -> (Double?, String) {
        var sign: Double = 1
        if self.firstMatch(for: Patterns.minus) != nil {
            sign = -1
        }

        if let numberString = self.firstMatch(for: Patterns.rubliKopeiki),
           let rubliIKopeiki = numberString.rubliKopeikiToDouble() {
            if let remains = self.replaceFirstMatch(for: Patterns.rubliKopeiki, withString: "") {
                return (sign * rubliIKopeiki, remains)
            }
        }

        if let numberString = self.firstMatch(for: Patterns.itemNumber),
           let double = Double(numberString.replacingOccurrences(of: ".", with: "")),
           let remains = self.replaceFirstMatch(for: Patterns.itemNumber, withString: "") {
            return (sign * double, remains)
        }

        return (nil, self)
    }

    func numberWithSign() -> Double? {
        var sign: Double = 1
        if firstMatch(for: Patterns.minus) != nil {
            sign = -1
        }

        #warning("finish with these patterns")
        let bodyItemStart = #"^\d+\."#
        #warning("add test to test the math")
        let itemMath = #"(\#(Patterns.itemNumber)(?:\+\#(Patterns.itemNumber))+)$"#
        if firstMatch(for: itemMath) != nil {
            return listMatches(for: Patterns.itemNumber).compactMap { $0.numberWithSign() }.reduce(0, +)
        }

        if let rubliIKopeikiString = firstMatch(for: Patterns.rubliKopeiki),
           let rubliIKopeiki = rubliIKopeikiString.rubliKopeikiToDouble() {
            return sign * rubliIKopeiki
        }

        if let doubleString = firstMatch(for: Patterns.itemNumber),
           let double = Double(doubleString.replacingOccurrences(of: ".", with: "")) {
            return sign * double
        }

        return nil
    }

    // MARK: - Conversion

    func rubliKopeikiToDouble() -> Double? {
        guard let integerString = replaceFirstMatch(for: Patterns.rubliKopeiki, withGroup: "integer"),
              let integer = Double(integerString.replaceMatches(for: #"\."#, withString: ""))
        else { return nil }

        guard let decimalString = replaceFirstMatch(for: Patterns.rubliKopeiki, withGroup: "decimal"),
              let decimal = Double(decimalString.trimmingCharacters(in: .whitespaces))
        else { return integer }

        return integer + decimal / 100
    }

    func percentageStringToDouble() -> Double? {
        guard self.last == "%",
              let percentage = Double(self.dropLast()) else { return nil }
        return percentage / 100
    }

    func numberWithoutSign() -> Double? {
        if let numberString = self.firstMatch(for: Patterns.itemNumber),
           let double = Double(numberString.replacingOccurrences(of: ".", with: "")) {
            return double
        }

        return nil
    }

}
