//
//  ListInteractorTests.swift
//  aidyLTests
//
//  Created by Romain Bousquet on 7/6/2023.
//

import XCTest
import Combine

final class ListInteractorTests: XCTestCase {
    var worker: RandomUserWorkerMock!
    var presenter: ListPresenterMock!
    var interactor: ListInteractor!
    
    override func setUp() {
        super.setUp()
        presenter = ListPresenterMock()
        worker = RandomUserWorkerMock()
        interactor = ListInteractor(presenter: presenter, worker: worker)
    }
    
    func testStart() throws {
      // when
        interactor.start()
        
        // then
        XCTAssertEqual(presenter.startCounter, 1)
    }
    
    func testLoadProfiles() throws {
        // given
        worker.fetchRandomUsersMockResult = Just([.mock(), .mock(), .mock()])
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
        
        // when
        interactor.loadProfiles()
        
        // then
        XCTAssertEqual(presenter.presentProfilesCounter, 1)
        guard let profiles = presenter.profilesParameter else {
            XCTFail()
            return
        }
        XCTAssertEqual(profiles.count, 3)
    }
    
    func testLoadFreshProfiles() throws {
        // given
        worker.fetchFreshRandomUsersMockResult = Just([.mock(), .mock(), .mock(), .mock(), .mock(), .mock()])
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
        
        // when
        interactor.freshLoadProfiles()
        
        // then
        XCTAssertEqual(presenter.presentProfilesCounter, 1)
        guard let profiles = presenter.profilesParameter else {
            XCTFail()
            return
        }
        XCTAssertEqual(profiles.count, 6)
    }
    
    func testSelectProfile() throws {
        // given
        worker.fetchFreshRandomUsersMockResult = Just([.mock(), .mock(), .mock(), .mock(), .mock(), .mock()])
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
        interactor.freshLoadProfiles()
        
        // when
        interactor.selectProfile(5)
        
        // then
        XCTAssertEqual(presenter.showDetailCounter, 1)
        guard let _ = presenter.profileParameter else {
            XCTFail()
            return
        }
    }
}
