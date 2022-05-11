//
//  ViewController.swift
//  UIKit Nano
//
//  Created by Anderson Sprenger on 18/06/21.
//

import UIKit

class LibraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var service: MusicService?
    private var library: [MusicCollection]?
    
    @IBOutlet weak var libraryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.service = try? LocalMusicService()
        libraryTableView.dataSource = self
        libraryTableView.delegate = self
        
        self.library = service?.loadLibrary()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.library = service?.loadLibrary()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        library!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = libraryTableView.dequeueReusableCell(withIdentifier: "library-cell", for: indexPath) as! LibraryCell
        let cellItem: MusicCollection = (library?[indexPath.row])!
        
        cell.cellTitle.text = cellItem.title
        cell.cellDetails.text = "\(cellItem.type == MusicCollection.MusicCollectionType.playlist ? "Playlist" : "Album") · \(cellItem.mainPerson)"
        cell.cellImage.image = service?.getCoverImage(forItemIded: (cellItem.id))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "library-to-detail-segue", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let collectionDetailsVC = segue.destination as? CollectionDetailsViewController {
            collectionDetailsVC.musicCollection = library![sender as! Int]
            collectionDetailsVC.service = self.service
        }
    }
}

