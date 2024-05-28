//
//  CircleImage.swift
//  Laboratory
//
//  Created by SeoJunYoung on 5/28/24.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        
        Image("image")
            .resizable()
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .overlay { Circle().stroke(.white, lineWidth: 4) }
            .shadow(radius: 7)
            .aspectRatio(contentMode: .fit)
            .frame(width: 300, height: 300)
    }
}

#Preview {
    CircleImage()
}
