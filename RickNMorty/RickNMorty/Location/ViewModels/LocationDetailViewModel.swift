import Foundation

class LocationDetailViewModel : NSObject {
    
    var location : Location
    var createdDate : String {
        get{
            return UTCToLocal()
        }
    }
    
    init(_ location : Location){
        self.location = location
    }
    
    private func UTCToLocal() -> String {
        let date = location.created.ISO8601Format()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        if let dt = dateFormatter.date(from: date) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "HH:mm, MMM yyyy"

            return dateFormatter.string(from: dt)
        } else {
            return date
        }
    }
    
}
