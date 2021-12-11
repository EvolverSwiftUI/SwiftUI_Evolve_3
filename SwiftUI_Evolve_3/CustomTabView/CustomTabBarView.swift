//
//  CustomTabBarView.swift
//  SwiftUI_Evolve_3
//
//  Created by Sivaram Yadav on 12/6/21.
//

import SwiftUI

struct CustomTabBarView: View {
    
    let tabs: [TabBarItem]
//    @State private var selection = TabBarItem(iconName: "house", title: "Home", color: .red)
    @Binding var selection: TabBarItem

    var body: some View {
        HStack(spacing: 10) {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(
            Color.white.ignoresSafeArea(edges: .bottom)
        )
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItem] = [
        .init(iconName: "house", title: "Home", color: .red),
        .init(iconName: "heart", title: "Favorites", color: .green),
        .init(iconName: "person", title: "Profile", color: .blue)
    ]
    
    static var previews: some View {
        VStack {
            Spacer()
            CustomTabBarView(tabs: tabs, selection: .constant(tabs.first!))
        }
    }
}

extension CustomTabBarView {
    
    func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(selection == tab ? tab.color : Color.gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(selection == tab ? tab.color.opacity(0.3) : Color.clear)
        .cornerRadius(10)
    }
    
    private func switchToTab(tab: TabBarItem) {
        withAnimation(.easeInOut) {
            selection = tab
        }
    }
}

struct TabBarItem: Hashable {
    let iconName: String
    let title: String
    let color: Color
}
