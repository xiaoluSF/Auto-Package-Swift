//
//  Packge.swift
//  PackTool
//
//  Created by 翟泉 on 2019/1/22.
//  Copyright © 2019 xl. All rights reserved.
//

import Cocoa

class Packge: Command {
    var name: String {
        return "packge"
    }

    var message: String? {
        return "打包并上传至fir.im"
    }

    var commands: [Command]?

    var options: [String : String]?

    var verbose: Bool = false

    var usage: String?

    func handler(arguments: [String]) {

    }
}
