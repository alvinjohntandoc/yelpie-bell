//
//  SearchViewController.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import UIKit

class SearchViewController: UIViewController {

    enum Constants {
        static let cancel = "Cancel"
    }
    
    //MARK: Outlets
    @IBOutlet weak var searchView: UIView! {
        didSet {
            searchView.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.contentInset = .init(top: 0, left: 0, bottom: 300, right: 0)
            tableView.tableFooterView = UIView()
        }
    }
    
    //MARK: Properties
    private var thumbnailables: Thumbnailables = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var sort: Sort = .bestMatch
    
    //MARK: Presenter
    lazy var presenter = SearchViewPresenter(delegate: self)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setStyle(.hidden)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        searchTextField.delegate = self
        presenter.startLocationTracking()
    }
    
    //MARK: - Actions
    @objc func textFieldDidChange(_ textField: UITextField) {
        let keyword = textField.text ?? ""
        
        presenter.search(keyword: keyword, sort: sort)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func sortAction(_ sender: Any) {
        searchTextField.endEditing(true)
        presenter.createSortingOptions()
    }
}

//MARK: - UICollectionView Data Source and Delegates
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thumbnailables.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: ThumbnailCollectionViewCell = collectionView
            .dequeueReusableCell(withReuseIdentifier: ThumbnailCollectionViewCell.reuseIdentifier,
                                 for: indexPath) as? ThumbnailCollectionViewCell else {
            preconditionFailure("Can't dequeue cell")
        }
        
        let thumbnail = thumbnailables[indexPath.row]
        
        cell.bind(thumbnail)
        cell.addShadow()
        
        return cell
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let thumbnailable = thumbnailables[indexPath.row]
        
        guard let cell: SearchTableViewCell = tableView
                .dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier)
                as? SearchTableViewCell else {
            preconditionFailure("Can't dequeue cell")
        }
        
        cell.bind(thumbnailable)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.convertAndPresentThumbnailable(thumbnailables[indexPath.row])
    }
    
}

//MARK: - Presenter functions
extension SearchViewController: SearchViewPresenterDelegate {
    
    func presentThumbnailables(thumbnailables: Thumbnailables) {
        self.thumbnailables = thumbnailables
    }
    
    func presentBusiness(business: Business) {
        guard let viewController = Module.details.initialController as? DetailsViewController else { return }
        viewController.business = business
        self.navigationController?.pushViewController(viewController, animated: true)
    }
 
    // create an action sheet with all the available sorting options
    func presentSortOptions(options: [Sort]) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        options.forEach { option in
            let action = UIAlertAction(title: option.title, style: .default) { [weak self] alertAction in
                guard let self = self else { return }
            
                guard let sort = options.filter({ $0.title == alertAction.title }).first else { return }
                self.sort = sort
                
                let keyword = self.searchTextField.text ?? ""
                self.presenter.search(keyword: keyword, sort: sort)
            }
            
            alertController.addAction(action)
        }
        
        let action = UIAlertAction(title: Constants.cancel, style: .cancel, handler: nil)
        alertController.addAction(action)
        
        navigationController?.present(alertController, animated: true, completion: nil)
    }
    
}

/// Dismiss keyboard if return button was tapped
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        
        return true
    }
}
