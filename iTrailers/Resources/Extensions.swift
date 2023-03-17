//
//  Extensions.swift
//  iTrailers
//
//  Created by Wilson Mungai on 2023-03-17.
//

import Foundation
import UIKit

//Extension to modify apples default addSubView uiview
extension UIView
{
    func addSubviews(_ views: UIView...)
    {
        views.forEach({
            addSubview($0)
        })
    }
}
