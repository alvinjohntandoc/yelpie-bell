//
//  UINavigationBar+Transparent.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/4/21.
//

import Foundation
import UIKit

public extension UINavigationBar {
    
    func setBarColor(_ barColor: UIColor?) {
        if barColor != nil && barColor!.cgColor.alpha == 0 {
            // if transparent color then use transparent nav bar
            setBackgroundImage(UIImage(), for: .default)
            hideShadow(true)
        } else if barColor != nil {
            // use custom color
            setBackgroundImage(self.image(with: barColor!), for: .default)
            hideShadow(true)
        } else {
            // restore original nav bar color
            setBackgroundImage(nil, for: .default)
            hideShadow(false)
        }
    }
    
    private func hideShadow(_ doHide: Bool) {
        self.shadowImage = doHide ? UIImage() : nil
    }
    
    private func image(with color: UIColor) -> UIImage {
        let rect = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(1.0), height: CGFloat(1.0))
        UIGraphicsBeginImageContext(rect.size)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(rect)
        }
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
