//
//  Device.swift
//  Device
//
//  Created by Wisse Hes on 12/08/2021.
//

import Foundation

struct Device: Codable, Identifiable {
    var name: String
    let ipaddress: String?
    let port: Int
    
    var id = UUID()
}
