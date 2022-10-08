//
//  PlaylistModel.swift
//  Swift-1YoutubeClone
//
//  Created by Gtoro on 07-10-22.
//

import Foundation

// Decodable se encarga de convertir el tipo json a un objecto "conocido"

struct PlaylistModel: Decodable {
    let kind: String
    let etag: String
    let pageInfo: PageInfo
    let items: [Items]
}

struct PageInfo: Decodable {
    let totalResults: Int
    let resultsPerPage: Int
}

struct Items: Decodable {
    let kind: String
    let etag: String
    let id: String
    let snippet: Snippet
    let contentDetails: ContentDetails
    
    struct Snippet: Decodable {
        let publishedAt: String
        let channelId: String
        let title: String
        let description: String
        let thumbnails: Thumbnails
        let channelTitle: String
        let localized: Localized
        
        struct Thumbnails: Decodable {
            let medium: Medium
            
            struct Medium: Decodable {
                let url: String
                let width: Int
                let height: Int
            }
        }
        
        struct Localized: Decodable {
            let title: String
            let description: String
        }
    }
    
    struct ContentDetails: Decodable {
        let itemCount: Int
    }
}
