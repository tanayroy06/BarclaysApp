//
//  Dictionary+Equatable.swift
//  BarclaysChallenge
//
//  Created by Tanay Kumar on 8/27/17.
//  Copyright © 2017 Tanay Kumar. All rights reserved.
//

import Foundation


/*This extension is used to fetch the corresponding keys from an array based on the user selected entity value*/
extension Dictionary where Value: Equatable {
    func allKeys(forValue val: Value) -> [Key] {
        return self.filter { $1 == val }.map { $0.0 }
    }
}
