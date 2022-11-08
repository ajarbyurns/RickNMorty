import XCTest
@testable import RickNMorty

class LocationListVMTest: XCTestCase {

    var repo : MockLocationListRepo?
    var viewModel : LocationListViewModel?

    override func setUpWithError() throws {
        try super.setUpWithError()
        repo = MockLocationListRepo()
        viewModel = LocationListViewModel(repo!)
    }

    override func tearDownWithError() throws {
        repo = nil
        viewModel = nil
    }

    func testGetLocationsCorrectData() throws {
        let delegate = MockLocationListViewModelDelegate(testCase: self)
        delegate.locExpectation = expectation(description: "Locations Set")
        delegate.errorExpectation = expectation(description: "Error Found")
        delegate.errorExpectation?.isInverted = true
        
        repo?.data = try setupCorrectData()
        viewModel?.delegate = delegate
                
        viewModel?.getLocations()
        
        waitForExpectations(timeout: 1)
    }
    
    func testGetLocationsWrongData() throws {
        let delegate = MockLocationListViewModelDelegate(testCase: self)
        delegate.locExpectation = expectation(description: "Locations Set")
        delegate.locExpectation?.isInverted = true
        delegate.errorExpectation = expectation(description: "Error Found")
        
        repo?.data = try setupWrongData()
        viewModel?.delegate = delegate
                
        viewModel?.getLocations()
        
        waitForExpectations(timeout: 1)
    }
    
    
    func testgetLocationsByFilterNoInput() throws {
        let delegate = MockLocationListViewModelDelegate(testCase: self)
        delegate.locExpectation = expectation(description: "Locations Set")
        delegate.locExpectation?.isInverted = true
        
        repo?.data = try setupCorrectData()
        viewModel?.delegate = delegate
        
        viewModel?.getLocationsByFilter(nil, nil, nil)
        
        waitForExpectations(timeout: 1)
    }
    
    func testgetLocationsByFilterByName() throws {
        let delegate = MockLocationListViewModelDelegate(testCase: self)
        delegate.locExpectation = expectation(description: "Locations Set")
        
        repo?.data = try setupCorrectData()
        viewModel?.delegate = delegate
        
        viewModel?.getLocationsByFilter("Name", nil, nil)
        
        waitForExpectations(timeout: 1)
    }
    
    func testgetLocationsByFilterByType() throws {
        let delegate = MockLocationListViewModelDelegate(testCase: self)
        delegate.locExpectation = expectation(description: "Locations Set")
        
        repo?.data = try setupCorrectData()
        viewModel?.delegate = delegate
        
        viewModel?.getLocationsByFilter(nil, "Type", nil)
        
        waitForExpectations(timeout: 1)
    }
    
    func testgetLocationsByFilterByDimension() throws {
        let delegate = MockLocationListViewModelDelegate(testCase: self)
        delegate.locExpectation = expectation(description: "Locations Set")
        
        repo?.data = try setupCorrectData()
        viewModel?.delegate = delegate
        
        viewModel?.getLocationsByFilter(nil, nil, "Dimension")
        
        waitForExpectations(timeout: 1)
    }

    private func setupCorrectData() throws -> Data? {
        let filePath = Bundle(for: type(of: self)).path(forResource: "LocationList", ofType: "json")!
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

class MockLocationListViewModelDelegate: LocationListViewModelDelegate {
    
    var locExpectation: XCTestExpectation?
    var errorExpectation : XCTestExpectation?
    var noMorePagesExpectation : XCTestExpectation?
    private let testCase: XCTestCase
    
    init(testCase: XCTestCase) {
        self.testCase = testCase
    }

    func locationsSet() {
        locExpectation?.fulfill()
    }
    
    func noMorePages() {
        noMorePagesExpectation?.fulfill()
    }
    
    func foundError(_ error: ApiError) {
        errorExpectation?.fulfill()
    }
}
