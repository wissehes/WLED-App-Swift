//
//  DeviceManager.swift
//  DeviceManager
//
//  Created by Wisse Hes on 12/08/2021.
//

import Foundation

class DeviceManager: ObservableObject {
    @Published var devices: [Device] = []
    
    init() {
        self.devices = DeviceManager.getDevices()
    }
    
    static func getDevices() -> [Device] {
        if let data = UserDefaults.standard.data(forKey: "devices") {
            if let decoded = try? JSONDecoder().decode([Device].self, from: data) {
                return decoded
            }
        }
        return []
    }
    
    static func add(device: Device) {
        var savedDevices = getDevices()
        savedDevices.append(device)
        self.save(savedDevices)
    }
    
    static func save(_ devices: [Device]) {
        if let encoded = try? JSONEncoder().encode(devices) {
            UserDefaults.standard.set(encoded, forKey: "devices")
        }
    }
    
    static func checkIfExists(_ ipAdress: String) -> Bool {
        let devices = self.getDevices()
        let found = devices.first(where: { device in
            device.ipaddress == ipAdress
        })
        
        if found == nil {
            return false
        } else {
            return true
        }
    }
}
