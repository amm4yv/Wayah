//
//  InfoViewController.swift
//  Wayah
//
//  Created by Allison Moyer on 5/5/15.
//  Copyright (c) 2015 Allison Moyer. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var roundNumberLabel: UILabel!
    @IBOutlet weak var roundTitle: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet var newRoundNumberLabel: UILabel!
    @IBOutlet var newRoundTitle: UILabel!
   
    fileprivate let gameStateMachine = GameStateMachine.sharedInstance

    override func viewWillAppear(_ animated: Bool) {
        let currentRound = gameStateMachine.currentRound
        roundNumberLabel.text = "Round \(currentRound.id)"
        roundTitle.text = currentRound.title
        infoLabel.text = currentRound.description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func unwindToInfoViewController(segue: UIStoryboardSegue) {
        
    }
    
    @IBOutlet var scoreboardBanner: UIImageView!

}

class RearrangeSegue: UIStoryboardSegue {
    
    override func perform() {
        // Assign the source and destination views to local variables.
        guard let infoViewController = self.source as? InfoViewController else {
            self.source.present(self.destination as UIViewController,
                                animated: false,
                                completion: nil)
            return
        }
        
        // Animate the transition.
//        infoViewController.roundNumberLabel.animateToMatchLabel(infoViewController.newRoundNumberLabel, withDuration: 2)
        
        UIView.animate(withDuration: 3.0, animations: {
//            infoViewController.infoLabel.alpha = 0.0
//            infoViewController.button.alpha = 0.0
//            
//            infoViewController.roundNumberLabel.frame = infoViewController.newRoundNumberLabel.frame
//            let scale = infoViewController.newRoundNumberLabel.font.pointSize / infoViewController.roundNumberLabel.font.pointSize
//            infoViewController.roundNumberLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
//            
//            do {
//                let tx = infoViewController.newRoundNumberLabel.frame.origin.x - infoViewController.roundNumberLabel.frame.origin.x
//                let ty = infoViewController.newRoundNumberLabel.frame.origin.y - infoViewController.roundNumberLabel.frame.origin.y
//                infoViewController.roundNumberLabel.transform = CGAffineTransform(translationX: tx, y: ty)
//            }
//
//            //            infoViewController.roundTitle.font = infoViewController.newRoundNumberLabel.font
//            do {
//                let tx = infoViewController.newRoundTitle.frame.origin.x - infoViewController.roundTitle.frame.origin.x
//                let ty = infoViewController.newRoundTitle.frame.origin.y - infoViewController.roundTitle.frame.origin.y
//                infoViewController.roundTitle.transform = CGAffineTransform(translationX: tx, y: ty)
//            }

        }) { (complete: Bool) in
            if complete {
                self.source.present(self.destination as UIViewController,
                                    animated: false,
                                    completion: nil)
            }
        }
        
    }
}

extension UILabel {
    func animateToMatchLabel(_ label: UILabel, withDuration duration: TimeInterval) {
        let oldFont = self.font
//        let oldOrigin = frame.origin
        let labelScale = oldFont!.pointSize / label.font.pointSize
        let oldTransform = transform
        transform = self.transform.scaledBy(x: labelScale, y: labelScale)
//        let newOrigin = frame.origin
//        frame.origin = oldOrigin
        setNeedsUpdateConstraints()
        UIView.animate(withDuration: duration) {
            self.sizeToFit()
            self.frame.origin = label.frame.origin
            self.transform = oldTransform
            self.font = label.font
//            self.frame = label.frame
        }
    }
}
