import XCTest

class RickNMortyTest: XCTestCase {

    var repo : CharacterListRepo? = nil
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        repo = CharacterListRepo()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        repo = nil
    }

    func jsonDecoding() throws {
        let jsonData = try Data(contentsOf: URL(string: "EpisodeList.json")!)
        XCTAssertNoThrow(try JSONDecoder().decode(CharactersResponse.self, from: jsonData))
    }

}
