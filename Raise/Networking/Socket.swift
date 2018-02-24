//
//  Socket.swift
//  Raise
//
//  Created by Stephen Hayes on 2/24/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import Foundation
import SocketIO

class Socket {

    static let shared = Socket()

    var manager: SocketManager?
    var socket: SocketIOClient?

    private let url: URL = {
        guard let url = URL(string: "https://raise.cameronvwilliams.com") else {
            fatalError("Url must be valid")
        }
        return url
    }()

    private init() {
        // Private init to force use of singleton
    }

    func connect(token: String) {
        let config = SocketIOClientConfiguration(arrayLiteral: .secure(true), .connectParams(["token": token]), .forceWebsockets(true))
        manager = SocketManager(socketURL: url, config: config)

        socket = manager?.defaultSocket
        addHandlers()
        socket?.connect()
    }

    func addHandlers() {
        socket?.onAny {
            print("Got event: \($0.event) with items: \($0.items ?? [])")
        }

        socket?.on("join-leave-game") { _, _ in
            print("join-leave-game")
        }

        socket?.on("card-submit") { _, _ in
            print("card-submit")
        }

        socket?.on("start-game") { _, _ in
            print("start-game")
        }

        socket?.on("end-game") { _, _ in
            print("end-game")
        }
    }

    func disconnect() {
        socket?.disconnect()
    }
}
