//
//  main.swift
//  PackTool
//
//  Created by XiaoLu on 2019/1/22.
//  Copyright © 2019 xl. All rights reserved.
//

import Foundation

//CommandLine.arguments = ["packTool", "upload"]

let VERSION = "0.1.0"

Main().handler(arguments: CommandLine.arguments.deleteFirst)
