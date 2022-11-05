import Foundation

struct LocationPageInfo : Decodable {
    let count : Int
    let pages : Int
    let next : String?
    let prev : String?
}
