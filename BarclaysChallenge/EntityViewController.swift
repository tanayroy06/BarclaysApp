//
//  EntityViewController.swift
//  BarclaysChallenge
//
//  Created by Tanay Kumar on 8/27/17.
//  Copyright © 2017 Tanay Kumar. All rights reserved.
//

import UIKit

protocol EntityEnteredDelegate: class {
    func userDidEnterEntity(entityTitle: String)
}



class EntityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let entity = ["All", "Movie", "Podcast", "Music", "Music Video", "Audiobook", "Short Film", "Tv Show", "Software", "ebook"]
    
    weak var delegate: EntityEnteredDelegate? = nil
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func dismissEntityController(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = entity[indexPath.row]
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.userDidEnterEntity( entityTitle: entity[indexPath.row])
        self.dismiss(animated: true, completion: {})
    }


}

