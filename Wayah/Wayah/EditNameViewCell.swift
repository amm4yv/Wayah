//
//  EditNameViewCell.swift
//  Wayah
//
//  Created by Allison Moyer on 9/1/15.
//  Copyright (c) 2015 Allison Moyer. All rights reserved.
//

import UIKit

class EditNameViewCell: UITableViewCell {
    
    let label: UILabel
    let leftMarginForLabel: CGFloat = 15.0

    
    func configureWithEntry(_ entry: Entry) {
        label.text = entry.name
        selectionStyle = UITableViewCellSelectionStyle.none
        isUserInteractionEnabled = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
//
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        label.delegate = self
//        label.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        self.selectionStyle = .none
        addSubview(label)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: leftMarginForLabel, y: 0, width: bounds.size.width - leftMarginForLabel, height: bounds.size.height)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
//    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return false
//    }
//    
//    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
//        if listItems != nil {
//            listItems?.text = textField.text!
//        }
//        return true
//    }
    
    func loadImage(_ image: UIImage) {
        //barImageView.userInteractionEnabled = true
        
    }
    
}
