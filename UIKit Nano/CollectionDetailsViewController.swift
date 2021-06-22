//
//  AlbumPlaylistDetailsViewControllerTableViewController.swift
//  UIKit Nano
//
//  Created by Anderson Sprenger on 21/06/21.
//

import UIKit
import Foundation

class CollectionDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        
        collectionImage.image = service?.getCoverImage(forItemIded: musicCollection!.id)
        collectionTitle.text = musicCollection?.title
        collectionDetails.text = "\(musicCollection!.type == MusicCollection.MusicCollectionType.playlist ? "Playlist" : "Album") by \(musicCollection!.mainPerson)"
        collectionSize.text = "\(musicCollection!.musics.count == 1 ? "1 song" : "\(musicCollection!.musics.count) songs")"
        
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale.current
        dateFormater.setLocalizedDateFormatFromTemplate("MMMMdYYYY")
        
        collectionDate.text = "Released \(dateFormater.string(from: musicCollection!.referenceDate))"
        
        collectionTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        musicCollection!.musics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = collectionTable.dequeueReusableCell(withIdentifier: "collection-cell") as! CollectionDetailsCell
        let music = musicCollection?.musics[indexPath.row]
        
        cell.cellImage.image = service?.getCoverImage(forItemIded: music!.id)
        cell.cellTitle.text = music?.title
        cell.cellDescription.text = music?.artist
        
        return cell
    }
}
