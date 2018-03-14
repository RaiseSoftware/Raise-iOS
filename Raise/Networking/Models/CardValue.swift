//
//  CardValue.swift
//  Raise
//
//  Created by Stephen Hayes on 3/13/18.
//  Copyright © 2018 Raise Software. All rights reserved.
//

import Foundation
import UIKit

enum CardValue: String, Codable {

    // T-Shirt Sizes
    case xSmall = "X_SMALL"
    case small = "SMALL"
    case medium = "MEDIUM"
    case large = "LARGE"
    case xLarge = "X_LARGE"

    // Fibonacci
    case zero = "ZERO"
    case oneHalf = "ONE_HALF"
    case one = "ONE"
    case two = "TWO"
    case three = "THREE"
    case five = "FIVE"
    case eight = "EIGHT"
    case thirteen = "THIRTEEN"
    case twenty = "TWENTY"
    case forty = "FORTY"
    case oneHundred = "ONE_HUNDRED"
    case infinity = "INFINITY"

    // Other
    case questionMark = "QUESTION_MARK"
    case coffee = "COFFEE"

    var image: UIImage {
        switch self {
        case .xSmall:
            return #imageLiteral(resourceName: "Card-Question")
        case .small:
            return #imageLiteral(resourceName: "Card-Question")
        case .medium:
            return #imageLiteral(resourceName: "Card-Question")
        case .large:
            return #imageLiteral(resourceName: "Card-Question")
        case .xLarge:
            return #imageLiteral(resourceName: "Card-Question")
        case .zero:
            return #imageLiteral(resourceName: "Card-0")
        case .oneHalf:
            return #imageLiteral(resourceName: "Card-Half")
        case .one:
            return #imageLiteral(resourceName: "Card-1")
        case .two:
            return #imageLiteral(resourceName: "Card-2")
        case .three:
            return #imageLiteral(resourceName: "Card-3")
        case .five:
            return #imageLiteral(resourceName: "Card-5")
        case .eight:
            return #imageLiteral(resourceName: "Card-8")
        case .thirteen:
            return #imageLiteral(resourceName: "Card-13")
        case .twenty:
            return #imageLiteral(resourceName: "Card-20")
        case .forty:
            return #imageLiteral(resourceName: "Card-40")
        case .oneHundred:
            return #imageLiteral(resourceName: "Card-100")
        case .infinity:
            return #imageLiteral(resourceName: "Card-Infinity")
        case .questionMark:
            return #imageLiteral(resourceName: "Card-Question")
        case .coffee:
            return #imageLiteral(resourceName: "Card-Coffee")
        }
    }
}
