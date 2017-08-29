//
//  DetailsViewController.swift
//  BarclaysChallenge
//
//  Created by Tanay Kumar on 8/27/17.
//  Copyright © 2017 Tanay Kumar. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var descriptiionInfo: UILabel!

    public var searchItem : SearchItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    func configureView() {
        
        guard let searchItem = searchItem, isViewLoaded else {return}
        if let imageUrl = searchItem.artworkUrl100 {
            imageVIew.loadImageUsingUrlString(imageUrl)
        }
        trackName.text = searchItem.trackName
        descriptiionInfo.text = searchItem.description
    
    }
    
}
