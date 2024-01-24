//
//  UnsplashPhoto.swift
//  apiapp
//
//  Created by Lucie GAROFALO on 1/23/24.
//

import Foundation

struct UnsplashPhoto: Codable {
    let id, slug: String
    let urls: Urls
    let user: User
}

struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}

struct User: Codable {
    let name: String
}