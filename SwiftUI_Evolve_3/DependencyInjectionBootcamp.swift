//
//  DependencyInjectionBootcamp.swift
//  SwiftUI_Evolve_3
//
//  Created by Sivaram Yadav on 12/13/21.
//

import SwiftUI
import Combine


// PROBLEMS WITH SINGLETONS
// 1. Singleton's are GLOBAL.
// 2. Can't customize the init!
// 3. Can't swap out dependencies


// To pass multiple dependencies
// through app by using a class of Depedencies
//class Dependencies {
//
//    let dataService: DataServiceProtocol
//
//    init(dataService: DataServiceProtocol) {
//        self.dataService = dataService
//    }
//}

struct PostModel: Identifiable, Codable {
    
    let userId  : Int
    let id      : Int
    let title   : String
    let body    : String
}

protocol DataServiceProtocol {
    func getData() -> AnyPublisher<[PostModel], Error>
}

class ProductionDataService: DataServiceProtocol {
    
//    static let instance = ProductionDataService() // Singleton
    
//    init(title: String) {
//
//    }
    
    //let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func getData() -> AnyPublisher<[PostModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class MockDataService: DataServiceProtocol {
    
    let testData: [PostModel]
    
    init(data: [PostModel]?) {
        testData = data ?? [
            PostModel(userId: 1, id: 1, title: "One", body: "one"),
            PostModel(userId: 2, id: 2, title: "Two", body: "two"),
            PostModel(userId: 3, id: 3, title: "Three", body: "three"),
            PostModel(userId: 4, id: 4, title: "Four", body: "four")
        ]
    }
    
    func getData() -> AnyPublisher<[PostModel], Error> {
        Just(testData)
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
}


class DependencyInjectionViewModel: ObservableObject {
    
    @Published var dataArray: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    let dataService: DataServiceProtocol
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        loadPosts()
    }
    
    private func loadPosts() {
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedPosts in
                self?.dataArray = returnedPosts
            }
            .store(in: &cancellables)
    }
    
}

struct DependencyInjectionBootcamp: View {
    
   // @StateObject private var vm = DependencyInjectionViewModel()
    @StateObject private var vm: DependencyInjectionViewModel
    
    init(dataService: DataServiceProtocol) {
        _vm = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(vm.dataArray) { post in
                    Text(post.title)
                        .padding()
                }
            }
        }
    }
}

struct DependencyInjectionBootcamp_Previews: PreviewProvider {
//    static let dataservice = ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    //static let dataservice = MockDataService(data: nil)
    static let dataservice = MockDataService(data: [
        PostModel(userId: 1234, id: 1234, title: "Test", body: "test"),
        PostModel(userId: 12345, id: 12345, title: "Test 2", body: "test 2")
    ])
    
    static var previews: some View {
        DependencyInjectionBootcamp(dataService: dataservice)
    }
}
