//
//  ImageView.swift
//  Lordyal
//
//  Created by Sidney Sadel on 4/5/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageView: View {
    
    var url: String
    private let options = SDWebImageOptions.scaleDownLargeImages
    @State private var imageOpacity: Double = 0.0
    @State private var failed: Bool = false
    @State private var emptyImageOpacity: Double = 0.0
    
    var body: some View {
        ZStack {
            if let imageURL = URL(string: url), !failed {
                WebImage(url: imageURL, options: options)
                    .resizable()
                    .onSuccess { _ ,_ ,_  in
                        withAnimation(.easeInOut(duration: 0.3)) {
                            imageOpacity = 1.0
                        }
                    }
                    .onFailure { _ in
                        failed = true
                        withAnimation(.easeInOut(duration: 0.3)) {
                            emptyImageOpacity = 1.0
                        }
                    }
                    .cancelOnDisappear(true)
                    .opacity(imageOpacity)
            } else {
                Image("empty")
                    .resizable()
                    .opacity(emptyImageOpacity)
            }
            
            if imageOpacity == 0.0 && !failed {
                Color.gray
            }
        }
    }
}

//struct ImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageView()
//    }
//}
