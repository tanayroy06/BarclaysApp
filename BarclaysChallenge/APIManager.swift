//
//  APIManager.swift
//  BarclaysChallenge
//
//  Created by Tanay Kumar on 8/28/17.
//  Copyright © 2017 Tanay Kumar. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]
typealias QueryResult = ([SearchItem]?, String) -> ()


class APIManager {
    
    /*Create a singleton for the APIManager object*/
    static let _sharedInstance = APIManager()
    static func sharedInstance() -> APIManager {
        return _sharedInstance
    }
    

    var searchResults: [SearchItem] = []
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    
    
    /*The getSearchResults function takes 3 parameters:
     1. searchTerm - The user input in the search bar for the search value
     2. searchEntity - The user selection from the dropdown from a list of pre-defined entity terms
     3. completion - Completion handler to successfully pass the data back to the callee class
     */
    
     func getSearchResults(searchTerm: String, searchEntity: String, completion: @escaping QueryResult) {
        dataTask?.cancel()
        errorMessage = ""
        //create a complete URL to poll based on the user inputs
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")
        urlComponents?.queryItems?.append(URLQueryItem(name: "term", value: searchTerm))
        urlComponents?.queryItems?.append(URLQueryItem(name: "entity", value: searchEntity))
        guard let url = urlComponents?.url else { return }
        
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            
            if let error = error {
                self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                completion(self.searchResults,self.errorMessage)
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self.updateSearchResults(data)
                DispatchQueue.main.async {
                    completion(self.searchResults, self.errorMessage)
                }
            } else {
                
                self.errorMessage += "Status code is not 200"
                DispatchQueue.main.async {
                    completion(self.searchResults, self.errorMessage)
                }
            
            }
            
        }
        dataTask?.resume()
    }
    
    // MARK: - Helper methods
    /*The function is used to populate the SearchItem model object based on the response from the network call*/
     func updateSearchResults(_ data: Data) {
        var response: JSONDictionary?
        searchResults.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let array = response!["results"] as? [Any] else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }
        
        for searchItemDictionary in array {
            guard let trackDictionary = searchItemDictionary as? JSONDictionary else {return}
            
            let trackPrice = trackDictionary["trackPrice"] as? Double ?? 0.0
            let description = trackDictionary["description"] as? String ?? "N/A"
            
            let trackName = trackDictionary["trackName"] as? String ?? "N/A"
            let kind = trackDictionary["kind"] as? String ?? "N/A"
            
            if let artworkUrl60 = trackDictionary["artworkUrl60"] as? String,
            let artworkUrl100 = trackDictionary["artworkUrl100"] as? String {
                searchResults.append(SearchItem(trackName: trackName, artworkUrl60: artworkUrl60, kind: kind, trackPrice: trackPrice, artworkUrl100: artworkUrl100, description: description))
            } else {
                errorMessage += "Problem parsing trackDictionary\n"
            }
        }
    }


}
