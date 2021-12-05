//
//  ScrollViewOffsetPreferenceKeyBootcamp.swift
//  SwiftUI_Evolve_3
//
//  Created by Sivaram Yadav on 12/5/21.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    func onScrollViewOffsetChanged(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        self
            .background(
                GeometryReader { geo in
                    Text("")
                        .preference(key: ScrollViewOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
                }
            )
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self, perform: { value in
                action(value)
//                self.scrollViewOffset = value
            })
    }
}

struct ScrollViewOffsetPreferenceKeyBootcamp: View {
    
    let title: String = "New Title Here!!!!!!"
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        
        ScrollView {
            VStack {
                titleLayer
                    .opacity(Double(scrollViewOffset) / 63)
                    .onScrollViewOffsetChanged { (value) in
                        self.scrollViewOffset = value
                    }
//                    .background(
//                        GeometryReader { geo in
//                            Text("")
//                                .preference(key: ScrollViewOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
//                        }
//                    )
                contentLayer
            }
            .padding()
        }
        .overlay(Text("\(scrollViewOffset)"))
//        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self, perform: { value in
//            self.scrollViewOffset = value
//        })
        .overlay(
            navBarLayer
                .opacity(scrollViewOffset < 40 ? 1.0 : 0.0)
            , alignment: .top)

//        NavigationView {
//            .navigationTitle("Nav Title")
//        }
    }
}

struct ScrollviewOffsetPreferenceKeyBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewOffsetPreferenceKeyBootcamp()
    }
}

extension ScrollViewOffsetPreferenceKeyBootcamp {
    
    private var titleLayer: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var contentLayer: some View {
        ForEach(0..<30) { _ in
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red.opacity(0.3))
                .frame(width: 300, height: 200)
        }
    }
    
    private var navBarLayer: some View {
        Text(title)
            .font(.headline)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
    }
}
