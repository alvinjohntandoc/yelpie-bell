//
//  DHeaderViewController.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import UIKit

class DHeaderViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var searchView: UIView! {
        didSet {
            searchView.layer.cornerRadius = 5
        }
    }
    
    var wantsToSearch: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchViewtapped))
        searchView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func searchViewtapped() {
        wantsToSearch?()
    }
    
    func setLocation(_ location: String) {
        locationLabel.text = location
    }

}
