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
        //let items = Array(0..<11)
        //let items = Array(1..<11)
        let items = [1,2,3,4,4,5,4,6,8,9,10]
        ///*
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
                //self.basicPublisher = items[x]
                //self.currentValuePublisher.send(items[x])
                //self.passThroughPublisher.send(items[x])
                self.passThroughPublisher.send(items[x])
                
                if x == items.indices.last {
                    self.passThroughPublisher.send(completion: .finished)
                }
            }
        }
        //*/
        
        // Debounce Example:
        /*
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            self.passThroughPublisher.send(1)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.passThroughPublisher.send(2)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.passThroughPublisher.send(3)
        }
        */
    }
}

class AdvancedCombineBootcampViewModel: ObservableObject {
    
    @Published var data: [String] = []
    @Published var error: String = ""

    let dataService = AdvancedCombineDataService()
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        //dataService.$basicPublisher
        //dataService.currentValuePublisher
        dataService.passThroughPublisher
            
            // Sequence Operations:
        /*
            //.first()
            //.first(where: { int in
            //        return int > 4
            //})
            //.first(where: { $0 > 4 })
            //.tryFirst(where: { int in
            //    if int == 3 {
            //        throw URLError(.badServerResponse)
            //    }
            //    //return int > 4
            //    return int > 1
            //})
            //.last()
            //.last(where: { $0 > 4 })
            //.last(where: { $0 < 4 })
            //.tryLast(where: { int in
            //    if int == 3 {
            //        throw URLError(.badServerResponse)
            //    }
            //    if int == 13 {
            //        throw URLError(.badServerResponse)
            //    }
            //    return int > 1
            //})
            //.dropFirst()
            //.dropFirst(3)
            //.drop(while: { $0 < 5 })
            //.tryDrop(while: { int in
            //    //if int == 5 {
            //    if int == 15 {
            //        throw URLError(.badServerResponse)
            //    }
            //    return int < 6
            //})
            //.prefix(4)
            //.prefix(while: { $0 > 5 })
            //.prefix(while: { $0 < 5 })
            //.tryPrefix(while: {})
            //.output(at: 1)
            //.output(in: 2..<4)
        */
            
            // Mathematic Operations:
        /*
            //.max()
            //.max(by: { int1, int2 in
            //    return int1 < int2
            //})
            //.tryMax(by: { })
            //.min()
            //.min(by: { int1, int2 in
            //    return int1 > int2
            //})
            //.tryMin(by: { })
        */

            // Filtering & Reducing Operations:
        /*
            //.map({ String($0) })
            //.tryMap({ int in
            //    if int == 5 {
            //        throw URLError(.badServerResponse)
            //    }
            //    return String(int)
            //})
            //.compactMap({ int in
            //    if int == 5 {
            //        return nil
            //    }
            //    return String(int)
            //    return "\(int)"
            //})
            //.tryCompactMap({ int in
            //    if int == 5 {
            //        throw URLError(.badServerResponse)
            //    }
            //    return String(int)
            //})
            //.filter({ ($0>4) && ($0<7) })
            //.tryFilter({ })
            //.removeDuplicates() // only back to back duplicates are removed
            //.removeDuplicates(by: { int1, int2 in
            //    return int1 == int2
            //})
            //.tryRemoveDuplicates(by: <#T##(Int, Int) throws -> Bool#>)
            //.replaceNil(with: 5)
            //.replaceEmpty(with: 6)
            //.replaceError(with: "DEFAULT VALUE")
            //.scan(0, { (existingValue, newValue) in
            //    return existingValue + newValue
            //})
            //.scan(0, { $0 + $1 })
            //.scan(0, +)
            //.tryScan(, {})
            //.reduce(0, { (existingValue, newValue) in
            //    return existingValue + newValue
            //})
            //.reduce(0, { $0 + $1 })
            //.reduce(0, +)
            //.map({ String($0) })
            //.collect()
            //.collect(3)
            //.allSatisfy({ $0 == 5 }) // useful when we have child subscribers
            //.allSatisfy({ $0 < 55 })
            //.tryAllSatisfy({})
        */
            
            // Timing Operations:
        /*
            //.debounce(for: 0.75, scheduler: DispatchQueue.main)
            //.delay(for: 2, scheduler: DispatchQueue.main)
            //.measureInterval(using: DispatchQueue.main)
            //.map({ stride in
            //    return "\(stride.timeInterval)"
            //})
            //.throttle(for: 10, scheduler: DispatchQueue.main, latest: true)
            //.throttle(for: 10, scheduler: DispatchQueue.main, latest: false)
            //.retry(3)
            //.timeout(3, scheduler: DispatchQueue.main)
            //.timeout(0.75, scheduler: DispatchQueue.main)
        */
            
            
            
            
            
            
            .map({ String($0) })
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "ERROR: \(error.localizedDescription)"
                    //debugPrint("ERROR: \(error.localizedDescription)")
                    break
                }
            } receiveValue: { [weak self] returnedValue in
                //self?.data.append(contentsOf: returnedValue)
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
                
                if !vm.error.isEmpty {
                    Text(vm.error)
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
