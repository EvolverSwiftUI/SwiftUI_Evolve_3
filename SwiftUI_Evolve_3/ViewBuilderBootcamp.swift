//
//  ViewBuilderBootcamp.swift
//  SwiftUI_Evolve_3
//
//  Created by Sivaram Yadav on 12/5/21.
//

import SwiftUI

struct HeaderViewRegular: View {
    
    let title: String
    let description: String?
    let iconName: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            if let description = description {
                Text(description)
                    .font(.callout)
            }
            if let iconName = iconName {
                Image(systemName: iconName)
            }
            RoundedRectangle(cornerRadius: 5.0)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

// Now converting the above View to generic View like below way
//struct HeaderViewGeneric<CustomType: View>: View {
struct HeaderViewGeneric<Content: View>: View {

    let title: String
//    let description: String?
//    let iconName: String?
    
    //let content: CustomType
    let content: Content

//    init(title: String, content: Content) {
//        self.title = title
//        self.content = content
//    }
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
//            if let description = description {
//                Text(description)
//                    .font(.callout)
//            }
//            if let iconName = iconName {
//                Image(systemName: iconName)
//            }
            
            content
            
            RoundedRectangle(cornerRadius: 5.0)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct CustomHStack<Contet: View>: View {
    
    let content: Contet
    
    init(@ViewBuilder content: () -> Contet) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content
        }
    }
}


struct ViewBuilderBootcamp: View {
    var body: some View {
        VStack {
            HeaderViewRegular(title: "Title", description: "Description", iconName: "heart.fill")
            HeaderViewRegular(title: "Title2", description: nil, iconName: "bolt.fill")
            //HeaderViewGeneric(title: "Generic Title")
//            HeaderViewGeneric(title: "Generic Title", content: Text("Hello"))
//            HeaderViewGeneric(title: "Generic Title 2", content: Image(systemName: "heart.fill"))
//            HeaderViewGeneric(title: "Generic Title 3", content:
//                                HStack {
//                                    Text("Helloooooo")
//                                    Image(systemName: "heart.fill")
//                                }
//            )
//            HeaderViewGeneric(title: "Generic Title 4", content:
//                                VStack {
//                                    Text("Helloooooo")
//                                    Image(systemName: "bolt.fill")
//                                }
//            )
            
            HeaderViewGeneric(title: "Generic Title 5") {
                Text("Hi")
            }
            HeaderViewGeneric(title: "Generic Title 6") {
                Image(systemName: "heart.fill")
            }
            HeaderViewGeneric(title: "Generic Title 7") {
                VStack {
                    Text("hey")
                    Text("hi")
                    Text("hello")
                    Image(systemName: "heart.fill")
                }
            }
            HeaderViewGeneric(title: "Generic Title 8") {
                HStack {
                    Text("hey")
                    Image(systemName: "heart.fill")
                    Text("hello")
                }
            }

            CustomHStack {
                Text("Hi")
                Text("Hi")
            }
            HStack {
                Text("Hi")
                Text("Hi")
            }

            Spacer()
        }
    }
}

struct ViewBuilderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
//        ViewBuilderBootcamp()
        LocalViewBuilder(type: .two)
    }
}

struct LocalViewBuilder: View {
    
    enum ViewType {
        case one, two, three
    }
    let type: ViewType
    
    var body: some View {
        VStack  {
            headerSection
        }
    }
    
/// To remove above or below HStack
/// we use "@ViewBuilder" concept
    @ViewBuilder private var headerSection: some View {
//    HStack {
//        if type == .one {
//            viewOne
//        }  else if type == .two {
//            viewTwo
//        } else if type == .three {
//            viewThree
//        }
//    }
        
//        MAke above if else to switch
//        To easy understand
        switch type {
        case .one:
            viewOne
        case .two:
            viewTwo
        case .three:
            viewThree
        }
    }

    private var viewOne: some View {
        Text("ONE!")
    }
    private var viewTwo: some View {
        VStack {
            Text("TWOO")
            Image(systemName: "heart.fill")
        }
    }
    private var viewThree: some View {
        HStack {
            Text("THREE!!!!!!")
            Image(systemName: "bolt.fill")
        }
    }
}
