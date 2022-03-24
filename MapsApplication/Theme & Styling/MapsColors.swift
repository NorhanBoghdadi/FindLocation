//
//  MapsColors.swift
//  MapsApplication
//
//  Created by Norhan Boghdadi on 3/23/22.
//

import Foundation
import UIKit

enum MapsColor: String {
    case BackgroundColor
    case MoiaBrandColor
    case PrimaryTextColor
    case SecondaryTextColor
}

extension UIColor {
    static func color(for mapsColor: MapsColor) -> UIColor {
        UIColor(named: mapsColor.rawValue) ?? UIColor()
    }
}
