//
//  UIViewRepresentableBootcamp.swift
//  SwiftUI_Evolve_3
//
//  Created by Sivaram Yadav on 12/11/21.
//


// Advanced Learning #13
// Use UIViewRepresentable to convert UIKit views to SwiftUI


import SwiftUI

struct UIViewRepresentableBootcamp: View {
    
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            Text(text)
            HStack {
                Text("SwiftUI:")
                TextField("Type here...", text: $text)
                    .frame(height: 55)
                    .background(Color.gray)
            }
            HStack {
                Text("UIKit:    ")
                UITextFieldRepresentable(text: $text)
                    .updatePlaceholder("New placeholder!!!...")
                    .frame(height: 55)
                    .background(Color.gray)
            }
       }
    }
}

struct UIViewRepresentableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        UIViewRepresentableBootcamp()
    }
}

struct UITextFieldRepresentable: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    let placeholderColor: UIColor
    
    init(text: Binding<String>, placeholder: String = "Default Placeholder...", placeholderColor: UIColor = UIColor.red) {
        self._text = text
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textfield =  getTextfield()
        textfield.delegate = context.coordinator
        return textfield
    }
    
    // from SwiftUI to UIKit
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }

    private func getTextfield() -> UITextField {
        let textfield = UITextField(frame: .zero)
        let placeholder = NSAttributedString(
            string: self.placeholder,
            attributes: [
                .foregroundColor: self.placeholderColor
            ])
        textfield.attributedPlaceholder = placeholder
        return textfield
    }
    
    func updatePlaceholder(_ text: String) -> UITextFieldRepresentable {
        var textFieldRepresentable = self
        textFieldRepresentable.placeholder = text
        return textFieldRepresentable
    }
    
    // from UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}
