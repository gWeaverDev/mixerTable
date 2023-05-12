//
//  UIView+Layout.swift
//  mixerTable
//
//  Created by George Weaver on 11.05.2023.
//

import UIKit

extension UIView {
    
    func addSubviewsWithoutAutoresizing(_ subviews: UIView...) {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
}
