//
//  DetailInteractor.swift
//  aidyL
//
//  Created by Romain Bousquet on 5/6/2023.
//

import Foundation
import MapKit

protocol DetailInteractorLogic {
    func start()
}

final class DetailInteractor: DetailInteractorLogic {
    // MARK: - Injected
    private let profile: ProfileDisplay
    private let presenter: DetailPresenterLogic
    
    init(profile: ProfileDisplay, presenter: DetailPresenterLogic) {
        self.profile = profile
        self.presenter = presenter
    }
    
    // MARK: - DetailInteractorLogic conformance
    func start() {
        presenter.start(profile)
        loadMapSnapshot()
    }
}

private extension DetailInteractor {
    func loadMapSnapshot() {
        guard
            let latitude = CLLocationDegrees(profile.profile.location.coordinates.latitude),
            let longitude = CLLocationDegrees(profile.profile.location.coordinates.longitude)
        else { return }
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        guard CLLocationCoordinate2DIsValid(coordinates) else { return }
        
        let options = MKMapSnapshotter.Options()
        options.region = MKCoordinateRegion(
            center: coordinates,
            latitudinalMeters: 100,
            longitudinalMeters: 100
        )
        options.size = CGSize(width: 100, height: 100)
        options.mapType = .standard
        options.showsBuildings = true
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { [weak self] snapshot, _ in
            guard let snapshot = snapshot else { return }
            self?.presenter.mapSnapshot(snapshot.image)
        }
    }
}
