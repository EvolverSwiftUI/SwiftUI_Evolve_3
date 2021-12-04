//
//  AnyTransitionBootcamp.swift
//  SwiftUI_Evolve_3
//
//  Created by Sivaram Yadav on 12/4/21.
//

import SwiftUI

struct RotateViewModifier:ViewModifier {
    
    let rotation: Double
    
    func body(content: Content) -> some View {
        content
            //.rotationEffect(Angle(degrees: 45))
            .rotationEffect(
                Angle(degrees: rotation)
            )
            .offset(
                x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                y: rotation != 0 ? UIScreen.main.bounds.height : 0
            )
    }
}

extension AnyTransition {
    
    static var rotating: AnyTransition {
        
        //return AnyTransition.modifier(
        //    active: RotateViewModifier(rotation: 180),
        //    identity: RotateViewModifier(rotation: 0)
        //)
        
        // same as above, we get rid of extra return and type
        // now its lokking nice and clean
        modifier(
            active: RotateViewModifier(rotation: 180),
            identity: RotateViewModifier(rotation: 0)
        )

    }
    
    static func rotating(rotation: Double) -> AnyTransition {
        
        //return AnyTransition.modifier(
        //    active: RotateViewModifier(rotation: rotation),
        //    identity: RotateViewModifier(rotation: 0)
        //)
        
        // same as above, we get rid of extra return and type
        // now its lokking nice and clean
        modifier(
            active: RotateViewModifier(rotation: rotation),
            identity: RotateViewModifier(rotation: 0)
        )

    }
    
    static var rotateOn: AnyTransition {
        
//        return AnyTransition.asymmetric(
//            insertion: .rotating,
//            removal: .move(edge: .leading)
//        )
        
        asymmetric(
            insertion: .rotating,
            removal: .move(edge: .leading)
        )
    }
}

struct AnyTransitionBootcamp: View {
    
    @State private var showRectangle: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            if showRectangle {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: 250, height: 350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    //.transition(.move(edge: .leading))
                    //.transition(AnyTransition.scale.animation(.easeInOut))
                    //.modifier(RotateViewModifier())
                    //.transition(AnyTransition.rotating.animation(.easeInOut))
                    //.transition(.rotating(rotation: 1080))
                    .transition(.rotateOn)
            }
            Spacer()
            Text("Tap Here!")
                .withDefaultButtonFormatting()
                .padding(.horizontal, 40)
                .onTapGesture {
                    // for testing purpose put animation duration
                    // as max as 5 seconds
                    // withAnimation(.easeInOut(duration: 5)) {
                    //    showRectangle.toggle()
                    // }
                    withAnimation(.easeInOut) {
                        showRectangle.toggle()
                    }

                }
        }
    }
}

struct AnyTransitionBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AnyTransitionBootcamp()
    }
}
