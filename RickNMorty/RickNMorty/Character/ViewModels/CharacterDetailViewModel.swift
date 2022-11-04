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
}
