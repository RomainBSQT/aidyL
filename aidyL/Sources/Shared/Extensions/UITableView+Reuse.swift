//
//  UITableView+Reuse.swift
//  aidyL
//
//  Created by Romain Bousquet on 3/6/2023.
//

import UIKit

extension UITableView {
    func registerIdentifiable<T: UITableViewCell>(_: T.Type) where T: Identifiable {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }
    
    func dequeueReusable<T: UITableViewCell>(at indexPath: IndexPath) -> T where T: Identifiable {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}

