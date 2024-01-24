//
//  FeedState.swift
//  apiapp
//
//  Created by Lucie GAROFALO on 1/24/24.
//

import Foundation

class FeedState : ObservableObject {
    @Published var homeFeed: [UnsplashPhoto]?
    @Published var homeTopic: [UnsplashTopic]?
    var url = UnsplashAPI.unsplashApiBaseUrl()
    
    func fetchHomeFeed(orderBy: String = "popular", perPage: Int = 10, path: String = "/photos") async {
        let finalUrl = UnsplashAPI.feedUrl(orderBy: orderBy, perPage: perPage, path: path)
        
        if (finalUrl != nil) {
            do {
                // Créez une requête avec cette URL
                
                let request = URLRequest(url: UnsplashAPI.feedUrl(orderBy: orderBy, perPage: perPage, path: path)!)
                
                // Faites l'appel réseau
                let (data, _) = try await URLSession.shared.data(for: request)
                
                // Transformez les données en JSON
                let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
                
                // Mettez à jour l'état de la vue
                await MainActor.run {
                    homeFeed = deserializedData
                }
                
            } catch {
                print("Error: \(error)")
            }
        } else {
            print("Error")
            
        }
    }
    
    func fetchHomeTopic(orderBy: String = "popular", perPage: Int = 3, path: String = "/topics") async {
        let finalUrl = UnsplashAPI.feedUrl(orderBy: orderBy, perPage: perPage, path: path)
        
        if (finalUrl != nil) {
            do {
                // Créez une requête avec cette URL
                
                let request = URLRequest(url: UnsplashAPI.feedUrl(orderBy: orderBy, perPage: perPage, path: path)!)
                
                // Faites l'appel réseau
                let (data, _) = try await URLSession.shared.data(for: request)
                
                // Transformez les données en JSON
                let deserializedData = try JSONDecoder().decode([UnsplashTopic].self, from: data)
                
                // Mettez à jour l'état de la vue
                await MainActor.run {
                    homeTopic = deserializedData
                }
                
            } catch {
                print("Error: \(error)")
            }
        } else {
            print("Error")
            
        }
    }
    
    func fetchTopicFeed(orderBy: String, perPage: Int = 10, slug: String) async {
        let path = "/topics/\(slug)/photos"
        
        let finalUrl = UnsplashAPI.feedUrl(orderBy: orderBy, perPage: perPage, path: path)
        
        if (finalUrl != nil) {
            do {
                // Créez une requête avec cette URL
                
                let request = URLRequest(url: UnsplashAPI.feedUrl(orderBy: orderBy, perPage: perPage, path: path)!)
                
                // Faites l'appel réseau
                let (data, _) = try await URLSession.shared.data(for: request)
                
                // Transformez les données en JSON
                let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
                
                // Mettez à jour l'état de la vue
                await MainActor.run {
                    homeFeed = deserializedData
                }
                
            } catch {
                print("Error: \(error)")
            }
        } else {
            print("Error")
            
        }
        
    }
}
