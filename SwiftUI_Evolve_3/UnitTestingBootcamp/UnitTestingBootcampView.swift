//
//  UnitTestingBootcampView.swift
//  SwiftUI_Evolve_3
//
//  Created by Sivaram Yadav on 12/13/21.
//

/*
 1. Unit Tests
 - test the business logic in app
 
 2. UI Tests
 - tests the UI of the app
 */

// Required concepts
// 1. Protcols
// 2. Dependency Injection

import SwiftUI

struct UnitTestingBootcampView: View {
    
    @StateObject private var vm: UnitTestingBootcampViewModel
    
    init(isPremium: Bool) {
        _vm = StateObject(wrappedValue: UnitTestingBootcampViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text(vm.isPremium.description)
    }
}

struct UnitTestingBootcampView_Previews: PreviewProvider {
    static var previews: some View {
        UnitTestingBootcampView(isPremium: true)
    }
}
