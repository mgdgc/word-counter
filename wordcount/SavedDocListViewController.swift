//
//  SavedDocListViewController.swift
//  wordcount
//
//  Created by Peter Choi on 05/10/2018.
//  Copyright © 2018 RiDsoft. All rights reserved.
//

import UIKit

protocol OnSavedItemSelectedListener {
    func onSavedItemSelected(id: String);
}

class SavedDocListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let dataManager = DataManager()
    private var data: [SavedDocObject] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        tableView.rowHeight = 62
        tableView.tableFooterView = footerView
        
        initData()
        
        performSegue(withIdentifier: "segCounter", sender: nil)
    }
    
    // MARK:  - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else {
            return data.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return nil
        } else {
            return NSLocalizedString("section_saved_documents", comment: "")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewCounterCell")
            
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SavedListCell")
            
            let content = data[indexPath.row].content
            cell?.textLabel?.text = content
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section > 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            if editingStyle == .delete {
                if !self.dataManager.removeDocument(doc: data[indexPath.row]) {
                    let alert = UIAlertController(title: "Failed", message: "Failed", preferredStyle: .alert)
                    let confirm = UIAlertAction(title: NSLocalizedString("confirm", comment: "confirm"), style: .default) { (action) in
                        
                    }
                    alert.addAction(confirm)
                    present(alert, animated: true, completion: nil)
                }
                self.data.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            performSegue(withIdentifier: "segCounter", sender: nil)
        } else {
            
        }
    }
    
    // MARK: - Button click listeners
    
    @IBAction func onAllClearClick(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: NSLocalizedString("clear", comment: "clear"), message: NSLocalizedString("alert_clear_all_doc", comment: "alert_clear_all_doc"), preferredStyle: .actionSheet)
        let confirm = UIAlertAction(title: NSLocalizedString("confirm", comment: "confirm"), style: .destructive) { (action) in
            let manager = DataManager()
            manager.removeAll()
        }
        let cancel = UIAlertAction(title: NSLocalizedString("cancel", comment: "cancel"), style: .cancel, handler: nil)
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        setActionSheet(alert, barButton: sender)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    private func setActionSheet(_ alert: UIAlertController, barButton: UIBarButtonItem?) {
        if let barButton = barButton {
            if let popoverController = alert.popoverPresentationController {
                popoverController.barButtonItem = barButton
            }
        } else {
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
        }
    }
    
    private func initData() {
        data = dataManager.getSavedDocuments()
        tableView.reloadData()
    }
    
}
