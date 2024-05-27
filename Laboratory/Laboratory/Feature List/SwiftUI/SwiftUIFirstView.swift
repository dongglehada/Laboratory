//
//  SwiftUIFirstView.swift
//  Laboratory
//
//  Created by SeoJunYoung on 5/27/24.
//

import SwiftUI

struct SwiftUIFirstView: View {
    
    struct SwiftUIViewData<Content: View>: Identifiable {
        var id = UUID()
        var name: String
        var view: () -> Content
        
        init(name: String, view: @escaping () -> Content) {
            self.name = name
            self.view = view
        }
    }
    
    var views: [SwiftUIViewData<AnyView>] = [
        SwiftUIViewData(name: "View 1") {
            AnyView(Text("View 1").font(.title))
        },
        SwiftUIViewData(name: "View 2") {
            AnyView(Text("View 2").font(.title))
        }
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(views) { data in
                    NavigationLink(destination: data.view()) {
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
