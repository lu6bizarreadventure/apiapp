//
//  TopicView.swift
//  apiapp
//
//  Created by Lucie GAROFALO on 1/24/24.
//

import SwiftUI

struct TopicView: View {
    @State var topic: UnsplashTopic
    @StateObject var feedState = FeedState()
    
    var column = [
        GridItem(.adaptive(minimum: 150)),
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            NavigationStack {
                Button(action: {
                    Task {
                        await feedState.fetchTopicFeed(orderBy: "popular", slug: topic.slug)
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
                    .navigationTitle(topic.slug)
            }
            
        }
    }
    

}
