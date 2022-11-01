//
//  CharactersResponse.swift
//  RickNMorty
//
//  Created by bitocto_Barry on 01/11/22.
//

import Foundation

struct CharactersResponse : Decodable {
    
    let info: PageInfo
    let results : [Character]
    
}
