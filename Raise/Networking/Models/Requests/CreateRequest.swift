//
//  CreateRequest.swift
//  Raise
//
//  Created by Stephen Hayes on 2/20/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import Foundation

struct CreateRequest: Codable {

    let pokerGame: PokerGame
    let moderator: Moderator

    struct PokerGame: Codable {
        let gameName: String
        let deckType: DeckType
        let requiresPassword: Bool
    }

    struct Moderator: Codable {
        let name: String
    }

    init(gameName: String, deckType: DeckType, requiresPassword: Bool, moderatorName: String) {
        pokerGame = PokerGame(gameName: gameName, deckType: deckType, requiresPassword: requiresPassword)
        moderator = Moderator(name: moderatorName)
    }
}
