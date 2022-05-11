//
//  MusicServiceTests.swift
//  UIKit Nano Tests
//
//  Created by Anderson Sprenger on 10/05/22.
//

import XCTest
@testable import UIKit_Nano

class MockMusicService: MusicService {
    var allMusics: [Music] = []
    var collections: Set<MusicCollection> = []
    var queue: Queue = Queue(nowPlaying: nil, collection: nil, nextInCollection: [], nextSuggested: [])
}

class MusicServiceTests: XCTestCase {

    // system under test
    var sut: MusicService!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        sut = MockMusicService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        sut = MockMusicService()
    }
    
    func testLoadLibrary() {
        //given
        
        //when
        let collections = sut.loadLibrary()
        
        //then
        XCTAssertGreaterThanOrEqual(collections.count, 2)
        XCTAssertGreaterThanOrEqual(collections[0].referenceDate, collections[1].referenceDate)
    }
    
    func testGetCollection() {
        // given
        
        // when
        let collectionId = sut.loadLibrary().first?.id
        let collection = sut.getCollection(id: collectionId ?? "")
        
        // then
        XCTAssertNotNil(collection)
    }
    
    func testRemoveMusic() {
        // given
        guard let collection = sut.loadLibrary().first, let music = collection.musics.first else { return }
        
        // when
        sut.removeMusic(music, from: collection)
        
        // then
        guard let collection = sut.loadLibrary().first else { return }
        XCTAssertFalse(collection.musics.contains(music))
    }
    
    func testGetCoverImage() {
        
    }
    
    func testToggleFavorite() {
        
    }
    
    func testStartPlaying() {
        
    }
    
    func testRemoveFromQueue() {
        
    }
    
    func testSkipFowardQueue() {
        
    }
    
    func testSearchfavoriteMusics() {
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
