//
//  AppTabBarView.swift
//  SwiftUI_Evolve_3
//
//  Created by Sivaram Yadav on 12/5/21.
//

import SwiftUI

// The required concepts to build a custom tab bar view:
/*
    1. Generics
    2. ViewBuilder
    3. PreferenceKey
    4. MatchedGeometryEffect
*/

// This Custom Tabbar View has 3 parts:
/*
    1. Bottom Tab Bar View
    2. Container with different Views and also Bottom Tab Bar View
    3. Each tab item view with image and title in Bottom Tab Bar View
 */

struct AppTabBarView: View {
    
    @State private var selection: String = "home"
    @State private var tabSelection: TabBarItem = .init(iconName: "house", title: "Home", color: .red)
    
    var body: some View {
        //defaultTabView
        CustomTabBarContainerView(selection: $tabSelection) {
            Color.blue
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [
        .init(iconName: "house", title: "Home", color: .red),
        .init(iconName: "heart", title: "Favorites", color: .green),
        .init(iconName: "person", title: "Profile", color: .blue)
    ]

    static var previews: some View {
        AppTabBarView()
    }
}

extension AppTabBarView {
    
    private var defaultTabView: some View {
        TabView(selection: $selection) {
            Color.red
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Color.green
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorite")
                }
            Color.orange
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}
