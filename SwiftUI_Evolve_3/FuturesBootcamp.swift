//
//  FuturesBootcamp.swift
//  SwiftUI_Evolve_3
//
//  Created by Sivaram Yadav on 1/25/22.
//

import SwiftUI
import Combine

// download with Combine
// download with @escaping closure
// convert @escaping closures into Combine

class FuturesBootcampViewModel: ObservableObject {
    
    @Published var title: String = "Starting title"
    let url = URL(string: "https://www.google.com")!
    var cancellables = Set<AnyCancellable>()
    
    init() {
        download()
    }
    
    func download() {
//        getCombinePublisher()
//            .sink(receiveCompletion: { _ in
//
//            }) { [weak self] (returnedValue) in
//                self?.title = returnedValue
//            }
//            .store(in: &cancellables)
        
//        getEscapingClosure { [weak self] (returnedValue, error) in
//            DispatchQueue.main.async {
//                self?.title = returnedValue
//            }
//        }
        
        //getFuturePublisher()
        doSomethingInFuture()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] returnedValue in
                self?.title =  returnedValue
            }
            .store(in: &cancellables)
    }
    
    func getCombinePublisher() -> AnyPublisher<String, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .timeout(1, scheduler: DispatchQueue.main)
            .map({ _ in
                return "New Value"
            })
            .eraseToAnyPublisher()
    }
    
    func getEscapingClosure(completion: @escaping (String, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            completion("New Value 2333", nil)
        }
        .resume()
    }
    
    func getFuturePublisher() -> Future<String, Error> {
        return Future { promise in
            self.getEscapingClosure { (returnedValue, error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(returnedValue))
                }
            }
        }
    }
    
    
    // Simple code to convert
    // @escaping closure to Combine Future Publisher easily
    func doSomething(completion: @escaping (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            completion("NEW STRING")
        }
    }
    
    func doSomethingInFuture() -> Future<String, Never> {
        Future { promise in
            self.doSomething { value in
                promise(.success(value))
            }
        }
    }
}

struct FuturesBootcamp: View {
    
    @StateObject private var vm = FuturesBootcampViewModel()
    
    var body: some View {
        Text(vm.title)
    }
}

struct FuturesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FuturesBootcamp()
    }
}
