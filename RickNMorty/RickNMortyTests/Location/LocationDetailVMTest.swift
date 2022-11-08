import XCTest
@testable import RickNMorty

class LocationDetailVMTest: XCTestCase {
    
    var viewModel : LocationDetailViewModel?

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = LocationDetailViewModel(setupCorrectLocation())
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        viewModel = nil
    }
    
    func testCreatedDateReturnsLocal() throws {
        let date = viewModel!.createdDate
        let locationDate = viewModel!.location.created
        XCTAssert(date == UTCToLocal(locationDate))
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

    private func setupCorrectLocation() -> Location {
        let location = Location(id: 1, name: "Earth", type: "Planet", dimension: "Dimension C-137", residents: [
            "https://rickandmortyapi.com/api/character/1",
            "https://rickandmortyapi.com/api/character/2"
        ], url: "https://rickandmortyapi.com/api/location/1", created: Date.now)
        return location
    }

}
