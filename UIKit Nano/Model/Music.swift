//
//  Music.swift
//  UIKit Nano
//
//  Created by Rafael Victor Ruwer Araujo on 16/06/21.
//

import Foundation

struct Music: Hashable, Decodable {
    let id: String
    
    let title: String
    let artist: String
    let length: TimeInterval
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
