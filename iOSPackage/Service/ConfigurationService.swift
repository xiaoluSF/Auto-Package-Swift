//
//  ConfigurationService.swift
//  PackTool
//
//  Created by 翟泉 on 2019/1/22.
//  Copyright © 2019 xl. All rights reserved.
//

import Cocoa

class ConfigurationService {
    var codeSignIdentity: String {
        if let codeSignIdentity = dictionary?.object(forKey: "codeSignIdentity") as? String {
            return codeSignIdentity
        }
        print("\n设置签名证书:")
        let result = CommandLine.keyboardInput()
        let dict = NSMutableDictionary(dictionary: dictionary ?? [:])
        dict.setValue(result, forKey: "codeSignIdentity")
        try? dict.write(to: url)
        return result
    }

    var provisioningProfileSpecifier: String {
        if let codeSignIdentity = dictionary?.object(forKey: "provisioningProfileSpecifier") as? String {
            return codeSignIdentity
        }
        print("\n设置配置描述文件:")
        let result = CommandLine.keyboardInput()
        let dict = NSMutableDictionary(dictionary: dictionary ?? [:])
        dict.setValue(result, forKey: "provisioningProfileSpecifier")
        try? dict.write(to: url)
        return result
    }

    var apiToken: String {
        if let codeSignIdentity = dictionary?.object(forKey: "apiToken") as? String {
            return codeSignIdentity
        }
        print("\n设置 fir.im api_token:")
        let result = CommandLine.keyboardInput()
        let dict = NSMutableDictionary(dictionary: dictionary ?? [:])
        dict.setValue(result, forKey: "apiToken")
        try? dict.write(to: url)
        return result
    }

    private var url = CommandLine.currentDirectory.appendingPathComponent("PackgeConfiguration.plist")

    private var dictionary: NSDictionary? {
        return NSDictionary(contentsOf: url)
    }

    func exportOptionsPlist() {

    }
}
