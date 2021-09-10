//
//  OptionsViewController.swift
//  word count
//
//  Created by Peter Choi on 2018. 9. 11..
//  Copyright © 2018년 RiDsoft. All rights reserved.
//

protocol OptionsDelegate {
    func onOptionsChanged()
}

import UIKit

class OptionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let segGuide = "segGuide"
    
    private var data: [OptionsTableObject] = [
        // Display Options
        OptionsTableObject(title: NSLocalizedString("divider_display", comment: "divider_display")),
        OptionsTableObject(id: "option_display", title: NSLocalizedString("option_display", comment: "option_display"), detail: "", type: OptionsTableObject.OptionsTableCellType.Disclosure),
        
        // Count options
        OptionsTableObject(title: NSLocalizedString("divider_count", comment: "divider_count")),
        OptionsTableObject(id: "option_space", title: NSLocalizedString("option_space", comment: "option_space"), detail: "", type: OptionsTableObject.OptionsTableCellType.Disclosure),
        OptionsTableObject(id: "option_symbols", title: NSLocalizedString("option_symbols", comment: "option_symbols"), detail: "", type: OptionsTableObject.OptionsTableCellType.Switch),
        OptionsTableObject(id: "option_symbols_custom", title: NSLocalizedString("option_symbols_custom", comment: "option_symbols"), detail: "", type: OptionsTableObject.OptionsTableCellType.Disclosure)
    ]

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var finishButton: FloatingFinishButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 54
        tableView.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        
        let rect = CGRect(x: 0, y: 0, width: 0, height: 100)
        let footerView = UIView(frame: rect)
        tableView.tableFooterView = footerView
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func onFinishButtonClick(_ sender: FloatingMoreButton) {
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: data.type.rawValue)
        
        if data.type == .Disclosure {
            let cell = cell as! OptionsTableCell
            
            cell.titleView.text = data.title
            cell.detailView.text = data.detail
            
            cell.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            cell.backgroundView?.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1)
            cell.selectedBackgroundView = backgroundView
            
            if !data.disclosure {
                cell.accessoryType = .none
            }
            
            return cell
        } else if data.type == .Switch {
            let cell = cell as! SwitchCell
            
            cell.titleView.text = data.title
            cell.switch.isOn = data.isOn
            
            cell.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            cell.backgroundView?.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1)
            cell.selectedBackgroundView = backgroundView
            
            return cell
        } else {
            let cell = cell as! DividerCell
            
            cell.titleView.text = data.title
            
            cell.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            cell.backgroundView?.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            
            return cell
        }
    }
    
    @IBAction func OnSwitchValueChanged(_ sender: UISwitch) {
        guard let position = tableView.indexPathForSelectedRow?.row else {
            return
        }
        let id = data[position].id
        
        if id == "options_default" {
//            optionsObject.setAsDefault = true
        }
        // do something with selected row's id value
    }
    
    func prepareBackgroundView() {
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffect = UIVisualEffectView(effect: blurEffect)
        let bluredView = UIVisualEffectView(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        
        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        
        view.insertSubview(bluredView, at: 0)
    }

}

class FloatingFinishButton : UIButton {
    public static let PADDING_TOP: CGFloat = 6.0
    public static let PADDING_BOTTOM: CGFloat = 6.0
    public static let PADDING_LEFT: CGFloat = 10.0
    public static let PADDING_RIGHT: CGFloat = 10.0
    
    override func draw(_ rect: CGRect) {
        self.layer.backgroundColor = ColorManager.colorAccent.cgColor
        self.layer.cornerRadius = frame.size.height / 2
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        
        let insets = UIEdgeInsets(top: FloatingMoreButton.PADDING_TOP, left: FloatingMoreButton.PADDING_LEFT, bottom: FloatingMoreButton.PADDING_BOTTOM, right: FloatingMoreButton.PADDING_RIGHT)
        
        self.imageEdgeInsets = insets
    }
}

class OptionsTableCell : UITableViewCell {
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var detailView: UILabel!
}

class SwitchCell : UITableViewCell {
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
}

class DividerCell : UITableViewCell {
    @IBOutlet weak var titleView: UILabel!
}


class OptionsTableObject {
    enum OptionsTableCellType: String {
        case Disclosure = "OptionsCell"
        case Switch = "SwitchCell"
        case Divider = "DividerCell"
    }
    var id: String = ""
    var title: String = ""
    var detail: String = ""
    var isOn: Bool = false
    var type: OptionsTableCellType = .Disclosure
    var disclosure = true
    init(title: String) {
        self.title = title
        self.type = .Divider
    }
    init(id: String, title: String) {
        self.id = id
        self.title = title
    }
    convenience init(id: String, title: String, detail: String) {
        self.init(id: id, title: title)
        self.detail = detail
    }
    convenience init(id: String, title: String, detail: String, type: OptionsTableCellType) {
        self.init(id: id, title: title, detail: detail)
        self.type = type
    }
    convenience init(id: String, title: String, isOn: Bool) {
        self.init(id: id, title: title)
        self.isOn = isOn
        self.type = .Switch
    }
}
