//
//  ProtocolsBootcamp.swift
//  SwiftUI_Evolve_3
//
//  Created by Sivaram Yadav on 12/12/21.
//

// Advanced Learning #15
// How to use Protocols in Swift

import SwiftUI

struct DefaultColorTheme: ColorThemeProtocol {
    let primary     : Color = .blue
    let secondary   : Color = .white
    let tertiary    : Color = .gray
}

struct AlternativeColorTheme: ColorThemeProtocol {
    let primary     : Color = .red
    let secondary   : Color = .white
    let tertiary    : Color = .green
}

struct AnotherColorTheme: ColorThemeProtocol {
    let primary     : Color = .purple
    let secondary   : Color = .white
    let tertiary    : Color = .orange
}

protocol ColorThemeProtocol {
    var primary     : Color { get }
    var secondary   : Color { get }
    var tertiary    : Color { get }
}

protocol ButtonTextProtocol {
    var buttonText: String { get }
}
protocol ButtonTappedProtocol {
    func buttonTapped()
}
protocol ButtonDataSourceProtocol: ButtonTextProtocol, ButtonTappedProtocol {
    
}
class DefaultDataSource: ButtonDataSourceProtocol {
    var buttonText: String = "Protocols are awesome!"
    
    func buttonTapped() {
        print("Button was tapped.")
    }
}

class AlternativeDataSource: ButtonTextProtocol {
    var buttonText: String = "Protocols are lame!"
}

struct ProtocolsBootcamp: View {
    
//    let colorTheme: DefaultColorTheme = DefaultColorTheme()
//    let colorTheme: AlternativeColorTheme = AlternativeColorTheme()
    // Here is one problem
    // each time we want to cahnge color theme
    // we need to create a new type with same constants
    // Soloution to this problem is
    // To exchange or replace of one type to other type
    // This can be achieved through protocols
    
//    let colorTheme: ColorThemeProtocol = DefaultColorTheme()
//    let colorTheme: ColorThemeProtocol = AlternativeColorTheme()
    let colorTheme: ColorThemeProtocol
//    let dataSource: ButtonTextProtocol
//    let dataSource2: ButtonTappedProtocol
    let dataSource: ButtonDataSourceProtocol

    var body: some View {
        ZStack {
            colorTheme.tertiary.ignoresSafeArea()
            Text(dataSource.buttonText)
                .font(.headline)
                .foregroundColor(colorTheme.secondary)
                .padding()
                .background(colorTheme.primary)
                .cornerRadius(10)
                .onTapGesture {
                    //dataSource.buttonTapped()
                    //\dataSource2.buttonTapped()
                }
        }
    }
}

struct ProtocolsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
//        ProtocolsBootcamp(colorTheme: DefaultColorTheme())
//        ProtocolsBootcamp(colorTheme: DefaultColorTheme(), dataSource: DefaultDataSource())
//        ProtocolsBootcamp(colorTheme: AlternativeColorTheme(), dataSource: AlternativeDataSource())
        ProtocolsBootcamp(colorTheme: DefaultColorTheme(), dataSource: DefaultDataSource())
    }
}
