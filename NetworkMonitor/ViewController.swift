//
//  ViewController.swift
//  NetworkMonitor
//
//  Created by Rafael Gonzalez on 15/04/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var connectionStatusValue: UILabel!
    
    @IBOutlet weak var connectionTypeValue: UILabel!
    
    @IBOutlet weak var connectionIsExpensiveValue: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        observeConnectionChanges(selector: #selector(connectionChanged))
    }
    
    @objc func connectionChanged() {
        self.connectionStatusValue.text = self.isConnected ? "Connected" : "Not Connected"
        self.connectionStatusValue.textColor = self.isConnected ? .green : .red
        
        self.connectionIsExpensiveValue.text = self.isExpensive ? "Expensive" : "Not so expensive"
        self.connectionIsExpensiveValue.textColor = self.isExpensive ? .green : .red
        
        self.connectionTypeValue.text = self.connectionType
    }
}

