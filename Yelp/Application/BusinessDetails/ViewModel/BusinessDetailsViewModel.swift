//
//  BusinessDetailsViewModel.swift
//  Yelp
//
//  Created by Jade Lapuz on 4/21/21.
//

import Foundation
import Combine

class BusinessDetailsViewModel {
    
    private(set) var business: BusinessModel?
    private var requestManager: YelpRequestManagerProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    private let businessId: String
    
    init(id: String, requestManager: YelpRequestManager) {
        self.businessId = id
        self.requestManager = requestManager
    }
    
    func fetchBusinessDetails(completion: @escaping () -> (), failure: @escaping(String) -> ()) {
        requestManager.getBusinessDetails(id: businessId).sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                failure("Something went wrong. Please try again")
            case .finished:
                break
            }
        }, receiveValue: { [weak self] result in
            self?.business = result
            completion()
        }).store(in: &cancellables)
    }
}
