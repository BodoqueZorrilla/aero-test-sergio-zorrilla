//
//  ViewContrllerExtension.swift
//  AlboAeroTestSZ
//
//  Created by Sergio Eduardo Zorrilla Arellano on 07/06/21.
//

import Foundation
import UIKit

enum StoryboardsName: String {
    case main = "Main"
    case map = "MapAirports"
    case list = "ListAirports"
}

extension UIViewController {
    static func instantiate(storyboard: StoryboardsName) -> Self? {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let identifier = String(describing: self)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? Self else {
            return nil
        }
        return viewController
    }
}
