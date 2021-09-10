//
//  SymbolsToExcludeViewController.swift
//  wordcount
//
//  Created by Peter Choi on 11/01/2019.
//  Copyright © 2019 RiDsoft. All rights reserved.
//

import UIKit

protocol SymbolsToExcludeDelegate {
    func onConfirmButtonClick()
}

class SymbolsToExcludeViewController: UIViewController {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var contentView: UILabel!
    @IBOutlet weak var textfield: UITextField!
    
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
