//
//  Regex String+Ext.swift
//
//
//  Created by Igor Malyarov on 25.12.2020.
//

import Foundation

extension String {

    /// Returns a new string containing matching regular expression replaced with provided string.
    /// - Parameters:
    ///   - pattern: string to create regular expression used for match
    ///   - replacementString: replacement string
    /// - Returns: string with replaced match or original string if no matches for match string were found
    public func replaceMatches(for pattern: String, withString replacementString: String) -> String {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return self
        }
        return replaceMatches(for: regex, withString: replacementString)
    }

    /// Returns a new string containing matching regular expression replaced with provided string.
    /// - Parameters:
    ///   - regex: regular expression used for match
    ///   - replacementString: replacement string
    /// - Returns: string with replaced match or original string if no matches for match string were found
    func replaceMatches(for regex: NSRegularExpression, withString replacementString: String) -> String {
        let range = NSRange(self.startIndex..., in: self)
        return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replacementString)
    }

    public func listMatches(for pattern: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return [] }
        return listMatches(for: regex)
    }

    func listMatches(for regex: NSRegularExpression) -> [String] {
        let range = NSRange(self.startIndex..., in: self)
        let matches = regex.matches(in: self, options: [], range: range)

        return matches.map {
            let range = Range($0.range, in: self)!
            return String(self[range])
        }
    }

    /// Returns matching string or nil of no match
    /// - Parameter pattern: pattern to create NSRegularExpression
    /// - Returns: nil if no match
    public func firstMatch(for pattern: String) -> String? {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return nil }
        return firstMatch(for: regex)
    }

    /// Returns matching string or nil of no match
    /// - Parameter regex: NSRegularExpression to match
    /// - Returns: nil if no match
    func firstMatch(for regex: NSRegularExpression) -> String? {
        let range = NSRange(self.startIndex..., in: self)
        let match = regex.firstMatch(in: self, options: [], range: range)

        if let match = match {
            let range = Range(match.range, in: self)!
            return String(self[range])
        } else {
            return nil
        }
    }

    /// Returns a new string containing first matching regular expression replaced with provided string or nil.
    /// - Parameters:
    ///   - pattern: string to create regular expression used for match
    ///   - replacementString: replacement string
    /// - Returns: string with replaced match or nil if no matches for match string were found
    public func replaceFirstMatch(for pattern: String, withString replacementString: String) -> String? {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return nil }
        return replaceFirstMatch(for: regex, withString: replacementString)
    }

    /// Returns a new string containing first matching regular expression replaced with provided string or nil.
    /// - Parameters:
    ///   - regex: search string as NSRegularExpression
    ///   - replacementString: replacement string
    /// - Returns: string with replaced match or nil if no matches for match string were found
    func replaceFirstMatch(for regex: NSRegularExpression, withString replacementString: String) -> String? {
        let range = NSRange(self.startIndex..., in: self)
        let match = regex.firstMatch(in: self, options: [], range: range)

        if let match = match {
            let range = match.range
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replacementString)
        } else {
            return nil
        }
    }

    public func replaceFirstMatch(for pattern: String, withGroup groupName: String) -> String? {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return nil }

        let range = NSRange(self.startIndex..., in: self)
        let match = regex.firstMatch(in: self, options: [], range: range)

        if let match = match,
           let groupRange = Range(match.range(withName: groupName), in: self) {
            return String(self[groupRange])
        } else {
            return nil
        }
    }

}
