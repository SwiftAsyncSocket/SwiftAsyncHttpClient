//
//  ViewController.swift
//  SwiftAsyncHttpClient
//
//  Created by Di on 2019/1/21.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import UIKit
import SwiftAsyncSocket

class ViewController: UIViewController {
    var request: ExampleURLRequest!

    var socket: SwiftAsyncSocket?
    override func viewDidLoad() {
        super.viewDidLoad()
        request = ExampleURLRequest(url: URL(string: "http://www.wdtechnology.club/"))
        socket = SwiftAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)

        do {
            try socket?.connect(toHost: request.url.host ?? "", onPort: 80)
        } catch {
            print("\(error)")
        }

    }
}

extension ViewController: SwiftAsyncSocketDelegate {
    func socket(_ socket: SwiftAsyncSocket, didConnect toHost: String, port: UInt16) {
        print("socket连接成功")
        socket.write(data: request.toData(), timeOut: -1, tag: 0)
        socket.readData(timeOut: -1, tag: 0)
    }

    func socket(_ socket: SwiftAsyncSocket, didWriteDataWith tag: Int) {
        print("发送数据成功 tag:\(tag)")
    }

    func socket(_ socket: SwiftAsyncSocket, didWriteParticalDataOf length: UInt, with tag: Int) {
        print("发送部分数据成功")
    }

    func socket(_ socket: SwiftAsyncSocket, didRead data: Data, with tag: Int) {
        print("\(String(data: data, encoding: .utf8) ?? "")")
        socket.readData(timeOut: -1, tag: 0)
    }

    func socket(_ socket: SwiftAsyncSocket?, didDisconnectWith error: SwiftAsyncSocketError?) {
        print("连接断开了 \(error)")
    }

}

