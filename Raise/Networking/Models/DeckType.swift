//
//  DeckType.swift
//  Raise
//
//  Created by Stephen Hayes on 2/20/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import Foundation

enum DeckType: String, Codable {
    case fibonacci = "FIBONACCI"
    case tshirt = "TSHIRT"

    var cards: [Card] {
        switch self {
        case .fibonacci:
            return [
                Card(type: self, value: .zero),
                Card(type: self, value: .oneHalf),
                Card(type: self, value: .one),
                Card(type: self, value: .two),
                Card(type: self, value: .three),
                Card(type: self, value: .five),
                Card(type: self, value: .eight),
                Card(type: self, value: .thirteen),
                Card(type: self, value: .twenty),
                Card(type: self, value: .forty),
                Card(type: self, value: .oneHundred),
                Card(type: self, value: .infinity),
                Card(type: self, value: .questionMark),
                Card(type: self, value: .coffee)
            ]
        case .tshirt:
            return [
                Card(type: self, value: .xSmall),
                Card(type: self, value: .small),
                Card(type: self, value: .medium),
                Card(type: self, value: .large),
                Card(type: self, value: .xLarge),
                Card(type: self, value: .questionMark),
                Card(type: self, value: .coffee)
            ]
        }
    }
}
