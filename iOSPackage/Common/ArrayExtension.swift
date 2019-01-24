//
//  ArrayExtension.swift
//  PackTool
//
//  Created by 翟泉 on 2019/1/22.
//  Copyright © 2019 xl. All rights reserved.
//

import Cocoa

extension Array {
    func subarray(range: NSRange) -> [Element] {
        let array = NSArray(array: self)
        return array.subarray(with: range) as! [Element]
    }

    var deleteFirst: [Element] {
        return subarray(range: NSMakeRange(1, count - 1))
    }
}

extension Array where Element: Equatable {
    func has(any: Element) -> Index {
        for value in self.enumerated() {
            if value.element == any {
                return value.offset
            }
        }
        return -1
    }
}
