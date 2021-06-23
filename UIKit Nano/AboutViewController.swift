//
//  AboutViewController.swift
//  UIKit Nano
//
//  Created by Willian Magnum Albeche on 22/06/21.
//

import UIKit

class AboutViewController: UIViewController {
    
    var reciver:MusicCollection?
    var service:MusicService?
    
    @IBOutlet weak var albumImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var aboutAlbumLabel: UILabel!
    
    @IBOutlet weak var aboutArtistTitleLabel: UIStackView!
    @IBOutlet weak var aboutArtistLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumImage.image =  service?.getCoverImage(forItemIded: reciver!.id)
        titleLabel.text = reciver?.title
        var sum = TimeInterval()
        for i in 0..<(reciver?.musics.count ?? 0) {
            sum += (reciver?.musics[i].length) ?? 0
        }
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        
        detailsLabel.text = "Album by \(reciver?.mainPerson ?? "[Artist]") \n \(reciver?.musics.count) songs, \(formatter.string(from: sum))"
        aboutAlbumLabel.text = reciver?.albumDescription ?? "not an album, treat me 🩹"
        
        
    }
    
    
    
    //fazer divider entre as labels de texto grandao

    @IBAction func buttonViewDown(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
}
