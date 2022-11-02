//
//  PageInfo.swift
//  RickNMorty
//
//  Created by bitocto_Barry on 01/11/22.
//

import Foundation

struct PageInfo : Decodable {
    let count : Int
    let pages : Int
    let next : String?
    let prev : String?
}
