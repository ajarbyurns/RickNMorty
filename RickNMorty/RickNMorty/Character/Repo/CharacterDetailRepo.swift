import Foundation

class CharacterDetailRepo {
    
    func getImageData(_ urlString : String, _ errorCompletion : ((ApiError)->())? = nil, _ completion : ((Data)->())? = nil){
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                errorCompletion?(.URL)
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            guard error == nil, let data = data else {
                DispatchQueue.main.async{
                    errorCompletion?(.Connection)
                }
                return
            }
            
            DispatchQueue.main.async {
                completion?(data)
            }
        }.resume()
    }
    
}
