//
//  AboutViewController.swift
//  UIKit Nano
//
//  Created by Willian Magnum Albeche on 22/06/21.
//

import UIKit

class AboutViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = table.dequeueReusableCell(withIdentifier: "about-top-cell") as! AboutTopViewCell
            return cell
        } else {
            let cell = table.dequeueReusableCell(withIdentifier: "about-bottom-cell") as! AboutBottomTableViewCell
            return cell
        }
    }
    
    
    var reciver:MusicCollection?
    var service:MusicService?
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        
        // MARK: -- explicando o reduce...
        // reduce eh basicamente um for com bastante açucar sintatico
        // para cada music em reciver?.musics
        // some a result (iniciado com 0 no parametro) music.length
        // como a soma retorna um Double, e TimeInterval eh um type alias pra Double, funciona.
        
        let sum: TimeInterval? = reciver?.musics.reduce(0) { result, music in
            result + music.length
        }

        // MARK: -- formatter pro TimeInterval virar uma String quase como esta no figma
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated // pra ficar igual tem que mudar alguma coisa aqui
    }
    
    
    
    //fazer divider entre as labels de texto grandao

    @IBAction func buttonViewDown(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
}
