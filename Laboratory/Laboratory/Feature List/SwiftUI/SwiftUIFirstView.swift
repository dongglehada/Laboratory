//
//  SwiftUIFirstView.swift
//  Laboratory
//
//  Created by SeoJunYoung on 5/27/24.
//

import SwiftUI

struct SwiftUIFirstView: View {
    
    struct SwiftUIViewData: Identifiable {
        var id = UUID()
        var name: String
        var view: AnyView
        
        init<Content: View>(name: String, view: Content) {
            self.name = name
            self.view = AnyView(view)
        }
    }
    
    var views: [SwiftUIViewData] = [
        .init(name: "SwiftUITutorialsView", view: SwiftUITutorialsView())
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(views) { data in
                    NavigationLink(destination: data.view) {
                        Text(data.name)
                    }
                }
            }
            .navigationTitle("List")
        }
    }
}

#Preview {
    SwiftUIFirstView()
}
