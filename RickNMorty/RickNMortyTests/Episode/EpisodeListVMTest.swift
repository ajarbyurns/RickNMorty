import XCTest
@testable import RickNMorty

class EpisodeListVMTest: XCTestCase {

    var repo : MockEpisodeListRepo?
    var viewModel : EpisodeListViewModel?

    override func setUpWithError() throws {
        try super.setUpWithError()
        repo = MockEpisodeListRepo()
        viewModel = EpisodeListViewModel(repo!)
    }

    override func tearDownWithError() throws {
        repo = nil
        viewModel = nil
    }

    func testGetEpisodesCorrectData() throws {
        let delegate = MockEpisodeListViewModelDelegate(testCase: self)
        delegate.epiExpectation = expectation(description: "Episodes Set")
        delegate.errorExpectation = expectation(description: "Error Found")
        delegate.errorExpectation?.isInverted = true
        
        repo?.data = try setupCorrectData()
        viewModel?.delegate = delegate
                
        viewModel?.getEpisodes()
        
        waitForExpectations(timeout: 1)
    }
    
    func testGetEpisodesWrongData() throws {
        let delegate = MockEpisodeListViewModelDelegate(testCase: self)
        delegate.epiExpectation = expectation(description: "Episodes Set")
        delegate.epiExpectation?.isInverted = true
        delegate.errorExpectation = expectation(description: "Error Found")
        
        repo?.data = try setupWrongData()
        viewModel?.delegate = delegate
                
        viewModel?.getEpisodes()
        
        waitForExpectations(timeout: 1)
    }
    
    
    func testgetEpisodesByFilterNoInput() throws {
        let delegate = MockEpisodeListViewModelDelegate(testCase: self)
        delegate.epiExpectation = expectation(description: "Episodes Set")
        delegate.epiExpectation?.isInverted = true
        
        repo?.data = try setupCorrectData()
        viewModel?.delegate = delegate
        
        viewModel?.getEpisodesByFilter(nil, episode: nil)
        
        waitForExpectations(timeout: 1)
    }
    
    func testgetLocationsByFilterByName() throws {
        let delegate = MockEpisodeListViewModelDelegate(testCase: self)
        delegate.epiExpectation = expectation(description: "Episodes Set")
        
        repo?.data = try setupCorrectData()
        viewModel?.delegate = delegate
        
        viewModel?.getEpisodesByFilter("Name", episode: nil)
        
        waitForExpectations(timeout: 1)
    }
    

    private func setupCorrectData() throws -> Data? {
        let filePath = Bundle(for: type(of: self)).path(forResource: "EpisodeList", ofType: "json")!
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

class MockEpisodeListViewModelDelegate: EpisodeListViewModelDelegate {
    
    var epiExpectation: XCTestExpectation?
    var errorExpectation : XCTestExpectation?
    var noMorePagesExpectation : XCTestExpectation?
    private let testCase: XCTestCase
    
    init(testCase: XCTestCase) {
        self.testCase = testCase
    }

    func episodesSet() {
        epiExpectation?.fulfill()
    }
    
    func noMorePages() {
        noMorePagesExpectation?.fulfill()
    }
    
    func foundError(_ error: ApiError) {
        errorExpectation?.fulfill()
    }
}
