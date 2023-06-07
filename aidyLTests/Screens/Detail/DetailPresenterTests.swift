//
//  DetailPresenterTests.swift
//  aidyLTests
//
//  Created by Romain Bousquet on 7/6/2023.
//

import XCTest

final class DetailPresenterTests: XCTestCase {
    var presenter: DetailPresenter!
    var display: DetailDisplayMock!
    
    override func setUp() {
        super.setUp()
        presenter = DetailPresenter()
        display = DetailDisplayMock()
        presenter.display = display
    }
    
    func testStart() throws {
        // when
        presenter.start(.mock())
        
        // then
        XCTAssertEqual(display.initialCounter, 1)
        guard let _ = display.initialViewModel else {
            XCTFail()
            return
        }
    }
    
    func testMapSnapshot() throws {
        // when
        presenter.mapSnapshot(UIImage())
        
        // then
        XCTAssertEqual(display.mapSnapshotCounter, 1)
        guard let _ = display.mapSnapshortViewModel else {
            XCTFail()
            return
        }
    }
}
