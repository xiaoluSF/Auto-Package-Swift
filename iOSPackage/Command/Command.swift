//
//  Command.swift
//  PackTool
//
//  Created by 翟泉 on 2019/1/22.
//  Copyright © 2019 xl. All rights reserved.
//

import Cocoa
import RainbowSwift

protocol Command: CustomStringConvertible {
    var name: String { get }
    var message: String? { get }
    var commands: [Command]? { get }
    var options: [String: String]? { get }
    var verbose: Bool { get set }
    var usage: String? { get }

    func handler(arguments: [String])
}

extension CustomStringConvertible where Self: Command {
    var description: String {
        var description = ""
        if var usage = usage {
            description += "Usage:\n\n".applyingStyle(.underline)
            usage = usage.replacingOccurrences(of: "\n", with: "\n    ")
            description += "    " + usage + "\n\n"
        }

        if let commands = commands {
            description += "Commands:\n\n".applyingStyle(.underline)
            for cmd in commands {
                if let msg = cmd.message {
                    description += "    + \(cmd.name)".green
                    for _ in cmd.name.lengthOfBytes(using: .utf8) ... 20 {
                        description += " "
                    }
                    description += msg + "\n"
                }
                else {
                    description += "    " + cmd.name.green + "\n"
                }
            }
            description += "\n"
        }

        if let options = options {
            description += "Options:\n\n".applyingStyle(.underline)
            for option in options {
                description += "    " + option.key.blue
                for _ in option.key.lengthOfBytes(using: .utf8) ... 12 {
                    description += " "
                }
                description += option.value + "\n"
            }
        }
        return description
    }
}
