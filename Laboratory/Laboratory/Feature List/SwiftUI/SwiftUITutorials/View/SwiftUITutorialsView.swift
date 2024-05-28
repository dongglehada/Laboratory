//
//  SwiftUITutorialsView.swift
//  Laboratory
//
//  Created by SeoJunYoung on 5/28/24.
//

import SwiftUI
import UIKit

struct SwiftUITutorialsView: View {
    
    var body: some View {
        LandmarkList()
    }
}

#Preview {
    SwiftUITutorialsView()
        .environment(ModelData())
}
