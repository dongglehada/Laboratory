//
//  SwiftUITutorialsView.swift
//  Laboratory
//
//  Created by SeoJunYoung on 5/28/24.
//

import SwiftUI

struct SwiftUITutorialsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Turtle Rock")
                .font(.title)
            .foregroundColor(Color.green)
            HStack {
                Text("Joshua Tree National Park")
                    .font(.subheadline)
                Spacer()
                Text("California")
                    .font(.subheadline)
            }
        }
        .padding()
            
            
    }
}

#Preview {
    SwiftUITutorialsView()
}
