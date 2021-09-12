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
    
    override func layoutSubviews() {
        self.layer.cornerRadius = frame.size.height / 2
    }
    
    
    func showShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.06
        self.layer.shadowRadius = 4
        self.layer.masksToBounds = false
    }
}
