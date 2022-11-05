//
//  CharacterListViewModel.swift
//  RickNMorty
//
//  Created by bitocto_Barry on 01/11/22.
//

import Foundation

protocol CharacterListViewModelDelegate : AnyObject {
    func charactersSet()
    func noMorePages()
    func foundError(_ error: ApiError)
}

class CharacterListViewModel : NSObject {
    
    weak var delegate : CharacterListViewModelDelegate? = nil
    var characters : [Character] = []{
        didSet{
            delegate?.charactersSet()
        }
    }
    var nextPage : String? = nil
    var repo : CharacterListRepo
    
    init(_ repo : CharacterListRepo){
        self.repo = repo
    }
    
    func getCharacters(){
        
        let url = "https://rickandmortyapi.com/api/character"
        
        repo.getData(url, { [weak self]
            error in
            self?.delegate?.foundError(error)
        }, { [weak self]
            (charResp : CharactersResponse) in
            self?.nextPage = charResp.info?.next
            self?.characters = charResp.results ?? []
        })
    }
    
    func getCharactersByFilter(_ name : String?, _ status : String? = nil, _ species : String? = nil, _ gender : String? = nil){
        
        var url = "https://rickandmortyapi.com/api/character/?"
        
        var queryList : [String] = []
        if let name = name {
            queryList.append("name=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? name)")
        }
        if let status = status {
            queryList.append("status=\(status.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? status)")
        }
        if let species = species {
            queryList.append("species=\(species.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? species)")
        }
        if let gender = gender {
            queryList.append("gender=\(gender.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? gender)")
        }
        
        if(queryList.isEmpty){
            return
        }
        
        for i in queryList.indices {
            url.append(queryList[i])
            if(i < queryList.count - 1){
                url.append("&")
            }
        }
        
        repo.getData(url, { [weak self]
            error in
            self?.delegate?.foundError(error)
        }, { [weak self]
            (charResp : CharactersResponse) in
            self?.nextPage = charResp.info?.next
            self?.characters = charResp.results ?? []
        })
    }
    
    func loadMoreCharacters(){
        
        guard let nextPage = self.nextPage else {
            self.delegate?.noMorePages()
            return
        }
        
        repo.getData(nextPage, { [weak self]
            error in
            self?.delegate?.foundError(error)
        }, { [weak self]
            (charResp : CharactersResponse) in
            self?.nextPage = charResp.info?.next
            self?.characters.append(contentsOf: charResp.results ?? [])
        })
    }
    
}
