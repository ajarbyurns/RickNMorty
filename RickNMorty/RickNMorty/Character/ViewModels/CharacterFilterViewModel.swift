//
//  CharacterFilterViewModel.swift
//  RickNMorty
//
//  Created by bitocto_Barry on 03/11/22.
//

import Foundation

class CharacterFilterViewModel : NSObject {
    
    let rows : [[String]] = [["Alive", "Dead", "Unknown"], ["Alien", "Animal", "Mythological Creature", "Human"], ["Male", "Female", "Genderless", "Unknown"]]
    let sections = ["Status", "Species", "Gender"]
    
    let header = "Filter"
    let buttonText = "Apply"
    
    let headerId = "FilterSectionHeader"
    
    var selected : [String?] = []
    
    override init(){
        super.init()
        for _ in sections {
            selected.append(nil)
        }
    }
    
    func selectAt(_ section : Int, _ row : Int){
        selected[section] = rows[section][row]
    }
    
    func deSelectAt(_ section : Int, _ row : Int){
        selected[section] = nil
    }
    
}
