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
        let cell = favoriteTabView.dequeueReusableCell(withIdentifier: "favorite-cell", for: indexPath) as! FavoriteCell
        let cellItem: Music = (favorites?[indexPath.row])!
        cell.imageCell.image = service?.getCoverImage(forItemIded: cellItem.id)
        
        cell.labelTitleCell.text = cellItem.title
        cell.labelSubtitleCell.text = cellItem.artist
        
        return cell
    }
    
    // MARK: -- data flow (important for future reference)
    
    
    // when a row is selected, it performs a segue to the player...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "favorites-to-playing-segue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // geting the controller of the segue destination, which is between this and is our de facto destination
        guard let navigationController = segue.destination as? UINavigationController else { return }
        // then geting our de facto destination though navigationController.topViewController
        guard let playerControler = navigationController.topViewController as? PlayingViewController else { return }
        
        // sending the data to our destination
        playerControler.musicService = service
    }
}
