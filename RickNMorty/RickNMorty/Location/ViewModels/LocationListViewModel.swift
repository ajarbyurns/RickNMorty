import Foundation

protocol LocationListViewModelDelegate : AnyObject {
    func locationsSet()
    func noMorePages()
    func foundError(_ error: ApiError)
}

class LocationListViewModel : NSObject {
    
    weak var delegate : LocationListViewModelDelegate? = nil
    var locations : [Location] = []{
        didSet{
            delegate?.locationsSet()
        }
    }
    var nextPage : String? = nil
    var repo : LocationListRepo
    
    init(_ repo : LocationListRepo){
        self.repo = repo
    }
    
    func getLocations(){
        
        let url = "https://rickandmortyapi.com/api/location"
        
        repo.getData(url, { [weak self]
            error in
            self?.delegate?.foundError(error)
        }, { [weak self]
            res in
            self?.nextPage = res.info?.next
            self?.locations = res.results ?? []
        })
    }
    
    func getLocationsByFilter(_ name : String?, _ type : String? = nil, _ dimension : String? = nil){
        
        var url = "https://rickandmortyapi.com/api/location/?"
        
        var queryList : [String] = []
        if let name = name {
            queryList.append("name=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? name)")
        }
        if let type = type {
            queryList.append("type=\(type.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? type)")
        }
        if let dimension = dimension {
            queryList.append("dimension=\(dimension.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? dimension)")
        }
        
        if(queryList.isEmpty){
            return
        }
        
        for i in queryList.indices {
            url.append(queryList[i])
            if(i < queryList.count - 1){
                url.append("&")
            }
        }
        
        repo.getData(url, { [weak self]
            error in
            self?.delegate?.foundError(error)
        }, { [weak self]
            res in
            self?.nextPage = res.info?.next
            self?.locations = res.results ?? []
        })
    }
    
    func loadMore(){
        
        guard let nextPage = self.nextPage else {
            self.delegate?.noMorePages()
            return
        }
        
        repo.getData(nextPage, { [weak self]
            error in
            self?.delegate?.foundError(error)
        }, { [weak self]
            res in
            self?.nextPage = res.info?.next
            self?.locations.append(contentsOf: res.results ?? [])
        })
    }
    
}
