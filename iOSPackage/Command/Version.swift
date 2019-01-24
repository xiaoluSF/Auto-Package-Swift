//
//  Version.swift
//  PackTool
//
//  Created by 翟泉 on 2019/1/22.
//  Copyright © 2019 xl. All rights reserved.
//

import Cocoa

class Version: Command {
    var name: String {
        return "version"
    }

    var message: String? {
        return "版本、更新"
    }

    var commands: [Command]?

    var options: [String : String]?

    var verbose: Bool = false

    var usage: String?

    func handler(arguments: [String]) {

    }
}
