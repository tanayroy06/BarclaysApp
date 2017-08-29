//
//  SearchItemCell.swift
//  BarclaysChallenge
//
//  Created by Tanay Kumar on 8/27/17.
//  Copyright © 2017 Tanay Kumar. All rights reserved.
//

import UIKit

public class SearchItemCell : UITableViewCell {
    
    @IBOutlet public weak var trackName: UILabel!
    @IBOutlet public weak var kind: UILabel!
    @IBOutlet public weak var trackPrice: UILabel!
    @IBOutlet weak var imageVIew: UIImageView!
    
    func configure(searchItem: SearchItem) {
        
        // Configure title and artist labels
        trackName.text = searchItem.trackName
        kind.text = searchItem.kind
        trackPrice.text = String(describing: searchItem.trackPrice!)
        if let thumbnailImageUrl = searchItem.artworkUrl60 {
            imageVIew.loadImageUsingUrlString(thumbnailImageUrl)
        }
        
    }
    
}
