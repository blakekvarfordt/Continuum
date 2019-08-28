//
//  SearchableRecord.swift
//  Continuum
//
//  Created by Blake kvarfordt on 8/28/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import Foundation

protocol SearchableRecord {
    func matches(searchTerm: String) -> Bool 
}
