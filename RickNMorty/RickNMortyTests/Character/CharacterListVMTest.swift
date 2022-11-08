import XCTest
@testable import RickNMorty

class CharacterListVMTest: XCTestCase {
    
    var repo : MockCharacterListRepo?
    var viewModel : CharacterListViewModel?

    override func setUpWithError() throws {
        try super.setUpWithError()
        repo = MockCharacterListRepo()
        viewModel = CharacterListViewModel(repo!)
    }

    override func tearDownWithError() throws {
        repo = nil
        viewModel = nil
    }

    func testGetCharactersCorrectData() throws {
        let delegate = MockCharacterListViewModelDelegate(testCase: self)
        delegate.charExpectation = expectation(description: "Characters Set")
        delegate.errorExpectation = expectation(description: "Error Found")
        delegate.errorExpectation?.isInverted = true
        
        repo?.data = try setupCorrectData()
        viewModel?.delegate = delegate
                
        viewModel?.getCharacters()
        
        waitForExpectations(timeout: 1)
    }
    
    func testGetCharactersWrongData() throws {
        let delegate = MockCharacterListViewModelDelegate(testCase: self)
        delegate.charExpectation = expectation(description: "Characters Set")
        delegate.charExpectation?.isInverted = true
        delegate.errorExpectation = expectation(description: "Error Found")
        
        repo?.data = try setupWrongData()
        viewModel?.delegate = delegate
                
        viewModel?.getCharacters()
        
        waitForExpectations(timeout: 1)
    }
    
    func testLoadMoreCharactersIfHaveNextPage() throws {
        let delegate = MockCharacterListViewModelDelegate(testCase: self)
        delegate.charExpectation = expectation(description: "Characters Set")
        delegate.noMorePagesExpectation = expectation(description: "No More New Pages")
        delegate.noMorePagesExpectation?.isInverted = true
        
        repo?.data = try setupCorrectData()
        viewModel?.delegate = delegate
        
        viewModel?.nextPage = "http://www.dummy.com"
        viewModel?.loadMoreCharacters()
        
        waitForExpectations(timeout: 1)
    }
    
    func testLoadMoreCharactersIfNoNextPage() throws {
        let delegate = MockCharacterListViewModelDelegate(testCase: self)
        delegate.charExpectation = expectation(description: "Characters Set")
        delegate.noMorePagesExpectation = expectation(description: "No More New Pages")
        delegate.charExpectation?.isInverted = true
        
        repo?.data = try setupCorrectData()
        viewModel?.delegate = delegate
        
        viewModel?.nextPage = nil
        viewModel?.loadMoreCharacters()
        
        waitForExpectations(timeout: 1)
    }
    
    func testgetCharactersByFilterNoInput() throws {
        let delegate = MockCharacterListViewModelDelegate(testCase: self)
        delegate.charExpectation = expectation(description: "Characters Set")
        delegate.charExpectation?.isInverted = true
        
        repo?.data = try setupCorrectData()
        viewModel?.delegate = delegate
        
        viewModel?.getCharactersByFilter(nil, nil, nil, nil)
        
        waitForExpectations(timeout: 1)
    }
    
    func testgetCharactersByFilterByName() throws {
        let delegate = MockCharacterListViewModelDelegate(testCase: self)
        delegate.charExpectation = expectation(description: "Characters Set")
        
        repo?.data = try setupCorrectData()
        viewModel?.delegate = delegate
        
        viewModel?.getCharactersByFilter("Name", nil, nil, nil)
        
        waitForExpectations(timeout: 1)
    }
    
    func testgetCharactersByFilterByStatus() throws {
        let delegate = MockCharacterListViewModelDelegate(testCase: self)
        delegate.charExpectation = expectation(description: "Characters Set")
        
        repo?.data = try setupCorrectData()
        viewModel?.delegate = delegate
        
        viewModel?.getCharactersByFilter(nil, "Status", nil, nil)
        
        waitForExpectations(timeout: 1)
    }
    
    func testgetCharactersByFilterBySpecies() throws {
        let delegate = MockCharacterListViewModelDelegate(testCase: self)
        delegate.charExpectation = expectation(description: "Characters Set")
        
        repo?.data = try setupCorrectData()
        viewModel?.delegate = delegate
        
        viewModel?.getCharactersByFilter(nil, nil, "Species", nil)
        
        waitForExpectations(timeout: 1)
    }
    
    func testgetCharactersByFilterByGender() throws {
        let delegate = MockCharacterListViewModelDelegate(testCase: self)
        delegate.charExpectation = expectation(description: "Characters Set")
        
        repo?.data = try setupCorrectData()
        viewModel?.delegate = delegate
        
        viewModel?.getCharactersByFilter(nil, nil, nil, "Gender")
        
        waitForExpectations(timeout: 1)
    }

    private func setupCorrectData() throws -> Data? {
        let filePath = Bundle(for: type(of: self)).path(forResource: "CharacterList", ofType: "json")!
        let contentString = try String(contentsOf: URL(fileURLWithPath: filePath))
        let data = contentString.data(using: .utf8)
        return data
    }

    private func setupWrongData() throws -> Data? {
        let contentString = "{Wrong Data}"
        let data = contentString.data(using: .utf8)
        return data
    }
}

class MockCharacterListViewModelDelegate: CharacterListViewModelDelegate {
    
    var charExpectation: XCTestExpectation?
    var errorExpectation : XCTestExpectation?
    var noMorePagesExpectation : XCTestExpectation?
    private let testCase: XCTestCase
    
    init(testCase: XCTestCase) {
        self.testCase = testCase
    }

    func charactersSet() {
        charExpectation?.fulfill()
    }
    
    func noMorePages() {
        noMorePagesExpectation?.fulfill()
    }
    
    func foundError(_ error: ApiError) {
        errorExpectation?.fulfill()
    }
}
