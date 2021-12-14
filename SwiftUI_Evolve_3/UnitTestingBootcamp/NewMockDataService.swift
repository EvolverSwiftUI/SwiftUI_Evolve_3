//
//  NewMockDataService.swift
//  SwiftUI_Evolve_3
//
//  Created by Sivaram Yadav on 12/14/21.
//

import Foundation
import SwiftUI
import Combine

protocol NewDataServiceProtocol {
    func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> Void)
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error>
}


// This MOCK version will be useful
// for development or testing purpose
class NewMockDataService: NewDataServiceProtocol {
    
    let items: [String]
    
    init(items: [String]?) {
        self.items = items ?? [
            "ONE", "TWO", "THREE"
        ]
    }
    
    func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(self.items)
        }
    }
    
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error> {
        Just(items)
            .tryMap({ publishedItems in
                guard !publishedItems.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                return publishedItems
            })
            .eraseToAnyPublisher()
    }
}
