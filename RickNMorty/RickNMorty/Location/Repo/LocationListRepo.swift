import Foundation

class LocationListRepo {
        
    func getData(_ urlString : String, _ errorCompletion : ((ApiError)->())? = nil, _ completion : ((LocationResponse)->())? = nil){
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                errorCompletion?(.URL)
            }
            return
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        
        URLSession.shared.dataTask(with: request) { data, response, error in
                        
            guard error == nil, let data = data else {
                DispatchQueue.main.async {
                    errorCompletion?(.Connection)
                }
                return
            }
            
            do {
                /*let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print(json)*/
                                
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                dateFormatter.locale = Locale(identifier: "en_US")
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let res : LocationResponse = try decoder.decode(LocationResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion?(res)
                }
            } catch _ {
                DispatchQueue.main.async {
                    errorCompletion?(.Json)
                }
            }
        }.resume()
    }
    
}

