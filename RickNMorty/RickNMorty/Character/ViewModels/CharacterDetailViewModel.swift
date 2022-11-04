import Foundation

protocol CharacterDetailDelegate : AnyObject {
    func imageLoaded(_ imageData : Data)
    func foundError(_ error : ApiError)
}

class CharacterDetailViewModel : NSObject {
    
    weak var delegate : CharacterDetailDelegate?
    
    var character : Character
    var characterImgData : Data?{
        didSet{
            if let data = characterImgData {
                delegate?.imageLoaded(data)
            }
        }
    }
    var repo : CharacterDetailRepo
    var createdDate : String {
        get{
            return UTCToLocal()
        }
    }
    
    init(_ char : Character, _ imgData : Data?, _ repo : CharacterDetailRepo){
        self.character = char
        self.characterImgData = imgData
        self.repo = repo
    }
    
    func loadImage(){
        
        if let imgData = characterImgData {
            delegate?.imageLoaded(imgData)
            return
        }
        
        repo.getImageData(character.image, { [weak self]
            error in
            self?.delegate?.foundError(error)
        }, { [weak self]
            data in
            self?.delegate?.imageLoaded(data)
        })
    }
    
    private func UTCToLocal() -> String {
        let date = character.created.ISO8601Format()
        
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
