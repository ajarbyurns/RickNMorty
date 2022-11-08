import XCTest
@testable import RickNMorty

class CharacterDetailVMTest: XCTestCase {

    var repo : MockCharacterDetailRepo?
    var viewModel : CharacterDetailViewModel?

    override func setUpWithError() throws {
        try super.setUpWithError()
        repo = MockCharacterDetailRepo()
        viewModel = CharacterDetailViewModel(setupCorrectCharacter(), repo!)
        imageDataCache.removeAllObjects()
    }

    override func tearDownWithError() throws {
        repo = nil
        viewModel = nil
        imageDataCache.removeAllObjects()
    }
    
    func testCreatedDateReturnsLocal() throws {
        let date = viewModel!.createdDate
        let characterDate = viewModel!.character.created
        XCTAssert(date == UTCToLocal(characterDate))
    }
    
    private func UTCToLocal(_ input : Date) -> String {
        let date = input.description
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        if let dt = dateFormatter.date(from: date) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "HH:mm, MMMM yyyy"

            return dateFormatter.string(from: dt)
        } else {
            return date
        }
    }
    
    func testCorrectImageDataLoaded() throws {
        let delegate = MockCharacterDetailViewModelDelegate(testCase: self)
        delegate.imageExpectation = expectation(description: "Image Loaded")
        delegate.errorExpectation = expectation(description: "Error Found")
        delegate.errorExpectation?.isInverted = true
        
        let contentString = setupCorrectCharacter().image
        let data = contentString.data(using: .utf8)!
        repo?.data = data
        viewModel?.delegate = delegate
                
        viewModel?.loadImage()
        
        waitForExpectations(timeout: 1)
    }
    
    func testNoImageDataLoaded() throws {
        let delegate = MockCharacterDetailViewModelDelegate(testCase: self)
        delegate.imageExpectation = expectation(description: "Image Loaded")
        delegate.imageExpectation?.isInverted = true
        delegate.errorExpectation = expectation(description: "Error Found")
        
        repo?.data = nil
        viewModel?.delegate = delegate
                
        viewModel?.loadImage()
        
        waitForExpectations(timeout: 1)
    }
    
    private func setupCorrectCharacter() -> Character{
        let char = Character(id: 1, name: "Rick Sanchez", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", status: .Alive, species: "Human", gender: .Male, created: Date.now, location: CharacterLocation(name: "Earth", url: "https://rickandmortyapi.com/api/location/20"), origin: CharacterLocation(name: "Earth", url: "https://rickandmortyapi.com/api/location/1"), episode: [
            "https://rickandmortyapi.com/api/episode/1",
            "https://rickandmortyapi.com/api/episode/2"
        ])
        return char
    }

}

class MockCharacterDetailViewModelDelegate : CharacterDetailDelegate {
    
    var imageExpectation: XCTestExpectation?
    var errorExpectation : XCTestExpectation?
    
    private let testCase: XCTestCase
    
    init(testCase: XCTestCase) {
        self.testCase = testCase
    }

    func imageLoaded(_ imageData: Data) {
        imageExpectation?.fulfill()
    }
    
    func foundError(_ error: ApiError) {
        errorExpectation?.fulfill()
    }
}
