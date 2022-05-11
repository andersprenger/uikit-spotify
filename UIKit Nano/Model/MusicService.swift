//
//  MusicService.swift
//  Delegated
//
//  Created by Rafael Victor Ruwer Araujo on 16/06/21.
//

import Foundation
import UIKit

final class LocalMusicService: MusicService {
    let allMusics: [Music]
    var collections: Set<MusicCollection>
    
    /// The queue with the music being played and the next musics.
    var queue: Queue
    
    init() throws {
        // may the superior entity (if such exists) forgive me for such terrible practice :'//
        let mockDataUrl = Bundle.main.url(forResource: "data", withExtension: "json")!
        let data = try Data(contentsOf: mockDataUrl)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        self.collections = try decoder.decode(Set<MusicCollection>.self, from: data)
        self.allMusics = collections.flatMap(\.musics)
        
        self.queue = Queue(nowPlaying: nil, collection: nil, nextInCollection: [], nextSuggested: [])
    }
    
}

protocol MusicService: AnyObject {
    var allMusics: [Music] { get }
    var collections: Set<MusicCollection> { get set }
    
    /// The queue with the music being played and the next musics.
    var queue: Queue { get set }
    
    /// List of musics the user has favorited, in chronological order of addition to the favorite list.
    var favoriteMusics: [Music] { get set }
    
    // MARK: Library
    
    func loadLibrary() -> [MusicCollection]
    
    func getCollection(id: String) -> MusicCollection?
    
    func removeMusic(_ music: Music, from collection: MusicCollection)
    
    // MARK: Cover art
    
    /// Gets the cover art image for a collection or a music.
    ///
    /// - Parameter itemId: ID of a `Music` or `MusicCollection`.
    /// - Returns: Image object representing the item's cover art.
    func getCoverImage(forItemIded itemId: String) -> UIImage?
    
    // MARK: Favorites
    
    /// Toggles the favorite status of a music.
    ///
    /// - Parameters:
    ///   - music: The music to be added to, or removed from, the list of favorite musics of the user.
    ///   - isFavorite: Whether the music is favorited or not.
    func toggleFavorite(music: Music, isFavorite: Bool)
    
    // MARK: Playing/Queue
    
    func startPlaying(collection: MusicCollection)
    
    func startPlaying(music: Music)
    
    func removeFromQueue(music: Music)
    
    // MARK: customizations
    
    func skipNextQueue()
    
    func skipForwardQueue()
    
    func searchfavoriteMusics(text: String) -> [Music]
}

extension MusicService {
    /// List of musics the user has favorited, in chronological order of addition to the favorite list.
    var favoriteMusics: [Music] {
        get {
            let favoriteMusicsIDs = UserDefaults(suiteName: String(describing: Self.self))?.array(forKey: "favorite-musics-ids") as? [String] ?? []
            return favoriteMusicsIDs.compactMap { musicID in
                allMusics.first { $0.id == musicID }
            }
        }
        set {
            let musicsIDs = newValue.map(\.id)
            UserDefaults.standard.set(musicsIDs, forKey: "favorite-musics-ids")
        }
    }
    
    // MARK: Library
    
    func loadLibrary() -> [MusicCollection] {
        collections.sorted { $0.referenceDate > $1.referenceDate }
    }
    
    func getCollection(id: String) -> MusicCollection? {
        collections.first { $0.id == id }
    }
    
    func removeMusic(_ music: Music, from collection: MusicCollection) {
        guard collection.supportsEdition else { return }
        
        // since MusicCollection is a value type (i.e. struct),
        // we need to remove the existing value from collections and then insert back the modified one
        collections.remove(collection)
        
        var collectionCopy = collection
        collectionCopy.musics.removeAll { $0.id == music.id }
        collections.insert(collectionCopy)
    }
    
    // MARK: Cover art
    
    /// Gets the cover art image for a collection or a music.
    ///
    /// - Parameter itemId: ID of a `Music` or `MusicCollection`.
    /// - Returns: Image object representing the item's cover art.
    func getCoverImage(forItemIded itemId: String) -> UIImage? {
        UIImage(named: itemId)
    }
    
    // MARK: Favorites
    
    /// Toggles the favorite status of a music.
    ///
    /// - Parameters:
    ///   - music: The music to be added to, or removed from, the list of favorite musics of the user.
    ///   - isFavorite: Whether the music is favorited or not.
    func toggleFavorite(music: Music, isFavorite: Bool) {
        if isFavorite {
            favoriteMusics.append(music)
        } else {
            favoriteMusics.removeAll { $0 == music }
        }
    }
    
    // MARK: Playing/Queue
    
    func startPlaying(collection: MusicCollection) {
        let nonRepeatedMusics = Set(collections.flatMap(\.musics)).subtracting(collection.musics)
        let suggestions = (0..<10).compactMap { _ in nonRepeatedMusics.randomElement() }
        
        queue = Queue(
            nowPlaying: collection.musics.first,
            collection: collection,
            nextInCollection: Array(collection.musics.dropFirst()),
            nextSuggested: suggestions)
    }
    
    func startPlaying(music: Music) {
        queue = Queue(nowPlaying: music, collection: nil, nextInCollection: [], nextSuggested: [])
    }
    
    func removeFromQueue(music: Music) {
        queue.nextInCollection.removeAll { $0 == music }
        queue.nextSuggested.removeAll { $0 == music }
    }
    
    // MARK: customizations
    
    func skipNextQueue(){
        queue.nowPlaying = queue.nextInCollection.first
        
        if !queue.nextInCollection.isEmpty {
            queue.nextInCollection.removeFirst()
        }
    }
    
    func skipForwardQueue(){
        guard let musicsCount = queue.collection?.musics.count else { return }
        guard let playerMusic = queue.nowPlaying else { return }
        
        startPlaying(collection: queue.collection!)
        
        if queue.nowPlaying == playerMusic {
            return
        }
        
        for _ in 0..<musicsCount {
            if queue.nextInCollection.first == playerMusic {
                break
            } else {
                skipNextQueue()
            }
        }
    }
    
    func searchfavoriteMusics(text: String) -> [Music]{
        self.favoriteMusics.filter { music in
            music.title.contains(text)
        }
    }
}
