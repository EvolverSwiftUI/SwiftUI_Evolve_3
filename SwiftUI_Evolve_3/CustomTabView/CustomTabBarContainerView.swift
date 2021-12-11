//
//  CustomTabBarContainerView.swift
//  SwiftUI_Evolve_3
//
//  Created by Sivaram Yadav on 12/6/21.
//

import SwiftUI

// Apple Documentation for reference:
/*
struct TabView2<SelectionValue, Content> : View where SelectionValue : Hashable, Content : View {
    
    var body: some View {
        Text("Hi")
    }
}

struct TabView3<SelectionValue: Hashable, Content: View>: View {
    var body: some View {
        Text("Hello")
    }
}
*/

struct CustomTabBarContainerView<Content: View>: View {
    
    @State private var tabs: [TabBarItem] = []
//        [
//            .init(iconName: "house", title: "Home", color: .red),
//            .init(iconName: "heart", title: "Favorites", color: .green),
//            .init(iconName: "person", title: "Profile", color: .blue)
//        ]
    @Binding var selection: TabBarItem
    let content: Content
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content    = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                content
            }
            CustomTabBarView(tabs: tabs, selection: $selection)
        }
    }
}

struct CustomTabBarContainerView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItem] = [
        .init(iconName: "house", title: "Home", color: .red),
        .init(iconName: "heart", title: "Favorites", color: .green),
        .init(iconName: "person", title: "Profile", color: .blue)
    ]

    static var previews: some View {
        CustomTabBarContainerView(selection: .constant(tabs.first!)) {
            Color.red
        }
    }
}
