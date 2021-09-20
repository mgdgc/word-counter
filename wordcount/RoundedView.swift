//
//  RoundedBackgroundLabel.swift
//  word count
//
//  Created by Peter Choi on 2018. 9. 11..
//  Copyright © 2018년 RiDsoft. All rights reserved.
//

import Foundation
import UIKit

class RoundedView : UIView {
    
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = frame.size.height / 2
    }
    
    
    func showShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 6)
        self.layer.shadowOpacity = 0.08
        self.layer.shadowRadius = 12
        self.layer.masksToBounds = false
    }
}
