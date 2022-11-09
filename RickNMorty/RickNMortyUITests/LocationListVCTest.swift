import XCTest

class LocationListVCTest: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        XCUIDevice.shared.orientation = .portrait
        continueAfterFailure = false
        app.launch()
        app.tabBars.buttons.element(boundBy: 1).tap()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testClickLocation() throws {
        let firstElement = app.tables.element(boundBy: 0).cells.element(boundBy: 0)
        if firstElement.waitForExistence(timeout: 5) {
            firstElement.tap()
        }
    }
    
    func testTabBar() throws {
        app.tabBars.buttons.element(boundBy: 2).tap()
        app.tabBars.buttons.element(boundBy: 0).tap()
        app.tabBars.buttons.element(boundBy: 1).tap()
    }

}
