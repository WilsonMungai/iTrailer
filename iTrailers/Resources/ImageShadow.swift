//
//  File.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-25.
//

import UIKit

//import UIKit
extension UIView {
    func dropShadow() {
        layer.cornerRadius = 25
        layer.shadowColor = UIColor.label.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowOpacity = 0.9
        layer.shadowRadius = 2.0
//        layer.masksToBounds = false
        layer.cornerRadius = 4.0
    }
}

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
