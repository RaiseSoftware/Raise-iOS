//
//  CardSubmitResponse.swift
//  Raise
//
//  Created by Stephen Hayes on 3/13/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import Foundation

struct CardSubmitResponse: Codable {

    let type: String
    let activeCards: [ActiveCard]

    enum CodingKeys: String, CodingKey {
        case type
        case activeCards = "data"
    }
}
