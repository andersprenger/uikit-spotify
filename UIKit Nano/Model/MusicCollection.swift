//
//  MusicCollection.swift
//  UIKit Nano
//
//  Created by Rafael Victor Ruwer Araujo on 16/06/21.
//

import Foundation

struct MusicCollection: Hashable, Decodable {
    enum MusicCollectionType: String, Decodable {
        case playlist
        case album
    }
    
    let id: String
    
    let title: String
    let mainPerson: String
    let referenceDate: Date
    
    var musics: [Music]
    
    let type: MusicCollectionType
    let albumDescription: String?
    let albumArtistDescription: String?
    
    var supportsEdition: Bool {
        type == .playlist
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
