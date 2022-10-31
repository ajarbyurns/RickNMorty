//
//  Character.swift
//  RickNMorty


import Foundation

struct Character : Decodable {
    
    enum Status : String, Decodable {
        case Alive, Dead, unknown
    }
    
    enum Gender : String, Decodable {
        case Male, Female, Genderless, unknown
    }
    
    let id: Int
    let name : String
    let image : URL
    let status : Status
    let species : String
    let gender : Gender
    let created : Date
    let location : CharacterLocation
    let origin : CharacterLocation
    let episode : [String]
}
