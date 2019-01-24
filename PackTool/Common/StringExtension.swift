//
//  StringExtension.swift
//  PackTool
//
//  Created by 翟泉 on 2019/1/23.
//  Copyright © 2019 xl. All rights reserved.
//

import Cocoa

extension String {
    var deletePathExtension: String {
        return NSString(string: self).deletingPathExtension
    }
    var deleteLinefeed: String {
        return replacingOccurrences(of: "\n", with: "")
    }
}


extension String {
    func removeSuffixSpace() -> String {
        var newString = self
        while newString.hasSuffix(" ") {
            let lowerBound = newString.index(before: newString.endIndex)
            let range = Range(uncheckedBounds: (lowerBound, newString.endIndex))
            newString.replaceSubrange(range, with: "")
        }
        return newString
    }
}


extension String: Error {
}
