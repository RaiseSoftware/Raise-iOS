//
//  CardSubmitRequest.swift
//  Raise
//
//  Created by Stephen Hayes on 3/13/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import SocketIO

struct CardSubmitRequest: SocketData {

    let type: DeckType
    let value: CardValue

    func socketRepresentation() -> SocketData {
        return ["type": type.rawValue, "value": value.rawValue]
    }
}
