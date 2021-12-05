//
//  PreferenceKeyBootcamp.swift
//  SwiftUI_Evolve_3
//
//  Created by Sivaram Yadav on 12/5/21.
//

import SwiftUI

struct PreferenceKeyBootcamp: View {
    
    @State private var text: String = "Hello, world!!!!!!!"
    
    var body: some View {
        NavigationView {
            VStack {
                //Text(text)
                SecondaryScreen(text: text)
                    .navigationTitle("Navigation Title")
                    //.customTitle("NEW VALUE   !!!!!!!")
                    //.preference(key: CustomTitlePreferenceKey.self, value: "NEW VALUE")
            }
            //.navigationTitle("Navigation Title")
        }
        .onPreferenceChange(CustomTitlePreferenceKey.self, perform: { value in
            self.text = value
        })
    }
}

extension View {
    func customTitle(_ text: String) -> some View {
        preference(key: CustomTitlePreferenceKey.self, value: text)
    }
}


struct PreferenceBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceKeyBootcamp()
    }
}

struct SecondaryScreen: View {
    
    var text: String
    
    @State private var text1: String = ""
    
    var body: some View {
        Text(text)
            .customTitle(text1)
            .onAppear {
                downloadDataFromDatabase()
            }
    }
    
    func downloadDataFromDatabase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.text1 = "NEW TITLE FROM DATABASE!"
        }
    }
}


struct CustomTitlePreferenceKey: PreferenceKey {

    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}
