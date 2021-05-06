//
//  AvatarButton.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/4/21.
//

import UIKit

class AvatarButton: UIButton {

    enum Constants {
        static let emoji = "emoji"
    }
    
    /// If the button is selected
    var didSelect: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let image = UIImage(named: Constants.emoji)
        self.setImage(image, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let imageInset: CGFloat = 3
        self.imageEdgeInsets = .init(top: imageInset, left: imageInset, bottom: imageInset, right: imageInset)
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 35),
            self.widthAnchor.constraint(equalToConstant: 35)
        ])
        
        self.addTarget(self, action: #selector(didSelectButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didSelectButton() {
        didSelect?()
    }
}
