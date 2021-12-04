//
//  ViewModifierBootcamp.swift
//  SwiftfulThinkingAdvancedLevel
//
//  Created by Sivaram Yadav on 12/4/21.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            //.font(.headline) // move out makes more dynamic
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            //.background(Color.blue) // made color as dynamic
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
            //.padding() // move out makes more dynamic
    }
}

extension View {
    func withDefaultButtonFormatting(backgroundColor: Color = .blue) -> some View {
        // self.modifier(DefaultButtonViewModifier())
        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
    }
}

struct ViewModifierBootcamp: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("save")
                .font(.headline)
                //.modifier(DefaultButtonViewModifier())
                .withDefaultButtonFormatting(backgroundColor: .orange)
            
            Text("Update")
                .font(.subheadline)
                //.modifier(DefaultButtonViewModifier())
                //.withDefaultButtonFormatting(backgroundColor: .red)
                .withDefaultButtonFormatting() // default color as blue


            Text("Delete")
                .font(.title)
                //.modifier(DefaultButtonViewModifier())
                .withDefaultButtonFormatting(backgroundColor: .green)

        }
        .padding()
    }
}

struct ViewModifierBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifierBootcamp()
    }
}
