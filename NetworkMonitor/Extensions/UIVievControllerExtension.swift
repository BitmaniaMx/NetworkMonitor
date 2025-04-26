//
//  UIVievControllerExtension.swift
//  NetworkMonitor
//
//  Created by Rafael Gonzalez on 25/04/25.
//

import UIKit
import Foundation

extension UIViewController {
    
    //Created computed properties
    
    var isConnected : Bool {
        return NetworkMonitor.shared.isConnected
    }
    
    var isExpensive : Bool {
        return NetworkMonitor.shared.isExpensive
    }
    
    var connectionType : String {
        return NetworkMonitor.shared.currentConnectionType
    }

    //Suscribe to network change notification
    func observeConnectionChanges(selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: .networkStatusChanged, object: nil)
    }
    
    func removeConnectionChangesObserver() {
        NotificationCenter.default.removeObserver(self, name: .networkStatusChanged, object: nil)
    }
}
