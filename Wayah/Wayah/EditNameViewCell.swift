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
    
    var listItems:BowlItem? {
        didSet {
            label.text = listItems!.text
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        label = UILabel()
        label.textColor = UIColor.blackColor()
        label.font = UIFont.systemFontOfSize(16)
//
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        label.delegate = self
//        label.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        self.selectionStyle = .None
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
    
    override func setSelected(selected: Bool, animated: Bool) {
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
    
    func loadImage(image: UIImage) {
        //barImageView.userInteractionEnabled = true
        
    }
    
}
