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
        self.service = try? MusicService()
        libraryTableView.dataSource = self
        libraryTableView.delegate = self
        
        self.library = service?.loadLibrary()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        service?.loadLibrary().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // FIXME: -- deveria melhorar o tratamento dos optionals abaixo?
        
        let cell = libraryTableView.dequeueReusableCell(withIdentifier: "library-cell", for: indexPath) as! LibraryCell
        let cellItem: MusicCollection = (library?[indexPath.row])!
        
        cell.cellTitle.text = cellItem.title
        cell.cellDetails.text = "\(cellItem.type == MusicCollection.MusicCollectionType.playlist ? "Playlist" : "Album") · \(cellItem.mainPerson)"
        cell.cellImage.image = service?.getCoverImage(forItemIded: (cellItem.id))
        
        return cell
    }
}

