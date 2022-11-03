//
//  Character.swift
//  RickNMorty


import Foundation

enum Status : String, Decodable {
    case Alive, Dead, unknown
}

enum Gender : String, Decodable {
    case Male, Female, Genderless, unknown
}

struct Character : Decodable {
    
    let id: Int
    let name : String
    let image : String
    let status : Status
    let species : String
    let gender : Gender
    let created : Date
    let location : CharacterLocation
    let origin : CharacterLocation
    let episode : [String]
}
