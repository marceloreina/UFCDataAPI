//
//  MenuTableViewController.swift
//  UFCDataAPI
//
//  Created by Marcelo Reina on 16/01/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

enum MenuOption: Int {
    case events = 0
    
    static var count: Int {
        return 1
    }
}

extension MenuOption {
    func segueId() -> String {
        switch self {
        case .events:
            return "ShowEvents"
        }
    }
}

class MenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOption.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let option = MenuOption(rawValue: indexPath.row) {
            switch option {
            case .events:
                performSegue(withIdentifier: option.segueId(), sender: option)
            }
        }
    }

}
