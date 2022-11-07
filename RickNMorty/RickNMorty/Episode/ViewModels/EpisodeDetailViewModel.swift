import Foundation

class EpisodeDetailViewModel : NSObject {
    
    var episode : Episode
    var createdDate : String {
        get{
            return UTCToLocal()
        }
    }
    var seasonNum : Int? {
        get{
            return parseSeason()
        }
    }
    var episodeNum : Int? {
        get{
            return parseEpisode()
        }
    }
    
    init(_ episode : Episode){
        self.episode = episode
    }
    
    private func parseSeason() -> Int?{
        let episodeArr = episode.episode.components(separatedBy: "E")
        if(episodeArr.count > 1){
            return Int(episodeArr[0].replacingOccurrences(of: "S", with: ""))
        } else {
            return nil
        }
    }
    
    private func parseEpisode() -> Int?{
        let episodeArr = episode.episode.components(separatedBy: "E")
        if(episodeArr.count > 1){
            return Int(episodeArr[1])
        } else {
            return nil
        }
    }
    
    private func UTCToLocal() -> String {
        let date = episode.created.ISO8601Format()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        if let dt = dateFormatter.date(from: date) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "HH:mm, MMMM yyyy"

            return dateFormatter.string(from: dt)
        } else {
            return date
        }
    }
    
}
