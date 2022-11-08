import XCTest
@testable import RickNMorty

class CharacterFilterVMTest: XCTestCase {
    
    var viewModel : CharacterFilterViewModel?

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = CharacterFilterViewModel()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        viewModel = nil
    }

    func testSelectedSameLengthAsSections() throws {
        XCTAssert(viewModel?.selected.count == viewModel?.sections.count)
    }
    
    func testSelectAt() throws {
        for i in viewModel!.sections.indices {
            for j in viewModel!.rows.indices {
                viewModel!.selectAt(i, j)
                XCTAssert(viewModel!.selected[i] == viewModel!.rows[i][j])
            }
        }
    }
    
    func testDeSelectAt() throws {
        for i in viewModel!.sections.indices {
            for j in viewModel!.rows.indices {
                viewModel!.deSelectAt(i, j)
                XCTAssert(viewModel!.selected[i] == nil)
            }
        }
    }

}
