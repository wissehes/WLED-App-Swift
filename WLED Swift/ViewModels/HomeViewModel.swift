//
//  HomeViewModel.swift
//  HomeViewModel
//
//  Created by Wisse Hes on 12/08/2021.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var devices: [Device] = [] {
        didSet {
            DeviceManager.save(devices)
        }
    }
    
    func getDevices() {
        devices = DeviceManager.getDevices()
    }
}
