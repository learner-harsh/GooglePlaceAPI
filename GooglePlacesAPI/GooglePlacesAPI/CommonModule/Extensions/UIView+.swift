//
//  UIView+.swift
//  GooglePlacesAPI
//
//  Created by Harsh Jaiswal on 03/06/21.
//

import Foundation
import UIKit

extension UIView {
    func cornerReduis(reduis:Int,BGColor:UIColor,borderColor:UIColor?,borderWidth:Double){
        self.layer.cornerRadius = CGFloat(reduis)
        self.layer.backgroundColor = backgroundColor?.cgColor
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = CGFloat(borderWidth)
        self.clipsToBounds = true
    }
}
