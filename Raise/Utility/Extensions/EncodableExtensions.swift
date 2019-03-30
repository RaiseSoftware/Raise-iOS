//
//  EncodableExtensions.swift
//  Raise
//
//  Created by Stephen Hayes on 3/23/19.
//  Copyright © 2019 Raise Software. All rights reserved.
//

import Foundation

extension Encodable {

    func toJSONDictionary() -> [String: Any] {
        let encoder = JSONEncoder()
        let encoded = try? JSONSerialization.jsonObject(with: encoder.encode(self))
        let dictionary = encoded as? [String: Any] ?? [:]
        return dictionary
    }
}
