//
//  WledApiResponse.swift
//  WLED Swift
//
//  Created by Wisse Hes on 26/09/2021.
//

import Foundation

struct WledApiResponse: Codable {
    let state: WledState
}

struct WledState: Codable {
    let on: Bool
    let brightness: Float
    let presetIndex: Int
    let playlistIndex: Int
    let udpn: WledUDPN
    
    
    enum CodingKeys: String, CodingKey {
        case on            = "on"
        case brightness    = "bri"
        case presetIndex   = "ps"
        case playlistIndex = "pl"
        case udpn          = "udpn"
    }
}

struct WledUDPN: Codable {
    let send: Bool
    let receive: Bool
    
    enum CodingKeys: String, CodingKey {
        case send
        case receive = "recv"
    }
}
