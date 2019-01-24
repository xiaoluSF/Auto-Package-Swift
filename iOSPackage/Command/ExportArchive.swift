//
//  ExportArchive.swift
//  PackTool
//
//  Created by 翟泉 on 2019/1/22.
//  Copyright © 2019 xl. All rights reserved.
//

import Cocoa

class ExportArchive: Command {
    var name: String {
        return "exportArchive"
    }

    var message: String? {
        return "导出IPA"
    }

    var commands: [Command]?

    var options: [String : String]?

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

        guard let archivePath = FileManager.default.searchFile(directory: CommandLine.currentDirectory, pathExtension: "xcarchive") else {
            print("未在当前目录下发现 xcarchive 文件")
            return
        }

        let projectName = archivePath.deletingPathExtension().lastPathComponent
        let shell = "xcodebuild -exportArchive -archivePath \(projectName).xcarchive -exportPath exportArchive -exportOptionsPlist exportOptionsPlist.plist"
        
        print("\nShell: \(shell)")
        print("\("开始导出IPA...".green) \(archivePath.path)")

        _ = CommandLine.launchedShell(shell: shell)
        if let exportPath = FileManager.default.searchFile(directory: CommandLine.currentDirectory.appendingPathComponent("exportArchive"), pathExtension: "ipa")  {
            print("EXPORT SUCCEEDED".green)
            print("exportPath: \(exportPath.path)")
        } else {
            print("EXPORT FAILED".red + "  log: ./log.txt")
        }
    }
}
