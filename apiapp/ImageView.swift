//
//  ImageView.swift
//  apiapp
//
//  Created by Lucie GAROFALO on 1/24/24.
//

import SwiftUI

struct ImageView: View {
    @State var image: UnsplashPhoto
    
    var body: some View {
        NavigationView {
            VStack{
                AsyncImage(url: URL(string: image.urls.raw)) { img in
                    img.centerCropped()
                } placeholder: {
                    ProgressView()
                }.frame(height: 150).clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text(image.user.name)
            }
        }
    }
    
}
