//
//  AboutViewController.swift
//  UIKit Nano
//
//  Created by Willian Magnum Albeche on 22/06/21.
//

import UIKit
import Foundation

class AboutViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!

    var reciver:MusicCollection?
    var service:MusicService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = table.dequeueReusableCell(withIdentifier: "about-top-cell") as! AboutTopViewCell
            
            // MARK: -- explicando o reduce...
            // reduce eh basicamente um for com bastante açucar sintatico
            // para cada music em reciver?.musics
            // some a result (iniciado com 0 no parametro) music.length
            // como a soma retorna um Double, e TimeInterval eh um type alias pra Double, funciona.
            
            let timeInterval: TimeInterval = reciver!.musics.reduce(0) { result, music in
                result + music.length
            }

            // MARK: -- formatter pro TimeInterval virar uma String quase como esta no figma
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .abbreviated
            formatter.allowedUnits = [.hour, .minute]
            
            cell.coverImage.image = service?.getCoverImage(forItemIded: reciver!.id)
            cell.titleLabel.text = reciver?.title
            cell.artistLabel.text = "Album by \(String(describing: reciver!.mainPerson))"
            cell.durationLabel.text = "\(reciver!.musics.count) songs, \(formatter.string(from: timeInterval) ?? "")"
            
            let dateFormater = DateFormatter()
            dateFormater.locale = Locale.current
            dateFormater.setLocalizedDateFormatFromTemplate("MMMMdYYYY")
            
            cell.dateLabel.text = "Released \(dateFormater.string(from: reciver!.referenceDate))"
            
            if let description = reciver?.albumDescription {
                cell.descriptionLabel.text = description
            }
            
            return cell
        } else {
            let cell = table.dequeueReusableCell(withIdentifier: "about-bottom-cell") as! AboutBottomTableViewCell
            
            cell.aboutArtistLabel.text = "About \(reciver!.mainPerson)"
            if let description = reciver!.albumArtistDescription {
                cell.artistDescriptionLabel.text = description
            }
            
            return cell
        }
    }

    @IBAction func buttonViewDown(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
}
