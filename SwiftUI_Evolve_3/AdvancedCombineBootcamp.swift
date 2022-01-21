//
//  AdvancedCombineBootcamp.swift
//  SwiftUI_Evolve_3
//
//  Created by Sivaram Yadav on 1/19/22.
//

import SwiftUI
import Combine

class AdvancedCombineDataService {
    
//    @Published var basicPublisher: [String] = []
//    @Published var basicPublisher: String = ""
    @Published var basicPublisher: String = "first publish"
    //let currentValuePublisher = CurrentValueSubject<String, Never>("first publish")
    let currentValuePublisher = CurrentValueSubject<String, Error>("first publish")
    //let passThroughPublisher = PassthroughSubject<String, Error>()
    let passThroughPublisher = PassthroughSubject<Int, Error>()

    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.basicPublisher = ["one", "two", "three"]
//        }
        
        //let items = ["one", "two", "three"]
        let items = Array(0..<11)

        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
                //self.basicPublisher = items[x]
                //self.currentValuePublisher.send(items[x])
                //self.passThroughPublisher.send(items[x])
                self.passThroughPublisher.send(items[x])
            }
        }
    }
}

class AdvancedCombineBootcampViewModel: ObservableObject {
    
    @Published var data: [String] = []
    let dataService = AdvancedCombineDataService()
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        //dataService.$basicPublisher
        //dataService.currentValuePublisher
        dataService.passThroughPublisher
            .map({ String($0) })
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    debugPrint("ERROR: \(error.localizedDescription)")
                    break
                }
            } receiveValue: { [weak self] returnedValue in
                //self?.data = returnedValue
                self?.data.append(returnedValue)
            }
            .store(in: &cancellables)
    }
}

struct AdvancedCombineBootcamp: View {
    
    @StateObject private var vm = AdvancedCombineBootcampViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.data, id: \.self) {
                    Text($0)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
            }
        }
    }
}

struct AdvancedCombineBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedCombineBootcamp()
    }
}
