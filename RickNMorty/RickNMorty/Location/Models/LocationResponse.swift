import Foundation

struct LocationResponse : Decodable {
    
    let error: String?
    let info: LocationPageInfo?
    let results : [Location]?
    
}
