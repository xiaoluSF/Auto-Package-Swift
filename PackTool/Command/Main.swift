//
//  Main.swift
//  PackTool
//
//  Created by 翟泉 on 2019/1/22.
//  Copyright © 2019 xl. All rights reserved.
//

import Cocoa
import RainbowSwift

class Main: Command {
    var name: String { return "packTool" }
    var message: String? {
        return ""
    }
    var commands: [Command]? {
        return [
            Packge(),
            Build(),
            Archive(),
            ExportArchive(),
            Upload(),
            Configuration(),
            Version()
        ]
    }
    var options: [String : String]? {
        return [
            "--help": "帮助",
            "--verbose": "显示更多调试信息"
        ]
    }
    var verbose: Bool = false
    var usage: String? {
        return """
        $ \("\(name) COMMAND".green)
        """
    }

    func handler(arguments: [String]) {
        guard arguments.count > 0 else {
            print(self)
            return
        }
        for command in commands ?? [] {
            if command.name == arguments[0] || command.name == arguments[0] {
                command.handler(arguments: arguments.deleteFirst)
                return
            }
        }
        guard arguments.has(any: "--help") == -1 else {
            print(self)
            return
        }
    }
}
