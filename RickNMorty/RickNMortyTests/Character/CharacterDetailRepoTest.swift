import XCTest
@testable import RickNMorty

class CharacterDetailRepoTest: XCTestCase {

    var repo : MockCharacterDetailRepo? = nil
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        repo = MockCharacterDetailRepo()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        repo = nil
    }

    func testBadURL() throws {
        
        let errorExp = expectation(description: "Error Returned")

        repo?.getImageData("", {
            error in
            errorExp.fulfill()
        }, nil)
        
        waitForExpectations(timeout: 1)
    }
    
    func testGoodURL() throws {
        
        let errorExp = expectation(description: "Error Returned")
        errorExp.isInverted = true

        repo?.getImageData("https://www.dummy.com", {
            error in
            if(error == .URL){
                errorExp.fulfill()
            }
        }, nil)
        
        waitForExpectations(timeout: 1)
    }
    
    func testGoodData() throws {
        let contentString = "Dummy Data"
        let data = contentString.data(using: .utf8)!
        repo?.data = data
        
        let errorExp = expectation(description: "Error Returned")
        errorExp.isInverted = true
        
        repo?.getImageData("https://www.dummy.com", {
            error in
            errorExp.fulfill()
        }, {
            res in
            XCTAssertNotNil(res)
        })
        
        waitForExpectations(timeout: 1)
    }
    
    func testNilData() throws {
        repo?.data = nil
        
        let errorExp = expectation(description: "Error Returned")
        
        repo?.getImageData("https://www.dummy.com", {
            error in
            errorExp.fulfill()
        }, {
            res in
            XCTAssertNil(res)
        })
        
        waitForExpectations(timeout: 1)
    }

}

class MockCharacterDetailRepo: CharacterDetailRepo {
    
    var data : Data?
    
    override func getImageData(_ urlString: String, _ errorCompletion: ((ApiError) -> ())? = nil, _ completion: ((Data) -> ())? = nil) {
        
        guard URL(string: urlString) != nil else {
            DispatchQueue.main.async {
                errorCompletion?(.URL)
            }
            return
        }
        
        guard let data = data else {
            DispatchQueue.main.async{
                errorCompletion?(.Connection)
            }
            return
        }
        
        DispatchQueue.main.async {
            completion?(data)
        }
    }
}

