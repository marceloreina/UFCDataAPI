//
//  ViewController.swift
//  UFCDataAPI
//
//  Created by Marcelo Reina on 01/14/2017.
//  Copyright (c) 2017 Marcelo Reina. All rights reserved.
//

import UIKit
import UFCDataAPI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UFCNewsService.getAllUFCEvents { (result) in
            switch result {
            case .success(let newsArray):
                print("News: \(newsArray)")
            case .failure(let error):
                print("News FAILED: \(error)")
            }
        }
        /*UFCEventService.getAllUFCEvents { (result) in
            switch result {
            case .success(let events):
                Logger.log(message: "Events: \(events)")
            case .failure(let error):
                Logger.log(message: "Error: \(error)")
            }
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

