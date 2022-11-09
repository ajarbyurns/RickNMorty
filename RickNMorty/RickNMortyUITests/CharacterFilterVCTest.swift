import XCTest

class CharacterFilterVCTest: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        XCUIDevice.shared.orientation = .portrait
        continueAfterFailure = false
        app.launch()
        app.navigationBars.element.buttons.firstMatch.tap()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testApplyButton() throws {
        app.buttons["Apply"].tap()
    }
    
    func testDragDown() throws {
        app.staticTexts["Filter"].swipeDown()
    }
    
    func testFilterTap() throws {
        app.collectionViews.firstMatch.cells.element(boundBy: 0).tap()
        app.collectionViews.firstMatch.cells.element(boundBy: 3).tap()
        app.collectionViews.firstMatch.cells.element(boundBy: 7).tap()        
    }

}
