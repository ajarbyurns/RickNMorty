import Foundation

struct Episode : Decodable {
    
    let id: Int
    let name : String
    let airDate : String
    let episode : String
    let characters : [String]
    let url : String
    let created : Date
    
}
