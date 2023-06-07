//
//  ListInteractorTests.swift
//  aidyLTests
//
//  Created by Romain Bousquet on 7/6/2023.
//

import XCTest
import Combine

final class DetailInteractorTests: XCTestCase {
    var presenter: DetailPresenterMock!
    var interactor: DetailInteractor!
    
    override func setUp() {
        super.setUp()
        presenter = DetailPresenterMock()
        interactor = DetailInteractor(profile: .mock(), presenter: presenter)
    }
    
    func testStart() throws {
        // given
        let expectation = expectation(description: "Loading map snapshot")
        presenter.mapSnapshotCompletion = { expectation.fulfill() }
        
        // when
        interactor.start()
        
        // then
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(presenter.startCounter, 1)
        guard let _ = presenter.profileParameter else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(presenter.mapSnapshotCounter, 1)
        guard let _ = presenter.imageParameter else {
            XCTFail()
            return
        }
    }
}
