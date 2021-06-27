//
//  Queue.swift
//  UIKit Nano
//
//  Created by Rafael Victor Ruwer Araujo on 16/06/21.
//

import Foundation

struct Queue {
    var nowPlaying: Music?
    
    var collection: MusicCollection?
    var nextInCollection: [Music]
    
    var nextSuggested: [Music]
}
