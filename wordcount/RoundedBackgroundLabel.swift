//
//  RoundedBackgroundLabel.swift
//  word count
//
//  Created by Peter Choi on 2018. 9. 11..
//  Copyright © 2018년 RiDsoft. All rights reserved.
//

import Foundation
import UIKit

class RoundedBackgroundLabel : UILabel {
    
    @IBInspectable var topInset: CGFloat = 8.0
    @IBInspectable var bottomInset: CGFloat = 8.0
    @IBInspectable var leftInset: CGFloat = 16.0
    @IBInspectable var rightInset: CGFloat = 16.0
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).cgColor
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
//        super.drawText(in: rect.inset(by: insets))
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
