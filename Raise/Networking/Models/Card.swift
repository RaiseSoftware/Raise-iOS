//
//  Card.swift
//  Raise
//
//  Created by Stephen Hayes on 3/13/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import Foundation

struct Card: Codable {

    let type: DeckType
    let value: CardValue
}
