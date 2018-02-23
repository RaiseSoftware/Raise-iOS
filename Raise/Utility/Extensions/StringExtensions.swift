//
//  StringExtensions.swift
//  Raise
//
//  Created by Stephen Hayes on 2/22/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import Foundation

extension String {

    func toDictionary() -> [String: Any]? {
        if let data = data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                assertionFailure(error.localizedDescription)
            }
        }

        return nil
    }
}
