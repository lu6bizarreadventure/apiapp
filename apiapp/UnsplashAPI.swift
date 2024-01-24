//
//  UnsplashAPI.swift
//  apiapp
//
//  Created by Lucie GAROFALO on 1/24/24.
//

import Foundation

struct UnsplashAPI {
    
    static func unsplashApiBaseUrl() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: ConfigurationManager.instance.plistDictionnary.clientId)
        ]
        
        return components
    }
    
    static func feedUrl(orderBy: String, perPage: Int, path: String) -> URL? {
        
        var finalUrl = unsplashApiBaseUrl()
        
        let queryItems = [
            URLQueryItem(name: "order_by", value: orderBy),
            URLQueryItem(name: "per_page", value: String(perPage))
        ]
        finalUrl.queryItems?.append(contentsOf: queryItems)
        finalUrl.path = path
        
        return finalUrl.url
    }
}

