import Foundation

struct CharactersResponse : Decodable {
    
    let error: String?
    let info: CharacterPageInfo?
    let results : [Character]?
    
}
