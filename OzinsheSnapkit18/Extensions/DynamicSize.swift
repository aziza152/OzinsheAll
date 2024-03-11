//
//  DynamicSize.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 23.02.2024.
//

import Foundation
import UIKit

extension NSObject {
    func dynamicValue(for size: CGFloat) -> CGFloat {
        let screenSize = UIScreen.main.bounds.size
        let baseScreenSize = CGSize(width: 375, height: 812)
        let scaleFactor = min(screenSize.width, screenSize.height) / min(baseScreenSize.width, baseScreenSize.height)

        return size * scaleFactor
    }
}
