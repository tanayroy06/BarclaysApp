//
//  UIImageView+LoadFromURL.swift
//  BarclaysChallenge
//
//  Created by Tanay Kumar on 8/27/17.
//  Copyright © 2017 Tanay Kumar. All rights reserved.
//

import UIKit


/*This extension moves the image loading process of the UIImageView from the main thread to background thread to avoid extensive work on the main thread*/
extension UIImageView {

    func loadImageUsingUrlString(_ urlString: String) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: {
           (data, respones, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async(execute: {
                self.image = UIImage(data: data!)
            })
            
        }).resume()
    }
    
}
