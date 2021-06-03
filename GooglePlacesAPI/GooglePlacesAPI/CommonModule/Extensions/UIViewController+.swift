//
//  UIViewController+.swift
//  GooglePlacesAPI
//
//  Created by Harsh Jaiswal on 03/06/21.
//

import Foundation
import UIKit

extension UIViewController {
    func toNavigation(barColor: UIColor, tintColor: UIColor, VisualEffectView _: Bool = false) -> UINavigationController {
        let nav = UINavigationController(rootViewController: self)
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.tintColor = tintColor
        nav.navigationBar.barTintColor = barColor
        nav.navigationBar.titleTextAttributes = textAttributes
        nav.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "backButton")
        nav.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "backButton")
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

        return nav
    }
}
