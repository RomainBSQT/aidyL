//
//  ListPresenterTests.swift
//  aidyLTests
//
//  Created by Romain Bousquet on 7/6/2023.
//

import XCTest

final class ListPresenterTests: XCTestCase {
    var presenter: ListPresenter!
    var display: ListDisplayMock!
    
    override func setUp() {
        super.setUp()
        presenter = ListPresenter()
        display = ListDisplayMock()
        presenter.display = display
    }
    
    func testStart() throws {
        // when
        presenter.start()
        
        // then
        XCTAssertEqual(display.initialCounter, 1)
        guard let _ = display.initialViewModel else {
            XCTFail()
            return
        }
    }
    
    func testPresentProfiles() throws {
        // when
        presenter.present([.mock(), .mock()])
        
        // then
        XCTAssertEqual(display.profilesCounter, 1)
        guard let viewModel = display.profilesViewModel else {
            XCTFail()
            return
        }
        XCTAssertEqual(viewModel.profiles.count, 2)
    }
    
    func testPresentError() throws {
        // when
        presenter.error(.connectivity)
        
        // then
        XCTAssertEqual(display.errorCounter, 1)
        guard let _ = display.errorViewModel else {
            XCTFail()
            return
        }
    }
    
    func testShowDetail() throws {
        // when
        presenter.showDetail(profile: .mock())
        
        // then
        XCTAssertEqual(display.detailCounter, 1)
        guard let _ = display.profileParameter else {
            XCTFail()
            return
        }
    }
}
