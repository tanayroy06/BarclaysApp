//
//  SearchVC+SearchBar.swift
//  BarclaysChallenge
//
//  Created by Tanay Kumar on 8/28/17.
//  Copyright © 2017 Tanay Kumar. All rights reserved.
//

import Foundation
import UIKit

extension SearchViewController: UISearchBarDelegate {
    
    func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    /*The searchBarSearchButtonClicked function is responsible for calling the API manager to handle the network calls and also update the UI appropriately based on the response from the URL's*/
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        let keys = entityDict.allKeys(forValue: (entityButton.titleLabel?.text)!)
        if !searchBar.text!.isEmpty {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            apiManager.getSearchResults(searchTerm: searchBar.text!, searchEntity: keys[0]) { results, errorMessage in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if let results = results {
                    self.searchResults = results
                    self.tableView.reloadData()
                    self.tableView.setContentOffset(CGPoint.zero, animated: true)
                }
                if !errorMessage.isEmpty {
                   self.showAlertControllerOnError(errorMessage)
                }
            }
        }
    }
    
    func showAlertControllerOnError(_ errorMessage:String){
        
        let alert = UIAlertController(title: "Alert", message: "This search contains zero result. Reason: " + errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.removeGestureRecognizer(tapRecognizer)
    }
}
