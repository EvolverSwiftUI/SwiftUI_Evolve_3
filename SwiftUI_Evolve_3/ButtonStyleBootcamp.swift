//
//  ButtonStyleBootcamp.swift
//  SwiftUI_Evolve_3
//
//  Created by Sivaram Yadav on 12/4/21.
//

import SwiftUI

struct TappableButtonStyle: ButtonStyle {
    
    let scaledAmount: CGFloat
    
    //init(scaledAmount: CGFloat = 0.9) {
    //    self.scaledAmount = scaledAmount
    //}
    init(scaledAmount: CGFloat) {
        self.scaledAmount = scaledAmount
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
            //.brightness(configuration.isPressed ? 0.05 : 0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
    }
}

extension View {
    //func withTapableStyle() -> some View {
    //    //self.buttonStyle(TappableButtonStyle())
    //    buttonStyle(TappableButtonStyle())
    //}
    func withTapableStyle(scaledAmount: CGFloat = 0.9) -> some View {
        //self.buttonStyle(TappableButtonStyle(scaledAmount: scaledAmount))
        buttonStyle(TappableButtonStyle(scaledAmount: scaledAmount))
    }
}

struct ButtonStyleBootcamp: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            Text("Tap Here")
                .font(.headline)
                //.foregroundColor(.white)
                //.frame(height: 55)
                //.frame(maxWidth: .infinity)
                //.background(Color.blue)
                //.cornerRadius(10)
                //.shadow(
                //    color: Color.blue.opacity(0.3),
                //    radius: 10,
                //    x: 0.0, y: 10.0
                //)
                .withDefaultButtonFormatting()
        })
        //.buttonStyle(PlainButtonStyle())
        //.buttonStyle(DefaultButtonStyle())
        //.buttonStyle(TappableButtonStyle(scaledAmount: 0.5))
        //.buttonStyle(TappableButtonStyle())
        //.withTapableStyle()
        //.withTapableStyle(scaledAmount: 0.5)
        //.withTapableStyle(scaledAmount: 1.2)
        .withTapableStyle()
        .padding(40)
    }
}

struct ButtonStyleBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyleBootcamp()
    }
}
