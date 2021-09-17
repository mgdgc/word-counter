//
//  AboutViewController.swift
//  word count
//
//  Created by Peter Choi on 2018. 9. 12..
//  Copyright © 2018년 RiDsoft. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var appNameView: UILabel!
    @IBOutlet weak var versionView: UILabel!
    
    @IBOutlet weak var buttonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        appNameView.text = NSLocalizedString("app_name", comment: "app_name")
        versionView.text = "v\(getVersion())"
        
        buttonView.layer.cornerRadius = 8
    }
    
    @IBAction func onCloseButtonClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onLicensesButtonClick(_ sender: UIButton) {
        let content = "...";
        
        let alert = UIAlertController(title: "Licenses", message: content, preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: NSLocalizedString("confirm", comment: "confirm"), style: .default, handler: nil)
        
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onThanksToButtonClick(_ sender: UIButton) {
        let content = "App icon design: T. Kim Sang-Hun";
        
        let alert = UIAlertController(title: "Thanks to...", message: content, preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: NSLocalizedString("confirm", comment: "confirm"), style: .default, handler: nil)
        
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    private func getVersion() -> String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        } else {
            return "1.0"
        }
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
