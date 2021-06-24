//
//  CollectionDetailsCell.swift
//  UIKit Nano
//
//  Created by Anderson Sprenger on 21/06/21.
//

import UIKit
//protocol collectionDetailsCellDelegate : AnyObject{
//    func toggleFavorite(music:Music)
//}


class CollectionDetailsCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDescription: UILabel!
    
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    var service:MusicService?
    var music:Music?
//    weak var delegate: collectionDetailsCellDelegate?
    
    @IBAction func favoriteButton(_ sender: UIButton) {
//        let isFavorite = service?.favoriteMusics.contains(music!)
//        if isFavorite == true{
//            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        }
//        
//        if isFavorite! { // se for favorito, eu quero que ele n seja mais...
//            service?.toggleFavorite(music: music!, isFavorite: false)
//            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
//        } else { // se n for, eu quero q seja
//            service?.toggleFavorite(music: music!, isFavorite: true)
//            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        }
//        
//        favoriteButton.tintColor = isFavorite! ? .black : .red
//        delegate?.toggleFavorite(music: music!)
    }
    
}
