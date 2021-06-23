//
//  FavoritesViewController.swift
//  UIKit Nano
//
//  Created by Willian Magnum Albeche on 22/06/21.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //id: 16a9b44f75da0f87aae8
    //id: 9673c3632d56ab7d6a7d
    
    private var service: MusicService?
    private var favorites: [Music]?
    
    
    @IBOutlet weak var favoriteTabView: UITableView!
    
    var searchController = UISearchController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.service = try? MusicService()
        favorites = service?.favoriteMusics
        favoriteTabView.delegate  = self
        favoriteTabView.dataSource = self
        navigationItem.searchController = searchController
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        service?.favoriteMusics.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        service?.favoriteMusics
        let cell =
            favoriteTabView.dequeueReusableCell(withIdentifier: "favorite-cell", for: indexPath) as! FavoriteCell
        let cellItem: Music = (favorites?[indexPath.row])!
        cell.imageCell.image = service?.getCoverImage(forItemIded: cellItem.id)
        
        cell.labelTitleCell.text = cellItem.title
        cell.labelSubtitleCell.text = cellItem.artist
        
        return cell
    }
    
    
    
    
    
}
