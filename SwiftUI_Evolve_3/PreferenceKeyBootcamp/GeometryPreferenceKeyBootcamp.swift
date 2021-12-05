//
//  GeometryPreferenceKeyBootcamp.swift
//  SwiftUI_Evolve_3
//
//  Created by Sivaram Yadav on 12/5/21.
//

import SwiftUI

struct GeometryPreferenceKeyBootcamp: View {
    
    @State private var rectSize: CGSize = .zero
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .frame(width: rectSize.width, height: rectSize.height)
                .background(Color.blue)
                
            Spacer()
            HStack {
                Rectangle()
                GeometryReader { geo in
                    Rectangle()
                        .updateRectangleGeoSize(geo.size)
                        .overlay(
                            Text("\(geo.size.width)")
                                .foregroundColor(.white)
                        )
                }
                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(RectangleGeometryPreferenceKey.self, perform: { value in
            self.rectSize = value
        })
    }
}

struct GeometryPreferenceKeyBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryPreferenceKeyBootcamp()
    }
}

extension View {
    func updateRectangleGeoSize(_ size: CGSize) -> some View {
        preference(key: RectangleGeometryPreferenceKey.self, value: size)
    }
}

struct RectangleGeometryPreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}


// Remember below things in order
// 1. CGFloat   - just float value
// 2. CGPoint   - point represents the position in coordinate system
// 3. CGSize    - size represents the width and height in coordinate system
// 4. CGRect    - the frame or bounds in its super view and own view coordinate system


/// Preference Key understanding by Me
// the preference key concept nothingbut user defaults only.
// meaning subview will store some of its property's value against a specific key.
// and finally the superview will observe that value.
// if that key holding value will changes then it will observe and then it will read.
// and super view will apply that value to any of its properties.
