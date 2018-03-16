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
    case xSmall = "XS"
    case small = "S"
    case medium = "M"
    case large = "L"
    case xLarge = "XL"

    // Fibonacci
    case zero = "0"
    case oneHalf = "1/2"
    case one = "1"
    case two = "2"
    case three = "3"
    case five = "5"
    case eight = "8"
    case thirteen = "13"
    case twenty = "20"
    case forty = "40"
    case oneHundred = "100"
    case infinity

    // Other
    case questionMark = "?"
    case coffee

    var image: UIImage {
        switch self {
        case .xSmall:
            return #imageLiteral(resourceName: "Card-XS")
        case .small:
            return #imageLiteral(resourceName: "Card-S")
        case .medium:
            return #imageLiteral(resourceName: "Card-M")
        case .large:
            return #imageLiteral(resourceName: "Card-L")
        case .xLarge:
            return #imageLiteral(resourceName: "Card-XL")
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
