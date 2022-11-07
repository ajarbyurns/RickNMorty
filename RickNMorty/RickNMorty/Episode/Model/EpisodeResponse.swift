import Foundation

struct EpisodeResponse : Decodable {
    
    let error: String?
    let info: EpisodePageInfo?
    let results : [Episode]?
    
}

