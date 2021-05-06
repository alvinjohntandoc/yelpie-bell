//
//  DetailsViewController.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    
    enum Constants {
        static let reviews = "Reviews"
    }
    
    //MARK: - Injectable properties
    var business: Business!
    
    //MARK: - IBoutlets
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.contentInset = .init(top: 0, left: 0, bottom: 50, right: 0)
            tableView.tableFooterView = UIView()
        }
    }
    
    //MARK: - Presenter
    lazy var presenter = DetailsPresenter(delegate: self)
    
    //MARK: - Reviews
    var reviews: [Review] = []
    
    var sections: [DetailSection] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setStyle(.transparent)
        
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func loadData() {
        coverImageView.kf.setImage(with: URL(string: business.imageURL),
                                   options:  [.transition(.fade(1.0))])
        
        // lets display the previous data
        // generate initial items
        presenter.generateSections(business)
        
        // lets get the complete business details
        presenter.getFullDetails(business)
    }
    
}

extension DetailsViewController: DetailsPresenterDelegate {
    
    func presentSections(sections: [DetailSection]) {
        self.sections = sections
    }
    
    func presentBusinessFullDetails(business: Business) {
        self.business = business
        
        // regenerate items because now we have the other details
        presenter.generateSections(business)
    }
    
}

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let mySection = sections[section]
        
        switch mySection {
        case .info(let items):
            return items.count
        case .review(let items):
            return items.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mySection = sections[indexPath.section]
        var items: [DetailsItem] = []
        
        switch mySection {
        case .info(let sectionItems):
            items = sectionItems
        case .review(let sectionItems):
            items = sectionItems
        }
        
        let item = items[indexPath.row]
        
        switch item {
        case .basic(let business):
            guard let cell: BasicDetailsTableViewCell = tableView
                    .dequeueReusableCell(withIdentifier: BasicDetailsTableViewCell.reuseIdentifier)
                    as? BasicDetailsTableViewCell else {
                
                preconditionFailure("Can't dequeue cell")
            }
            
            cell.bind(business)
            
            return cell
        case .titleAndValue(let title, let value):
            guard let cell: TitleValueTableViewCell = tableView
                    .dequeueReusableCell(withIdentifier: TitleValueTableViewCell.reuseIdentifier)
                    as? TitleValueTableViewCell else {
                
                preconditionFailure("Can't dequeue cell")
            }
            
            cell.bind(title, value: value)
            
            return cell
        case .review(let review):
            guard let cell: ReviewTableViewCell = tableView
                    .dequeueReusableCell(withIdentifier: ReviewTableViewCell.reuseIdentifier)
                    as? ReviewTableViewCell else {
                preconditionFailure("Can't dequeue cell")
            }
            
            cell.bind(review)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let mySection = sections[section]
        guard case DetailSection.review = mySection else { return 0 }
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let mySection = sections[section]
        
        guard case DetailSection.review = mySection else { return nil }
        
        return reviewHeaderView()
    }
    
    private func reviewHeaderView() -> UIView {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = Constants.reviews
        label.font = .avenirFont(ofSize: 16, weight: .black)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let containerView = UIView()
        containerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: containerView.topAnchor),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }
}
