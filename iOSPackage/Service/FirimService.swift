//
//  FirimService.swift
//  PackTool
//
//  Created by 翟泉 on 2019/1/23.
//  Copyright © 2019 xl. All rights reserved.
//

import Cocoa

class FirimService {
    typealias UploadKey = String
    typealias UploadToken = String

    var apiToken: String = ConfigurationService().apiToken

    func fetchBuild(bundleId: String) throws -> UInt {
        return 0
    }

    func uploadIPA(file: URL, bundleId: String, name: String, version: String, build: String, release_type: String, changelog: String) throws {
        guard let (key, token) = getUploadCredentials(bundleId: bundleId) else { return }
        let params: [String: String] = [
            "key": key,
            "token": token,
            "x:name": name,
            "x:version": version,
            "x:build": build,
            "x:release_type": release_type,
            "x:changelog": changelog
        ]

        let boundary = "Boundary-\(NSUUID().uuidString)"
        let httpBody = createBody(boundary: boundary, parameters: params, paths: [file], fieldName: "file")

        var request = URLRequest(url: URL(string: "https://up.qbox.me")!)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let session = URLSession(configuration: URLSessionConfiguration.default)
        let group = DispatchGroup()
        group.enter()
        session.uploadTask(with: request, from: httpBody) { (_, _, _) in
            group.leave()
        }.resume()
        group.wait()
    }

    private func createBody(boundary: String, parameters: [String: String], paths: [URL], fieldName: String) -> Data {
        var httpBody = Data()
        parameters.forEach { (key, value) in
            httpBody.append("--\(boundary)\r\n".data(using: .utf8)!)
            httpBody.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            httpBody.append("\(value)\r\n".data(using: .utf8)!)
        }
        paths.forEach { (path) in
            let filename = path.lastPathComponent
            let data = try! Data(contentsOf: path)
            let mimetype = mimeType(filePath: path)
            httpBody.append("--\(boundary)\r\n".data(using: .utf8)!)
            httpBody.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
            httpBody.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
            httpBody.append(data)
            httpBody.append("\r\n".data(using: .utf8)!)
        }
        httpBody.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return httpBody
    }


    private func getUploadCredentials(bundleId: String) -> (UploadKey, UploadToken)? {
        let parameters: [String: Any] = [
            "type": "ios",
            "bundle_id": bundleId,
            "api_token": apiToken
        ]

        var request = URLRequest(url: URL(string: "http://api.fir.im/apps")!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)

        var credentials: (UploadKey, UploadToken)?

        let session = URLSession(configuration: URLSessionConfiguration.default)
        let signal = DispatchGroup()
        signal.enter()
        let task = session.dataTask(with: request) { (data, _, _) in
            do {
                guard let data = data else { throw "获取上传凭证失败" }
                let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
                guard let cert = dict["cert"] as? [String: Any] else { throw "获取上传凭证失败" }
                guard let binary = cert["binary"] as? [String: Any] else { throw "获取上传凭证失败" }
                if let key = binary["key"] as? String, let token = binary["token"] as? String {
                    credentials = (key, token)
                }
            } catch {
                print("\(error)".red)
            }
            signal.leave()
        }
        task.resume()
        signal.wait()

        return credentials
    }

    private func mimeType(filePath: URL) -> String {
        let pathExtension = filePath.pathExtension
        let type = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as CFString, nil)
        return UTTypeCopyPreferredTagWithClass(type as! CFString, kUTTagClassMIMEType)?.takeRetainedValue() as String? ?? ""
    }
}


