//
//  MatchedGeometryEffect.swift
//  SwiftUI_Evolve_3
//
//  Created by Sivaram Yadav on 12/4/21.
//

import SwiftUI

struct MatchedGeometryEffect: View {
    
    @State private var isClicked: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        VStack {
            
            // Rectangle:
            /*
            if !isClicked {
                RoundedRectangle(cornerRadius: 25.0)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 100, height: 100)
                    //.offset(y: isClicked ? UIScreen.main.bounds.height * 0.75 : 0)
                    //.matchedGeometryEffect(id: "rectangle", in: namespace)
            }

            Spacer()
            
            if isClicked {
                RoundedRectangle(cornerRadius: 25.0)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 300, height: 200)
                    //.matchedGeometryEffect(id: "rectangle", in: namespace)
            }
            */
            
            
            // Circle:
            ///*
            if !isClicked {
                Circle()
                    .matchedGeometryEffect(id: "circle", in: namespace)
                    .frame(width: 100, height: 100)
                    //.offset(y: isClicked ? UIScreen.main.bounds.height * 0.75 : 0)
                    //.matchedGeometryEffect(id: "rectangle", in: namespace)
            }

            Spacer()
            
            if isClicked {
                Circle()
                    .matchedGeometryEffect(id: "circle", in: namespace)
                    .frame(width: 300, height: 200)
                    //.matchedGeometryEffect(id: "rectangle", in: namespace)
            }
            //*/
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
        .onTapGesture {
            withAnimation(.easeInOut) {
                isClicked.toggle()
            }
        }
    }
}

struct MatchedGeometryEffect_Previews: PreviewProvider {
    static var previews: some View {
        //MatchedGeometryEffect()
        MatchedGeometryEffectExample()
    }
}

struct MatchedGeometryEffectExample: View {
    
    let categories: [String] = ["Home", "Popular", "Saved"]
    @State private var selected: String = ""
    @Namespace private var namespace2

    
    var body: some View {
        HStack {
            ForEach(categories, id: \.self) { category in
                ZStack {
                    if selected == category {
                        RoundedRectangle(cornerRadius: 10)
                            //.fill(Color.red.opacity(0.5))
                            .fill(Color.red)
                            .matchedGeometryEffect(id: "category_background", in: namespace2)
                            .frame(width: 35, height: 2)
                            .offset(y: 20)
                    }
                    Text(category)
                        .foregroundColor(selected == category ? .red : .black)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selected = category
                    }
                }
            }
        }
        .padding()
    }
}
