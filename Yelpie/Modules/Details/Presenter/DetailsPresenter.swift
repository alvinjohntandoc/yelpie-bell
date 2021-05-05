//
//  DetailsPresenter.swift
//  Yelpie
//
//  Created by Alvin John Tandoc on 5/5/21.
//

import Foundation
import UIKit

protocol DetailsPresenterDelegate: AnyObject {
    
    /// present items that will be displayed in the table view
    func presentSections(sections: [DetailSection])
    
    /// Business with full details
    func presentBusinessFullDetails(business: Business)
}

class DetailsPresenter {
    
    enum Constants {
        static let regular = "REGULAR"
        static let regularTitle = "Regular Hour"
        static let contactTitle = "Contact"
        static let categoryTitle = "Category"
    }
    
    //MARK: - Properties
    private weak var delegate: DetailsPresenterDelegate?
    
    // MARK: - Services
    private let apiService = SearchAPIService()
    
    // semaphore will handle our async operations
    private let semaphore = DispatchSemaphore(value: 0)
    
    // we will combine business and review later
    private var _business: Business?
    
    init(delegate: DetailsPresenterDelegate) {
        self.delegate = delegate
    }
    
    /// This will complete the missing details in our business object
    /// Hours & Reviews will be added
    /// 2 api requiest will be triggred one for business/{alias} and business/reviews
    ///
    /// - Parameter:
    ///     - business: The business that we want to complete the details
    func getFullDetails(_ business: Business) {
        let dispatchQueue = DispatchQueue.global(qos: .background)
        dispatchQueue.async { [weak self] in
            guard let self = self else { return }
            self.getOtherBusinessDetails(for: business)
            self.getReviews(for: business)
            
            DispatchQueue.main.async {
                guard let _business = self._business else { return }
                self.delegate?.presentBusinessFullDetails(business: _business)
            }
        }
    }
    
    /// This will complete the missing details in our business object
    /// Hours will be added and will fetch reviews after the call
    ///
    /// - Parameter:
    /// - business: The business that we want to complete the details
    private func getOtherBusinessDetails(for business: Business) {
        apiService.request(.businessDetails(alias: business.alias),
                           target: Business.self) { [weak self] (myBusiness) in
            guard let self = self else { return }
            var updatedBusiness = myBusiness
            updatedBusiness.distance = business.distance
            self._business = updatedBusiness
            self.semaphore.signal()
        }
        
        semaphore.wait()
    }
    
    /// This will get reviews of the business
    ///
    /// - Parameter:
    /// - business: The business that we want to complete the details
    private func getReviews(for business: Business) {
        
        apiService.request(.reviews(alias: business.alias),
            target: ReviewsResponse.self) { [weak self] (response) in
            guard let self = self else { return }
            self._business?.reviews = response.reviews
            self.semaphore.signal()
        }
        
        semaphore.wait()
    }
    
    /// Will generate enum sections from the business
    ///
    /// - Parameter:
    /// - business: The business that we want to display in the table view
    func generateSections(_ business: Business) {
        
        var sections: [DetailSection] = []
        
        let basic = generateBasic(for: business)
        let category = generateCategories(for: business)
        let regularHours = generateOperatingHours(for: business)
        let contact = generateContact(for: business)
        
        let items = [basic, contact, category, regularHours].compactMap { $0 }
        
        let sectionInfo = DetailSection.info(items: items)
        sections.append(sectionInfo)
        
        if let reviews = business.reviews {
            let items = reviews.map { DetailsItem.review(item: $0) }
            let sectionReviews = DetailSection.review(items: items)
            sections.append(sectionReviews)
        }
        
        delegate?.presentSections(sections: sections)
    }
    
    private func generateBasic(for business: Business) -> DetailsItem {
        return DetailsItem.basic(business: business)
    }
    
    private func generateCategories(for business: Business) -> DetailsItem {
        let categories = business.categories.map { $0.title }.joined(separator: ", ")
        return DetailsItem.titleAndValue(title: Constants.categoryTitle, value: categories)
    }
    
    private func generateOperatingHours(for business: Business) -> DetailsItem? {
        
        guard let hour = business.hours?.filter({ $0.hoursType == Constants.regular }).first else {
            return nil
        }
        
        var details: [String] = [String]()
        
        for open in hour.hourOpen {
            let day = open.day.word
            let opening = open.start.as12HourFormat ?? ""
            let closing = open.end.as12HourFormat ?? ""
            
            details.append("\(day): \(opening) - \(closing)")
        }
        
        return DetailsItem.titleAndValue(title: Constants.regularTitle, value: details.joined(separator: "\n"))
    }
    
    private func generateContact(for business: Business) -> DetailsItem {
        return DetailsItem.titleAndValue(title: Constants.contactTitle, value: business.displayPhone)
    }

}

