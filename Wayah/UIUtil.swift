//
//  UIUtil.swift
//  Wayah
//
//  Created by Allison Moyer on 3/13/17.
//  Copyright © 2017 Allison Moyer. All rights reserved.
//

import Foundation
import UIKit

class UIUtil {
    
    static func textWithStroke(text: String, color: UIColor, width: Double = 1.0) -> NSAttributedString {
        let strokeAttributes = [ NSStrokeColorAttributeName : color, NSStrokeWidthAttributeName : width ] as [String : Any]
        let range = NSRange(location: 0, length: text.characters.count)
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes(strokeAttributes, range: range)
        
        return attributedString
    }
    
    
}
