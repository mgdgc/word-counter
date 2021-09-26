//
//  SettingsViewController.swift
//  wordcount
//
//  Created by Peter Choi on 2021/09/26.
//  Copyright © 2021 RiDsoft. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

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

class SettingsSwitchCell : UITableViewCell {
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var switchView: UISwitch!
    
    
    
    @IBAction func onSwitchChanged(_ sender: UISwitch) {
    }
    
}
