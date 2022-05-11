//
//  MusicServiceTests.swift
//  UIKit Nano Tests
//
//  Created by Anderson Sprenger on 10/05/22.
//

import XCTest
@testable import UIKit_Nano

class MusicServiceTests: XCTestCase {

    // system under test
    var sut: MusicService!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        sut = try MusicService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        sut = try MusicService()
    }
    
    func testLoadLibrary() {
        //given
        guard let sut = sut else { fatalError() }
        //when
        let collections = sut.loadLibrary()
        
        //then
        XCTAssertGreaterThanOrEqual(collections.count, 2)
        XCTAssertGreaterThanOrEqual(collections[0].referenceDate, collections[1].referenceDate)
    }
    
    func testGetCollection() {
        // given
        guard let sut = sut else { fatalError() }

        // when
        let collectionId = sut.loadLibrary().first?.id
        let collection = sut.getCollection(id: collectionId ?? "")
        
        // then
        XCTAssertNotNil(collection)
    }
    
    func testRemoveMusic() {
        // given
        guard let collection = sut.loadLibrary().first, let music = collection.musics.first else { fatalError() }
        
        // when
        sut.removeMusic(music, from: collection)
        
        // then
        guard let collection = sut.loadLibrary().first else { fatalError() }
        XCTAssertFalse(collection.musics.contains(music))
    }
    
    func testGetCoverImage() {
        // given
        guard let music = sut.loadLibrary().first?.musics.first else { fatalError() }

        // when
        let coverImage = sut.getCoverImage(forItemIded: music.id)
        
        // then
        XCTAssertNotNil(coverImage)
    }
    
    func testToggleFavorite() {
        // given
        guard let music = sut.loadLibrary().first?.musics.first else { fatalError() }
        guard let music2 = sut.loadLibrary().first?.musics.last else { fatalError() }

        // when
        sut.toggleFavorite(music: music, isFavorite: true)
        sut.toggleFavorite(music: music2, isFavorite: true)
        sut.toggleFavorite(music: music2, isFavorite: false)

        // then
        XCTAssert(sut.favoriteMusics.contains(music))
        XCTAssertFalse(sut.favoriteMusics.contains(music2))
    }
    
    func testStartPlayingMusic() {
        // given
        guard let collection = sut.loadLibrary().first, let music = collection.musics.last else { fatalError() }
        
        // when
        sut.startPlaying(music: music)
        
        // then
        XCTAssertEqual(sut.queue.nowPlaying, music)
    }
    
    func testStartPlayingCollection() {
        // given
        guard let collection = sut.loadLibrary().first, let music = collection.musics.first else { fatalError() }
        
        // when
        sut.startPlaying(collection: collection)
        
        // then
        XCTAssertEqual(sut.queue.nowPlaying, music)
    }
    
    func testRemoveFromQueue() {
        // given
        guard let collection = sut.loadLibrary().first, let music = collection.musics.last else { fatalError() }
        sut.startPlaying(collection: collection)
        
        // when
        sut.removeFromQueue(music: music)
        
        // then
        XCTAssertFalse(sut.queue.nowPlaying == music)
        XCTAssertFalse(sut.queue.nextInCollection.contains(music))
    }
    
    func testSkipFowardQueue() {
        // given
        
        // when
        
        // then
        
    }
    
    func testSearchfavoriteMusics() {
        // given
        
        // when
        
        // then
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
