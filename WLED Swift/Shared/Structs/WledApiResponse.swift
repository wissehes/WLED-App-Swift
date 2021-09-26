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
    
    
    enum CodingKeys: String, CodingKey {
        case on         = "on"
        case brightness = "bri"
    }
}
