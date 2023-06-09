//
//  Router.swift
//  aidyL
//
//  Created by Romain Bousquet on 3/6/2023.
//

import Foundation
import UIKit

protocol ListRoutingLogic: AnyObject {
    func routeToDetail(profile: ProfileDisplay)
}

final class ListRouter {
    weak var source: UIViewController?
}

extension ListRouter: ListRoutingLogic {
    func routeToDetail(profile: ProfileDisplay) {
        let detailViewController = DetailViewController(profile: profile)
        source?.show(detailViewController, sender: source)
    }
}
