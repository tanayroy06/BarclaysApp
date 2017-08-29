//
//  ViewController.swift
//  BarclaysChallenge
//
//  Created by Tanay Kumar on 8/27/17.
//  Copyright © 2017 Tanay Kumar. All rights reserved.
//

import UIKit
import Foundation

class SearchViewController: UIViewController, EntityEnteredDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var entityButton: UIButton!
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
        return recognizer
    }()
    
    @IBAction func entityButtonAction(_ sender: Any) {
        
        let entityViewController:EntityViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EntityViewController") as! EntityViewController
        self.present(entityViewController, animated: true, completion: nil)
        entityViewController.delegate = self
    }
    
    var searchResults: [SearchItem] = []
    let apiManager = APIManager.sharedInstance()
    
    let entityDict = ["all" : "All", "movie" : "Movie", "podcast" : "Podcast", "music" : "Music", "musicVideo" : "Music Video", "audiobook" : "Audiobook", "shortFilm" : "Short Film", "tvShow" : "Tv Show", "software" : "Software", "ebook" : "ebook"]
    
    func userDidEnterEntity(entityTitle: String) {
        entityButton.setTitle(entityTitle,for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
      
    }
    
}


// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell",for: indexPath)
        
        let searchItem = searchResults[indexPath.row]
        if let cell = cell as? SearchItemCell{
            cell.configure(searchItem: searchItem)
        }
        
        return cell
    }
    
    // MARK: - Segues
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = tableView.indexPathForSelectedRow,
            let detailsViewController = segue.destination as? DetailsViewController else { return }
        
        let searchItem = searchResults[(indexPath as NSIndexPath).row]
        detailsViewController.searchItem = searchItem
    }
}


