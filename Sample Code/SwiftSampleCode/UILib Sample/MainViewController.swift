//
//  MainViewController.swift
//  DJIUILibrary
//
//  Created by Arnaud Thiercelin on 12/12/16.
//  Copyright © 2016 DJI. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var version: UILabel!
    @IBOutlet weak var registered: UILabel!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var connected: UILabel!
    @IBOutlet weak var connect: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(productCommunicationDidChange), name: Notification.Name(rawValue: ProductCommunicationManagerStateDidChange), object: nil)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        if version == nil {
            version = "N/A"
        }
        
        self.version.text = "Version \(version!)"
    }

    @IBAction func registerAction() {
        self.appDelegate.productCommManager.registerWithProduct()
    }
    
    @IBAction func connectAction() {
        self.appDelegate.productCommManager.connectToProduct()
    }
    
    func productCommunicationDidChange() {
        if self.appDelegate.productCommManager.registered {
            self.registered.text = "YES"
            self.register.isHidden = true
        } else {
            self.registered.text = "NO"
            self.register.isHidden = false
        }
        
        if self.appDelegate.productCommManager.connected {
            self.connected.text = "YES"
            self.connect.isHidden = true
        } else {
            self.connected.text = "NO"
            self.connect.isHidden = false
        }
    }
}
