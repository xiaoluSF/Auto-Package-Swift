//
//  Upload.swift
//  PackTool
//
//  Created by 翟泉 on 2019/1/22.
//  Copyright © 2019 xl. All rights reserved.
//

import Cocoa

class Upload: Command {
    var name: String {
        return "upload"
    }

    var message: String? {
        return "上传IPA文件至fir.im"
    }

    var commands: [Command]?

    var options: [String : String]? {
        return [
            "--help": "帮助",
            "--verbose": "显示更多调试信息"
        ]
    }

    var verbose: Bool = false

    var usage: String? {
        return """
        $ \(Main().name.green) \("\(self.name)".green)
        """
    }

    func handler(arguments: [String]) {
        if arguments.first == "--help" {
            print(self)
            return
        }
    }
}
