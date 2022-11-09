import XCTest

class CharacterDetailVCTest: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        XCUIDevice.shared.orientation = .portrait
        continueAfterFailure = false
        app.launch()
        let firstElement = app.collectionViews.element.firstMatch.cells.firstMatch
        if firstElement.waitForExistence(timeout: 5) {
            app.collectionViews.element.firstMatch.cells.firstMatch.tap()
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBackButton() throws {
        app.navigationBars.element.buttons.firstMatch.tap()
    }
    
    func testNoTabBar() throws {
        XCTAssert(!app.tabBars.element.exists)
    }

}
