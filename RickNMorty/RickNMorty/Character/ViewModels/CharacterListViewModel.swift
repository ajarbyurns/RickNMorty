//
//  CharacterListViewModel.swift
//  RickNMorty
//
//  Created by bitocto_Barry on 01/11/22.
//

import Foundation

enum ApiError {
    case ConnectionError, JSONError
}

protocol CharacterListViewModelDelegate : AnyObject {
    func setCharacters(_ characters : [Character])
    func error(_ error: ApiError)
}

class CharacterListViewModel : NSObject {
    
    weak var delegate : CharacterListViewModelDelegate? = nil
    var characters : [Character] = []{
        didSet{
            delegate?.setCharacters(characters)
        }
    }
    
    func getCharacters(){
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            print("URL is Wrong")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        
        URLSession.shared.dataTask(with: request) {data, response, error in
                        
            guard error == nil, let data = data else {
                print(error.debugDescription)
                self.delegate?.error(.ConnectionError)
                return
            }
            
            do {
                /*let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print(json)*/
                                
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                dateFormatter.locale = Locale(identifier: "en_US")
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let charResp : CharactersResponse = try decoder.decode(CharactersResponse.self, from: data)
                self.characters = charResp.results
            } catch let jsonError {
                print(jsonError.localizedDescription)
                self.delegate?.error(.JSONError)
            }
        }.resume()
    }
    
}
