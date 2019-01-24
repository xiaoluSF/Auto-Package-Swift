//
//  main.swift
//  iOSPackage
//
//  Created by 翟泉 on 2019/1/24.
//  Copyright © 2019 Cryptape. All rights reserved.
//

import Foundation

//CommandLine.arguments = ["packTool", "upload"]

let VERSION = "0.1.0"

Main().handler(arguments: CommandLine.arguments.deleteFirst)


