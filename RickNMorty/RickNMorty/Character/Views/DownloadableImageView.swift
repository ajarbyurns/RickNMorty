import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

protocol DownloadableImageViewDelegate : AnyObject {
    func loadingState(_ loading: Bool)
}

class DownloadableImageView: UIImageView {
    
    var urlString: String?
    var dataTask: URLSessionDataTask?
    weak var delegate : DownloadableImageViewDelegate? = nil
    
    func downloadWithUrlSession(at cell: UICollectionViewCell, urlStr: String) {
                
        urlString = urlStr
        
        guard let url = URL(string: urlStr) else { return }
                
        if let imageFromCache = imageCache.object(forKey: urlStr as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        
        delegate?.loadingState(true)
        self.dataTask = URLSession.shared.dataTask(with: url) { [weak self]
            data, response, error in
            
            guard let self = self, let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async{
                    self?.delegate?.loadingState(false)
                }
                return
            }
            
            DispatchQueue.main.async {
                if self.urlString == urlStr {
                    self.image = image
                    self.delegate?.loadingState(false)
                }
                
                imageCache.setObject(image, forKey: urlStr as AnyObject)
            }
        }
        
        dataTask?.resume()
    }
    
    func cancelLoadingImage() {
        dataTask?.cancel()
        dataTask = nil
    }
}
