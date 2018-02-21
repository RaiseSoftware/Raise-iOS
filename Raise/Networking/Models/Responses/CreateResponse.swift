//
//  CreateResponse.swift
//  Raise
//
//  Created by Stephen Hayes on 2/20/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import Foundation

struct CreateResponse: Codable {

    let pokerGame: PokerGame

    struct PokerGame: Codable {
        let gameId: String
        let passcode: String?
    }
}
