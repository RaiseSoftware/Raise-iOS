//
//  Player.swift
//  Raise
//
//  Created by Stephen Hayes on 3/4/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import Foundation

struct Player: Codable {
    
    let name: String
    let roles: [Role]

    enum Role: String, Codable {
        case moderator = "MODERATOR"
    }

    init(name: String, roles: [Role]) {
        self.name = name
        self.roles = roles
    }
}
