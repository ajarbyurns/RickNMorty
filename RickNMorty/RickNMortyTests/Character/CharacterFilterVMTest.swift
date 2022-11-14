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

    func testRowSameLengthAsStates() throws {
        XCTAssert(viewModel?.rows.count == viewModel?.states.count)
        for i in viewModel!.rows.indices {
            XCTAssert(viewModel?.rows[i].count == viewModel?.states[i].count)
        }
    }
    
    func testSelectAt() throws {
        for i in viewModel!.sections.indices {
            for j in viewModel!.rows.indices {
                viewModel!.selectAt(i, j)
                XCTAssert(viewModel!.selected[viewModel!.sections[i]] == viewModel!.rows[i][j])
            }
        }
    }
    
    func testDeSelectAt() throws {
        for i in viewModel!.sections.indices {
            for j in viewModel!.rows.indices {
                viewModel!.deSelectAt(i, j)
                XCTAssert(viewModel!.selected[viewModel!.sections[i]] == nil)
            }
        }
    }

}
