//
//  TurnReviewDetailViewController.swift
//  Wayah
//
//  Created by Allison Moyer on 9/5/16.
//  Copyright © 2016 Allison Moyer. All rights reserved.
//

import UIKit

class TurnReviewDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, RoundReviewCollectionCellDelegate {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var roundTitle: UILabel!
    @IBOutlet var teamTurnTitle: UILabel!
    
    fileprivate let reuseIdentifier = "ReviewCell"

    fileprivate let gameStateMachine = GameStateMachine.sharedInstance
    fileprivate var turnStateMachine: TurnStateMachine {
        return gameStateMachine.currentRoundStateMachine!.turnStateMachine!
    }

    fileprivate var correctEntries: [Entry] {
        return turnStateMachine.correctEntries
    }
    
    fileprivate var skippedEntries: [Entry] {
        return turnStateMachine.skippedEntries
    }
    
    @IBAction func save(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "RoundReviewCollectionCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? correctEntries.count : skippedEntries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RoundReviewCollectionCell
        
        switch indexPath.section {
        case 0:
            let entry = correctEntries[indexPath.row]
            cell.configureWithEntry(entry)
            break
        case 1:
            let entry = skippedEntries[indexPath.row]
            cell.configureWithEntry(entry, skipped: true)
            break
        default:
            break
        }
        
        cell.delegate = self
        
        return cell
    }
    
    func cellDidToggle(cell: RoundReviewCollectionCell) {
        guard let entry = cell.entry else { return }
        turnStateMachine.toggleEntryState(entry)
    }
    
//    func cellDidSelectDelete(cell: RoundReviewCollectionCell) {
//        guard let entry = cell.entry, let indexPath = collectionView.indexPath(for: cell) else { return }
//        roundStateMachine.setEntryAsUnguessed(entry)
//        collectionView.deleteItems(at: [indexPath])
//    }
}

protocol RoundReviewCollectionCellDelegate {
    func cellDidToggle(cell: RoundReviewCollectionCell)
//    func cellDidSelectDelete(cell: RoundReviewCollectionCell)
}

class RoundReviewCollectionCell: UICollectionViewCell {
    
    var entry: Entry? = nil
    var delegate: RoundReviewCollectionCellDelegate? = nil
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var correctButton: UIButton!
    @IBOutlet var skippedButton: UIButton!
    
//    @IBAction func deleteCell(_ sender: Any) {
//        delegate?.cellDidSelectDelete(cell: self)
//    }
    
    @IBAction func correctSelected(_ sender: Any) {
        styleUnselected(button: skippedButton)
        styleSelected(button: correctButton)
        delegate?.cellDidToggle(cell: self)
    }
    
    @IBAction func skipSelected(_ sender: Any) {
        styleUnselected(button: correctButton)
        styleSelected(button: skippedButton)
        delegate?.cellDidToggle(cell: self)
    }
    
    func configureWithEntry(_ entry: Entry, skipped: Bool = false) {
        self.entry = entry
        
        if skipped {
            styleUnselected(button: correctButton)
            styleSelected(button: skippedButton)
        } else {
            styleUnselected(button: skippedButton)
            styleSelected(button: correctButton)
        }

        nameLabel.text = entry.name
    }
    
    func styleUnselected(button: UIButton) {
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.gray.cgColor
        button.backgroundColor = UIColor.clear
    }
    
    func styleSelected(button: UIButton) {
        button.layer.borderWidth = 0
        button.layer.borderColor = nil
        button.backgroundColor = UIColor.gray
    }
    
}
