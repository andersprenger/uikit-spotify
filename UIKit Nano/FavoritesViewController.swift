//
//  FavoritesViewController.swift
//  UIKit Nano
//
//  Created by Willian Magnum Albeche on 22/06/21.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FavoriteCellDelegate {
    
    //id: 16a9b44f75da0f87aae8
    //id: 9673c3632d56ab7d6a7d

    @IBOutlet weak var favoriteTabView: UITableView!
    
    private var service: MusicService?
    
    var searchController = UISearchController()
    
    func toggleFavorite(music: Music) {
        favoriteTabView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.service = try? MusicService()
        favoriteTabView.delegate  = self
        favoriteTabView.dataSource = self
        navigationItem.searchController = searchController
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        service?.favoriteMusics.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTabView.dequeueReusableCell(withIdentifier: "favorite-cell", for: indexPath) as! FavoriteCell
        let cellMusic: Music = (service?.favoriteMusics[indexPath.row])!
        let isCellMusicFavorite = service?.favoriteMusics.contains(cellMusic)
        
        cell.service = service
        cell.music = cellMusic
        cell.delegate = self
        
        cell.imageCell.image = service?.getCoverImage(forItemIded: cellMusic.id)
        cell.labelTitleCell.text = cellMusic.title
        cell.labelSubtitleCell.text = cellMusic.artist
        
        cell.favoriteButton.setImage(UIImage(systemName: isCellMusicFavorite! ? "heart.fill" : "heart"), for: .normal)
        cell.favoriteButton.tintColor = isCellMusicFavorite! ? .red : .black
        
        return cell
    }
    
    // MARK: -- data flow (important for future reference)
    
    
    // when a row is selected, it performs a segue to the player...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "favorites-to-playing-segue", sender: indexPath)
        // ...and also set it's music as queue.nowPlaying
        guard let selectedMusic = service?.favoriteMusics[indexPath.row] else { return }
        service?.startPlaying(music: selectedMusic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // geting the controller of the segue destination, which is between this and is our de facto destination
        guard let navigationController = segue.destination as? UINavigationController else { return }
        // then geting our de facto destination though navigationController.topViewController
        guard let playerControler = navigationController.topViewController as? PlayingViewController else { return }
        
        // sending the data to our destination
        playerControler.musicService = service
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.favoriteTabView.reloadData()
    }
    
    func filterSearch(nameMusic: String) -> [Music]{
        service?.favoriteMusics.filter({ Music in
            Music.title.contains(nameMusic)
        }) ?? []
    }
}
