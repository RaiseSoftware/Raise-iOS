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
    var activeGame = false

    var playersUpdated: (([Player]) -> Void)?
    var activeCardsUpdated: (([ActiveCard]) -> Void)?
    var startGame: (() -> Void)?

    enum Event: String {
        case joinLeaveGame = "join-leave-game"
        case cardSubmit = "card-submit"
        case startGame = "start-game"
        case endGame = "end-game"
    }

    private let url: URL = {
        guard let url = URL(string: "https://raise.cameronvwilliams.com") else {
            fatalError("Url must be valid")
        }
        return url
    }()

    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func appMovedToBackground() {
        if activeGame {
            socket?.disconnect()
        }
    }

    @objc func appMovedToForeground() {
        if activeGame {
            socket?.connect()
        }
    }

    func connect(token: String) {
        let config = SocketIOClientConfiguration(arrayLiteral: .secure(true), .connectParams(["token": token]), .forceWebsockets(true))
        manager = SocketManager(socketURL: url, config: config)

        socket = manager?.defaultSocket
        addHandlers()
        socket?.connect()
        activeGame = true
    }

    func addHandlers() {
        socket?.onAny {
            print("Got event: \($0.event) with items: \($0.items ?? [])")
        }

        socket?.on(Event.joinLeaveGame.rawValue) { [weak self] items, _ in
            for item in items {
                guard let jsonString = item as? String, let data = jsonString.data(using: .utf8) else {
                    assertionFailure("Invalid json")
                    continue
                }

                do {
                    let response = try JSONDecoder().decode(JoinLeaveGameResponse.self, from: data)
                    self?.playersUpdated?(response.players)
                } catch {
                    assertionFailure(error.localizedDescription)
                }
            }
        }

        socket?.on(Event.cardSubmit.rawValue) { [weak self] items, _ in
            for item in items {
                guard let jsonString = item as? String, let data = jsonString.data(using: .utf8) else {
                    assertionFailure("Invalid json")
                    continue
                }

                do {
                    let response = try JSONDecoder().decode(CardSubmitResponse.self, from: data)
                    self?.activeCardsUpdated?(response.activeCards)
                } catch {
                    assertionFailure(error.localizedDescription)
                }
            }
        }

        socket?.on(Event.startGame.rawValue) { [weak self] _, _ in
            self?.startGame?()
        }

        socket?.on(Event.endGame.rawValue) { _, _ in
            print("end-game")
        }
    }

    func send(_ event: Event, data: SocketData? = nil) {
        if let data = data {
            socket?.emit(event.rawValue, data)
        } else {
            socket?.emit(event.rawValue)
        }
    }

    func disconnect() {
        socket?.disconnect()
        activeGame = false
    }
}
