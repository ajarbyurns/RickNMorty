import XCTest
@testable import RickNMorty

class EpisodeListRepoTest: XCTestCase {

    var repo : MockEpisodeListRepo? = nil
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        repo = MockEpisodeListRepo()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        repo = nil
    }

    func testBadURL() throws {
        
        let errorExp = expectation(description: "Error Returned")

        repo?.getData("", {
            error in
            errorExp.fulfill()
        }, nil)
        
        waitForExpectations(timeout: 1)
    }
    
    func testGoodURL() throws {
        
        let errorExp = expectation(description: "Error Returned")
        errorExp.isInverted = true

        repo?.getData("https://rickandmortyapi.com/api/episode", {
            error in
            if(error == .URL){
                errorExp.fulfill()
            }
        }, nil)
        
        waitForExpectations(timeout: 1)
    }
    
    func testGoodJSON() throws {
        let filePath = Bundle(for: type(of: self)).path(forResource: "EpisodeList", ofType: "json")!
        let contentString = try String(contentsOf: URL(fileURLWithPath: filePath))
        let data = contentString.data(using: .utf8)!
        repo?.data = data
        
        let errorExp = expectation(description: "Error Returned")
        errorExp.isInverted = true
        
        repo?.getData("https://rickandmortyapi.com/api/episode", {
            error in
            errorExp.fulfill()
        }, {
            res in
            XCTAssert(res.results?.isEmpty == false)
        })
        
        waitForExpectations(timeout: 1)
    }
    
    func testBadJSON() throws {
        let contentString = "{Wrong String}"
        let data = contentString.data(using: .utf8)!
        repo?.data = data
        
        let errorExp = expectation(description: "Error Returned")
        
        repo?.getData("https://rickandmortyapi.com/api/episode", {
            error in
            errorExp.fulfill()
        }, {
            res in
            XCTAssertNil(res)
        })
        
        waitForExpectations(timeout: 1)
    }

}

class MockEpisodeListRepo: EpisodeListRepo {
    
    var data : Data?
    
    override func getData(_ urlString: String, _ errorCompletion: ((ApiError) -> ())? = nil, _ completion: ((EpisodeResponse) -> ())? = nil) {
        
        guard URL(string: urlString) != nil else {
            DispatchQueue.main.async {
                errorCompletion?(.URL)
            }
            return
        }
        
        guard let data = self.data else {
            DispatchQueue.main.async {
                errorCompletion?(.Connection)
            }
            return
        }
        
        do {
                            
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let res : EpisodeResponse = try decoder.decode(EpisodeResponse.self, from: data)
            
            DispatchQueue.main.async {
                completion?(res)
            }
        } catch _ {
            DispatchQueue.main.async {
                errorCompletion?(.Json)
            }
        }
    }
}

