//
//  DownloadsViewController.swift
//  netflix-clone
//
//  Created by Alpsu Dilbilir on 6.09.2022.
//

import UIKit

class ListsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lists"
        view.backgroundColor = .secondarySystemBackground
        PersistenceService.getMovies(type: .watchlist) { result in 
            print(result)
        }
    }
}
