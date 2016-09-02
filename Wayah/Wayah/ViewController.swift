//
//  ViewController.swift
//  Wayah
//
//  Created by Allison Moyer on 4/24/15.
//  Copyright (c) 2015 Allison Moyer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startGame: UIButton!
    @IBOutlet weak var howToPlay: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print(animated)
        print(self.startGame.center.x)
        self.startGame.center.x -= self.view.bounds.width
        print(self.startGame.frame.midX)
        //self.howToPlay.center.x += self.view.bounds.width
        self.navigationController?.navigationBarHidden = true
    }
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        UIView.animateWithDuration(0.5, animations: {
//            self.startGame.center.x += self.view.bounds.width
//        })
//        
//        UIView.animateWithDuration(0.5, delay: 0.3, options: nil, animations: {
//            self.howToPlay.center.x -= self.view.bounds.width
//        }, completion: nil)
//        
//    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

