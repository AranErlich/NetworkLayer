//
//  ContentViewModel.swift
//  NetworkLayer
//
//  Created by Aran Erlich on 16/06/2022.
//

import Foundation
import Combine

protocol ContentViewModelProtocol: ObservableObject {
    var email: String { get set }
    var password: String { get set }
    func auth()
}

class ContentViewModel: ContentViewModelProtocol {
    
    @Published var email: String = ""
    @Published var password: String = ""
    private var networkService: ContentNetworkServiceProtocol
    
    init() {
        networkService = ContentNetworkService()
    }
    
    func auth() {
        Task {
            // should perfrom any validation required
            let contentModel = ContentModel(email: email, password: password)
            await networkService.auth(model: contentModel)
        }
    }
    
}
