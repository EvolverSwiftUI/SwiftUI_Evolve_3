//
//  GenericsBootcamp.swift
//  SwiftUI_Evolve_3
//
//  Created by Sivaram Yadav on 12/5/21.
//

import SwiftUI

struct StringModel {
    let info: String?
    func removeInfo() -> StringModel {
        return StringModel(info: nil)
    }
}

struct BoolModel {
    let info: Bool?
    func removeInfo() -> BoolModel {
        return BoolModel(info: nil)
    }
}

//struct GenericModel<CustomType> {
//    var info: CustomType?
//    func removeInfo() -> GenericModel {
//        return GenericModel(info: nil)
//    }
//}

// In real apps for generics we use T,(T stands for Type or Anytype)
// in place of CustomType
struct GenericModel<T> {
    var info: T?
    func removeInfo() -> GenericModel {
        return GenericModel(info: nil)
    }
}

class GenericsViewModel: ObservableObject {
   
    @Published var stringModel          = StringModel(info: "Hello, world!")
    @Published var boolModel            = BoolModel(info: true)

    @Published var genericStringModel   = GenericModel(info: "Hello, world!")
    @Published var genericBoolModel     = GenericModel(info: false)

    func removeData() {
        stringModel         = stringModel.removeInfo()
        boolModel           = boolModel.removeInfo()
        genericStringModel  = genericStringModel.removeInfo()
        genericBoolModel    = genericBoolModel.removeInfo()
    }
    
    // Begin:
    /*
    //@Published var dataArray: [String] = []
    @Published var dataArray: [Bool] = []

    init() {
        //self.dataArray = ["One", "Two", "Three"]
        self.dataArray = [true, false, true]
        
        //self.dataArray.append(<#T##newElement: String##String#>)
        //self.dataArray.append(<#T##newElement: Bool##Bool#>)
    }
    
    func removeDataFromDataArray() {
        dataArray.removeAll()
    }
 */
}

/// struct GenericView<CustomType>: View where CustomType: View {
// (OR) else below way both same
// Here in more real way replaced "CustomType" with "T"
/// struct GenericView<CustomType: View>: View {
// Like below way
 struct GenericView<T: View>: View {

    // Error: Protocol 'View' can only be used as a generic constraint because it has Self or associated type requirements
    //let content: View
    
    // So like below
    // Error: Cannot find type 'CustomType' in scope
    //let content: CustomType
    
    // So like below, to silence error
    // We make "CustomType" as Generic Type
    // by putting in angular brackets(<CustomType> after that declared type)
    // So now its our responsibity to pass th type while init time
    // so like this we can convert a Specific to Generic way
    
    // Here in more real way replaced "CustomType" with "T"
    // let content: CustomType
    
    // So like below way
    let content: T

    let title: String
    
    var body: some View {
        VStack {
            Text(title)
            
            // Error:
            // Static method 'buildBlock' requires that 'CustomType' conform to 'View'
            // So we confirm to View while
            // it putting on view like (<CustomType: View>)
            content
        }
    }
    
    
}

struct GenericsBootcamp: View {
    
    @StateObject var vm = GenericsViewModel()
    
    var body: some View {
        
        VStack {
            
            // Error:
            // Generic struct 'GenericView' requires that 'String' conform to 'View'
            // So that's why it won't allow String to put on View,
            // So we must put string through Text view type, bcz it confirms to View
            // GenericView(content: "Hi", title: "New View!")
            
            // So like below it will works
            GenericView(content: Text("Custom Content"), title: "New View!")
            
            Text(vm.stringModel.info ?? "no data")
            Text(vm.boolModel.info?.description ?? "no data")
            
            Text(vm.genericStringModel.info ?? "no data")
            Text(vm.genericBoolModel.info?.description ?? "no data")

        }
        .onTapGesture {
            vm.removeData()
        }

        
        // Begin:
        /*
        VStack {
            ForEach(vm.dataArray, id: \.self, content: { item in
                Text(item.description)
            })
        }
        .onTapGesture {
            vm.removeDataFromDataArray()
        }
         */
    }
}

struct GenericsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GenericsBootcamp()
    }
}
