import XCTest

class CharacterListVCTest: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        XCUIDevice.shared.orientation = .portrait
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testClickFilter() throws {
        app.navigationBars.element.buttons.firstMatch.tap()
    }

    func testTabBar() throws {
        app.tabBars.buttons.element(boundBy: 1).tap()
        app.tabBars.buttons.element(boundBy: 2).tap()
        app.tabBars.buttons.element(boundBy: 0).tap()
    }
    
    func testClickCharacter() throws {
        let firstElement = app.collectionViews.element.firstMatch.cells.firstMatch
        if firstElement.waitForExistence(timeout: 5) {
            firstElement.tap()
        }
    }
    
    func testSearchText() throws {
        app.textFields.element.tap()
        app.textFields.element.typeText("Rick\n")

    }
}
