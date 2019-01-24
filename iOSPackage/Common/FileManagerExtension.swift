//
//  FileManagerExtension.swift
//  PackTool
//
//  Created by 翟泉 on 2019/1/23.
//  Copyright © 2019 xl. All rights reserved.
//

import Cocoa

extension FileManager {
    func searchFile(directory: URL, pathExtension: String) -> URL? {
        let contents = try? contentsOfDirectory(atPath: directory.path)
        for item in contents ?? [] {
            if item.hasSuffix(pathExtension) {
                return directory.appendingPathComponent(item)
            }
        }
        return nil
    }
}
