//
//  NetworkMonitor.swift
//  NetworkMonitor
//
//  Created by Rafael Gonzalez on 25/04/25.
//

import Foundation
import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    private var queue = DispatchQueue(label: "NetworkMonitor")
    private(set) var isConnected: Bool = false
    private(set) var isExpensive: Bool = false
    private(set) var currentConnectionType : String = "Unknown"
    private var isMonitoringStarted : Bool = false
    
    private init() {}
    
    func startMonitoring() {
        //If already monitoring, exit
        guard !isMonitoringStarted else { return }
        
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied //Connected
            self.isExpensive = path.isExpensive
            self.currentConnectionType = self.connectionType(path: path)
            
            DispatchQueue.main.async {
                NotificationCenter.default.post(name:.networkStatusChanged, object: nil, userInfo:
                [
                    "isConnected" : self.isConnected,
                    "isExpensive" : self.isExpensive,
                    "connectionType" : self.currentConnectionType
                ]
                )
            }// Dispatch
        } //Handler
        
        monitor.start(queue: queue)
        isMonitoringStarted = true
    }
    
    func stopMonitoring() {
        guard isMonitoringStarted else { return }
        monitor.cancel()
        isMonitoringStarted = false
    }
    
    func connectionType(path: NWPath) -> String {
        if path.usesInterfaceType(.wifi) {
            return "WiFi"
        }
        else if path.usesInterfaceType(.cellular) {
            return "Cellular"
        }
        else {
            return "Unknown"
        }
    }
}
