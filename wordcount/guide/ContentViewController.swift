//
//  ContentViewController.swift
//  wordcount
//
//  Created by Peter Choi on 03/10/2018.
//  Copyright © 2018 RiDsoft. All rights reserved.
//

import UIKit

protocol GuideFinishedListener {
    func onGuideFinished()
}

class ContentViewController: UIViewController {
    
    private var onGuideFinishedListener: GuideFinishedListener?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
