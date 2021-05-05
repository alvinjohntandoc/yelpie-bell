//
//  DCategoriesViewController.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import UIKit

class DCategoryViewController: UIViewController {

    enum Constants {
        static let cellIdentifier = "ThumbnailCollectionViewCell"
    }
    
    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.decelerationRate = .fast
        }
    }

    //MARK: - Injectable Properties
    var category: BestCategory!
    
    //MARK: Properties
    var thumbnailables: Thumbnailables = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK: - Presenter
    private lazy var presenter = DCategoryViewPresenter(delegate: self)
    
    //MARK: - Output
    var wantsToShow: ((Business) -> Void)?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleLabel.text = category.title
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        presenter.startLocationTracking()
    }
    
    func setup(_ category: BestCategory) {
        self.category = category
    }
    
}

//MARK: - Presenters Delegate
extension DCategoryViewController: DCategoryViewPresenterDelegate {
    
    func presentThumbnailables(thumbnailables: Thumbnailables) {
        self.thumbnailables = thumbnailables
    }
    
    func presentBusiness(business: Business) {
        wantsToShow?(business)
    }
    
    func locationIsAvailable() {
        presenter.search(category: category)
    }
}

//MARK: - UICollectionView Data Source and Delegates
extension DCategoryViewController: UICollectionViewDelegate,
                                   UICollectionViewDataSource,
                                   UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return thumbnailables.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 250, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ThumbnailCollectionViewCell = collectionView
            .dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier,
                                 for: indexPath) as! ThumbnailCollectionViewCell
        
        let thumbnail = thumbnailables[indexPath.row]
        
        cell.bind(thumbnail)
        cell.addShadow()
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.convertAndPresentThumbnailable(thumbnailables[indexPath.row])
    }
    
}
