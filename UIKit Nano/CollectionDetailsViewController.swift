//
//  AlbumPlaylistDetailsViewControllerTableViewController.swift
//  UIKit Nano
//
//  Created by Anderson Sprenger on 21/06/21.
//

import UIKit
import Foundation

class CollectionDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var intoButton: UIBarButtonItem!
    
    @IBOutlet weak var collectionImage: UIImageView!
    
    @IBOutlet weak var collectionTitle: UILabel!
    @IBOutlet weak var collectionDetails: UILabel!
    
    @IBOutlet weak var collectionSize: UILabel!
    @IBOutlet weak var collectionDate: UILabel!
    
    @IBOutlet weak var collectionTable: UITableView!
    
    var service: MusicService?
    var musicCollection: MusicCollection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = musicCollection?.title
        
        collectionImage.image = service?.getCoverImage(forItemIded: musicCollection!.id)
        collectionTitle.text = musicCollection?.title
        collectionDetails.text = "\(musicCollection!.type == MusicCollection.MusicCollectionType.playlist ? "Playlist" : "Album") by \(musicCollection!.mainPerson)"
        collectionSize.text = "\(musicCollection!.musics.count == 1 ? "1 song" : "\(musicCollection!.musics.count) songs")"
        
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale.current
        dateFormater.setLocalizedDateFormatFromTemplate("MMMMdYYYY")
        
        collectionDate.text = "Released \(dateFormater.string(from: musicCollection!.referenceDate))"
        
        if musicCollection?.type == MusicCollection.MusicCollectionType.playlist {
            intoButton.isEnabled = false
        }
        
        collectionTable.dataSource = self
        collectionTable.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.collectionTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        musicCollection!.musics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = collectionTable.dequeueReusableCell(withIdentifier: "collection-cell") as! CollectionDetailsCell
        let music = musicCollection?.musics[indexPath.row]
        
        cell.service = service
        cell.music = music
        
        let isFavorite = service?.favoriteMusics.contains(music!)
        cell.favoriteButton.setImage(UIImage(systemName: isFavorite! ? "heart.fill" : "heart"), for: .normal)
        cell.favoriteButton.tintColor = isFavorite! ? .red : .systemGray
        
        cell.cellImage.image = service?.getCoverImage(forItemIded: music!.id)
        cell.cellTitle.text = music?.title
        cell.cellDescription.text = music?.artist
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "library-to-player", sender: nil)
        
        service?.startPlaying(collection: musicCollection!)
        
        for _ in 0..<indexPath.row {
            service?.skipNextQueue()
        }
        
    }
    
    @IBAction func buttonInfo(_ sender: Any) {
        if musicCollection?.type == MusicCollection.MusicCollectionType.album {
            performSegue(withIdentifier: "aboutCell", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let aboutViewController = segue.destination as? AboutViewController {
            aboutViewController.reciver = musicCollection
            aboutViewController.service = service
        } else if let navigationController = segue.destination as? UINavigationController {
            // then geting our de facto destination though navigationController.topViewController
            guard let playerControler = navigationController.topViewController as? PlayingViewController else { return }
            // sending the data to our destination
            playerControler.musicService = service
        }
    }
    
    // FIXME: -- extra feature: swipe to delete (n esta persistindo)
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete, musicCollection?.type == .playlist {
            tableView.beginUpdates()
            
            service?.removeMusic((musicCollection!.musics[indexPath.row]), from: musicCollection!)
            musicCollection = service?.getCollection(id: musicCollection!.id)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }
}
