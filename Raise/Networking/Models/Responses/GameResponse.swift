//
//  GameResponse.swift
//  Raise
//
//  Created by Stephen Hayes on 2/20/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import Foundation

struct GameResponse: Codable {

    let pokerGame: PokerGame
    let token: Token
}
