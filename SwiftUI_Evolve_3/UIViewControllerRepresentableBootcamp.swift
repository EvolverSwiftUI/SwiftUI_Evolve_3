//
//  UIViewControllerRepresentableBootcamp.swift
//  SwiftUI_Evolve_3
//
//  Created by Sivaram Yadav on 12/12/21.
//

// Advanced Learning #14
// Use UIViewControllerRepresentable to convert UIKit controllers to SwiftUI

import SwiftUI

struct UIViewControllerRepresentableBootcamp: View {
    
    @State private var showScreen: Bool = false
    @State var image: UIImage?
    
    var body: some View {
        VStack {
            Text("UIViewControllerRepresentable Usage")
                .padding()
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
            Button(action: {
                showScreen.toggle()
            }, label: {
                Text("Tap Here")
            })
        }
        .sheet(isPresented: $showScreen, content: {
            UIImagePickerViewControllerRepresentable(image: $image, showScreen: $showScreen)
        })
    }
    
}

struct UIViewControllerRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerRepresentableBootcamp()
    }
}

struct UIImagePickerViewControllerRepresentable: UIViewControllerRepresentable {
   
    @Binding var image: UIImage?
    @Binding var showScreen: Bool

    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(image: $image, showScreen: $showScreen)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @Binding var image: UIImage?
        @Binding var showScreen: Bool

        init(image: Binding<UIImage?>, showScreen: Binding<Bool>) {
            self._image = image
            self._showScreen = showScreen
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            guard let newImage = info[.originalImage] as? UIImage else {
                return
            }
            
            image = newImage
            showScreen = false
        }
    }
}


// Basic UIViewController Representation
struct BasicUIViewControllerRepresentable: UIViewControllerRepresentable {
    
    let labelText: String
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = FirstViewController()
        vc.labelText = labelText
        return vc
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    class FirstViewController: UIViewController {
        
        var labelText: String = "Starting Value"
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .blue
            
            let label = UILabel()
            label.text = labelText
            label.textColor = UIColor.white
            view.addSubview(label)
            label.frame = view.bounds
        }
    }
}
