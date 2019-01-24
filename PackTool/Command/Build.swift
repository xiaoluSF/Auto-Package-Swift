//
//  Build.swift
//  PackTool
//
//  Created by 翟泉 on 2019/1/23.
//  Copyright © 2019 xl. All rights reserved.
//

import Cocoa

class Build: Command {
    var name: String {
        return "build"
    }

    var message: String? {
        return "编译"
    }

    var commands: [Command]?

    var options: [String : String]?

    var verbose: Bool = false

    var usage: String?

    func handler(arguments: [String]) {

    }
}
