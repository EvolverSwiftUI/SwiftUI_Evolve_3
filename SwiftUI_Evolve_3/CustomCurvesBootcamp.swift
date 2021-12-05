//
//  CustomCurvesBootcamp.swift
//  SwiftUI_Evolve_3
//
//  Created by Sivaram Yadav on 12/4/21.
//

import SwiftUI

struct CustomCurvesBootcamp: View {
    var body: some View {
//        Rectangle()
//        ArcSample()
//        ShapeWithArc()
//        QuadSample()
        WaterShape()
            .fill(LinearGradient(
                    gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), Color(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1))]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
            )
            //.stroke(lineWidth: 5)
            //.frame(width: 200, height: 200)
            //.rotationEffect(Angle(degrees: 90))
            .ignoresSafeArea()
    }
}

struct CustomCurvesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CustomCurvesBootcamp()
    }
}

struct ArcSample: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 40),
                clockwise: true)
        }
    }
    
}

struct ShapeWithArc: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            
            // top left
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            
            // top right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            
            // mid right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            
            // mid bottom
            // path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY - 65),
                radius: rect.height / 2,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 180),
                clockwise: false)
            
            // mid left
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            
            //
        }
    }
    
}


struct QuadSample: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            //path.move(to: CGPoint(x: 0, y: 0))
            path.move(to: .zero)
//            path.addQuadCurve(
//                to: CGPoint(x: rect.maxX, y: rect.maxY),
//                control: CGPoint(x: rect.minX, y: rect.maxY)
//            )
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.midY),
                control: CGPoint(x: rect.maxX - 50, y: rect.minY - 100)
            )

        }
    }
    
}


struct WaterShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.midY),
                //control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.25)
                control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.40)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.midY),
                //control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.75)
                control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.60)
            )
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        }
    }
    
}
