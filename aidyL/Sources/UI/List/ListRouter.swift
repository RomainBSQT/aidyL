//
//  Router.swift
//  aidyL
//
//  Created by Romain Bousquet on 3/6/2023.
//

import Foundation
import UIKit

protocol ListRoutingLogic: AnyObject {
    func routeToDetail(profile: Profile)
}

final class ListRouter {
    weak var source: UIViewController?
}

extension ListRouter: ListRoutingLogic {
    func routeToDetail(profile: Profile) {
        let detailViewController = DetailViewController(profile: profile)
        source?.show(detailViewController, sender: source)
    }
}
