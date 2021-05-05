//
//  UIView+AddChildView.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import UIKit

extension UIViewController {
    
    func add(_ child: UIViewController, height: CGFloat , in stack: UIStackView) {
        addChild(child)
        
        child.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            child.view.heightAnchor.constraint(equalToConstant: height)
        ])
        
        stack.addArrangedSubview(child.view)
        
        child.didMove(toParent: self)
    }

}
