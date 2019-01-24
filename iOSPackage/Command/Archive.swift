//
//  Archive.swift
//  PackTool
//
//  Created by 翟泉 on 2019/1/22.
//  Copyright © 2019 xl. All rights reserved.
//

import Cocoa
import RainbowSwift

class Archive: Command {
    var usage: String? {
        return """
        $ \(Main().name.green) \("\(self.name)".green)
        """
    }

    var name: String {
        return "archive"
    }

    var message: String? {
        return "构建打包"
    }

    var commands: [Command]?

    var options: [String : String]?

    var verbose: Bool = false

    func handler(arguments: [String]) {
        if arguments.first == "--help" {
            print(self)
            return
        }

        guard let projectURL = FileManager.default.searchFile(directory: CommandLine.currentDirectory, pathExtension: "xcworkspace") else {
            print("未在当前目录下发现 xcworkspace 文件".red)
            return
        }

        let projectName = projectURL.deletingPathExtension().lastPathComponent
        let codeSignIdentity = ConfigurationService().codeSignIdentity
        let provisioningProfileSpecifier = ConfigurationService().provisioningProfileSpecifier

        try? FileManager.default.removeItem(at: CommandLine.currentDirectory.appendingPathComponent("\(projectName).xcarchive"))
        let shell = "xcodebuild archive -workspace \(projectURL.lastPathComponent) -configuration Release -scheme Cyton -archivePath \(projectName).xcarchive CODE_SIGN_IDENTITY=\"\(codeSignIdentity)\" PROVISIONING_PROFILE_SPECIFIER=\"\(provisioningProfileSpecifier)\""

        print("\nShell: \(shell)")
        print("\("开始编译...".green) \(projectURL.path)")

        _ = CommandLine.launchedShell(shell: shell)
        if let archivePath = FileManager.default.searchFile(directory: CommandLine.currentDirectory, pathExtension: "xcarchive")  {
            print("ARCHIVE SUCCEEDED".green)
            print("archivePath: \(archivePath.path)")
        } else {
            print("ARCHIVE FAILED".red + "  log: ./log.txt")
        }
    }
}
