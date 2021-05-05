//
//  ViewController.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/4/21.
//

import UIKit
import Lottie

class MainViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var loaderAnimationView: AnimationView! {
        didSet {
            DispatchQueue.main.async {
                self.loaderAnimationView.addBottomRoundedEdge(desiredCurve: 1.5)
            }
        }
    }

    @IBOutlet weak var startButton: ATButton!
    
    //MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?
            .navigationBar.setStyle(.hidden)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loaderAnimationView.loopMode = .loop
        loaderAnimationView.play()
        
        startButton.titleLabel?.font = .avenirFont(ofSize: 17, weight: .black)
    }

    @IBAction func getStartedAction(_ sender: Any) {
        let viewController = Module.dashboard.initialController
        navigationController?.setViewControllers([viewController], animated: true)
    }
}

