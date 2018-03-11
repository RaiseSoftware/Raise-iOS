//
//  PokerGame.swift
//  Raise
//
//  Created by Stephen Hayes on 3/11/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import Foundation

struct PokerGame: Codable {

    let gameId: String
    let passcode: String?
    let qrcode: String
    let deckType: DeckType
}
