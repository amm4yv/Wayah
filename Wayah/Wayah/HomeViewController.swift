//
//  ViewController.swift
//  Wayah
//
//  Created by Allison Moyer on 4/24/15.
//  Copyright (c) 2015 Allison Moyer. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var wayahLogo: UILabel!
    @IBOutlet weak var startGame: UIButton!
    @IBOutlet weak var howToPlay: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        startGame.addTarget(self, action: #selector(HomeViewController.startNewGame(_:)), for: .touchUpInside)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
    
    func startNewGame(_ sender: Any) {
        DataService.deleteAllEntities()
        
        let inputViewController = InputViewController(nibName: nil, bundle: nil)
        navigationController?.pushViewController(inputViewController, animated: true)
    }
    
}

