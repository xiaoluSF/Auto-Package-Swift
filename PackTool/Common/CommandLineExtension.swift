//
//  CommandLineExtension.swift
//  PackTool
//
//  Created by 翟泉 on 2019/1/23.
//  Copyright © 2019 xl. All rights reserved.
//

import Cocoa

extension CommandLine {
    static let currentDirectory = URL(fileURLWithPath: Process().currentDirectoryPath, isDirectory: true)
}

extension CommandLine {
    static func keyboardInput() -> String {
        let keyboard = FileHandle.standardInput
        let inputData = keyboard.availableData
        let input = String(data: inputData, encoding: .utf8)!.replacingOccurrences(of: "\n", with: "").removeSuffixSpace().replacingOccurrences(of: "\\ ", with: " ")
        if input == "q" {
            print("退出".blue)
            exit(-1)
        }
        return input
    }

    static func launchedShell(shell: String, directoryPath: String = "") -> String {
        let logPath = CommandLine.currentDirectory.appendingPathComponent("log.txt", isDirectory: false)
        let process = Process()
        if directoryPath != "" {
            process.currentDirectoryPath = directoryPath
        }
        process.launchPath = "/bin/sh"
        process.arguments = ["-c", shell + " > \(logPath.path)"]
        process.launch()
        process.waitUntilExit()
        do {
            let string = try String(contentsOfFile: logPath.path)
            return string
        }
        catch {
            return ""
        }
    }
}
