//
//  DashboardViewController.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/4/21.
//

import UIKit

class DashboardViewController: UIViewController {
    
    enum Constants {
        static let cellIdentifier = "DCategoryViewController"
        static let modalTitle = "Thank you Bell Canada! 🙏"
        static let message = "I'm very excited about the opportunity! Please do not hesitate to contact me if I can provide additional information about this exercice. 🎉"
    }
    
    // MARK: - Outlets
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Presenter
    lazy var presenter: DashboardPresenter = DashboardPresenter(delegate: self)
    
    // MARK: - Sub Controllers
    var controllers: [DCategoryViewController] = [DCategoryViewController]()
    var headerView: DHeaderViewController?
        
    //MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?
            .navigationBar.setStyle(.white)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildControllers()
        presenter.trackLocation()
        handleSearchAction()
        addAvatar()
    }
    
    private func addAvatar() {
        let avatar = AvatarButton()
        avatar.didSelect = { [weak self] in
            self?.showAlert()
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: avatar)
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: Constants.modalTitle,
                                                message: Constants.message, preferredStyle: .alert)
        
        let action: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(action)
        
        navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    private func handleSearchAction() {
        headerView?.wantsToSearch = { [weak self] in
            guard let self = self else {
                return
            }
            
            let viewController = Module.search.initialController
            self.navigationController?.pushViewController(viewController, animated: false)
        }
    }
    
    // create child controllers for the categories
    private func addChildControllers() {
        for category in BestCategory.allCases {
            guard let viewController: DCategoryViewController = self.storyboard?
                    .instantiateViewController(identifier: Constants.cellIdentifier)
            else { return }
            
            viewController.setup(category)
            add(viewController, height: 380, in: stackView)
            controllers.append(viewController)
            
            // Handle showing of business when the category rows is selected
            viewController.wantsToShow = { [weak self] business in
                guard let viewController = Module.details.initialController as? DetailsViewController else { return }
                viewController.business = business
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? DHeaderViewController {
            headerView = viewController
        }
    }
}

//MARK: Presenter functions
extension DashboardViewController: DashboardPresenterDelegate {
    
    func presentCompactLocation(location: String) {
        headerView?.setLocation(location)
    }
    
}
