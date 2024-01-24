//
//  ContentView.swift
//  apiapp
//
//  Created by Lucie GAROFALO on 1/23/24.
//

import SwiftUI

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}

struct ContentView: View {
    @State var imageList: [UnsplashPhoto] = []
    @StateObject var feedState = FeedState()
    
    var column = [
        GridItem(.adaptive(minimum: 150)),
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            
            // le bouton va lancer l'appel réseau
            Button(action: {
                Task {
                    await feedState.fetchHomeFeed(path: "/photos")
                }
            }, label: {
                Text("Load Data")
            })
            ScrollView {
                if let imgList = feedState.homeFeed{
                    LazyVGrid (columns: column, content: {
                    
                        ForEach(imgList) { img in
                            AsyncImage(url: URL(string: img.urls.raw)) { image in
                                image.centerCropped()
                            } placeholder: {
                                ProgressView()
                            }.frame(height: 150).clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    })
                } else {
                    LazyVGrid (columns: column, content: {
                        ForEach(0..<12) { _ in
                            RoundedRectangle(cornerRadius: 10.0).frame(height: 150).foregroundColor(.gray)
                                .opacity(0.4)
                        }
                    })
                }
            }.clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 10)
                .navigationTitle("Feed")
        }
    }
}

#Preview {
    ContentView()
}
