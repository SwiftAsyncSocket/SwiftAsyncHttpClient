//
//  ExampleURLRequest.swift
//  SwiftAsyncHttpClient
//
//  Created by Di on 2019/1/21.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import UIKit
import SwiftAsyncSocket
extension String {
    func toData(_ encode: String.Encoding) -> Data {
        return data(using: encode) ?? Data()
    }
}

class ExampleURLRequest {
    var url: URL

    var method: String = "GET"

    var httpVersion: String = "HTTP/1.1"

    var httpHeader: [String: Any] = [:]

    var bodyLength: Int = 0

    var body: Data? {
        willSet {
            self.body = newValue
            bodyLength = (body ?? Data()).count
        }
    }

    init(url: URL?) {
        guard let url = url else {
            fatalError()
        }

        self.url = url
    }

    func toData() -> Data {
        let finalString = method + " / " + httpVersion

        print("FinalString: \(finalString)")

        var data = finalString.toData(.ascii) + SwiftAsyncSocket.CRLFData

        data += (("Host: " + (url.host ?? "")).toData(.ascii) + SwiftAsyncSocket.CRLFData + SwiftAsyncSocket.CRLFData)

        return data
    }
}
