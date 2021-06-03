//
//  UIStackView+.swift
//  GooglePlacesAPI
//
//  Created by Harsh Jaiswal on 03/06/21.
//

import Foundation
import UIKit

extension UIStackView {
    func resetStack() {
        self.arrangedSubviews.forEach { (view) in
            self.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
