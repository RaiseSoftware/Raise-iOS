//
//  JoinLeaveGameResponse.swift
//  Raise
//
//  Created by Stephen Hayes on 3/4/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import Foundation

struct JoinLeaveGameResponse: Codable {

    let type: String
    let players: [Player]

    enum CodingKeys: String, CodingKey {
        case type
        case players = "data"
    }
}
