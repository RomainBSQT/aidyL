//
//  DetailViewController.swift
//  aidyL
//
//  Created by Romain Bousquet on 3/6/2023.
//

import UIKit

final class DetailViewController: UIViewController {
    init(profile: Profile) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
}

