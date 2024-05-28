//
//  SwiftUITutorialsView.swift
//  Laboratory
//
//  Created by SeoJunYoung on 5/28/24.
//

import SwiftUI

struct SwiftUITutorialsView: View {
    var body: some View {

        VStack {
            MapView()
                .frame(height: 300)
            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)
            VStack(alignment: .leading) {
                Text("서준영")
                    .font(.title)
                    .foregroundColor(Color.green)
                HStack {
                    Text("iOS Developer")
                        .font(.subheadline)
                    Spacer()
                    Text("Busan")
                        .font(.subheadline)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                Divider()
                
                Text("안녕하세요 iOS개발자 서준영입니다.")
                    .font(.title2)
                Text("Swift UI 학습중~!")
            }
            .padding()
            Spacer()
        }
            
            
    }
}

#Preview {
    SwiftUITutorialsView()
}
