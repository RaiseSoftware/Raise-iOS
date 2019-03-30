//
//  PokerGame.swift
//  Raise
//
//  Created by Stephen Hayes on 3/11/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import Foundation

struct PokerGame: Codable {

    let gameName: String
    let deckType: DeckType
    let qrcode: String
    let passcode: String
    let players: [Player]

    init(gameName: String, deckType: DeckType, qrcode: String, passcode: String, players: [Player]) {
        self.gameName = gameName
        self.deckType = deckType
        self.qrcode = qrcode
        self.passcode = passcode
        self.players = players
    }
}
