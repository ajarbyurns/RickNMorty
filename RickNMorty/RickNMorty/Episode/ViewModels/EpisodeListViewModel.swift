import Foundation

protocol EpisodeListViewModelDelegate : AnyObject {
    func episodesSet()
    func noMorePages()
    func foundError(_ error: ApiError)
}

class EpisodeListViewModel : NSObject {
    
    weak var delegate : EpisodeListViewModelDelegate? = nil
    var episodes : [Episode] = []{
        didSet{
            delegate?.episodesSet()
        }
    }
    var nextPage : String? = nil
    var repo : EpisodeListRepo
    
    init(_ repo : EpisodeListRepo){
        self.repo = repo
    }
    
    func getEpisodes(){
        
        let url = "https://rickandmortyapi.com/api/episode"
        
        repo.getData(url, { [weak self]
            error in
            self?.delegate?.foundError(error)
        }, { [weak self]
            res in
            self?.nextPage = res.info?.next
            self?.episodes = res.results ?? []
        })
    }
    
    func getEpisodesByFilter(_ name : String?, episode : String? = nil){
        
        var url = "https://rickandmortyapi.com/api/episode/?"
        
        var queryList : [String] = []
        if let name = name {
            queryList.append("name=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? name)")
        }
        if let episode = episode {
            queryList.append("episode=\(episode.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? episode)")
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
            self?.episodes = res.results ?? []
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
            self?.episodes.append(contentsOf: res.results ?? [])
        })
    }
    
}
