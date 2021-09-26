//
//  WledApi.swift
//  WLED Swift
//
//  Created by Wisse Hes on 26/09/2021.
//

import Foundation
import Alamofire

struct WledApi {
    static func getInfo(_ device: Device) -> DataRequest {
        return AF.request("http://\(device.ipaddress ?? ""):\(device.port)/json").validate()
    }
    
    static func setOnOff(_ device: Device, on: Bool) -> DataRequest {
        let params: Parameters = [
            "on": on
        ]
        
        return AF.request(
            "http://\(device.ipaddress ?? ""):\(device.port)/json",
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default
        ).validate()
    }
    
    static func setBrightness(_ device: Device, brightness: Float) -> DataRequest {
        let params: Parameters = [
            "on": true,
            "bri": brightness
        ]
        
        return AF.request(
            "http://\(device.ipaddress ?? ""):\(device.port)/json",
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default
        )
    }
    
    static func toggle(ipaddress: String, port: Int) {
        AF.request("http://\(ipaddress):\(port)/win&T=2").response { _ in }
    }
    
    static func getPresets(_ device: Device) -> DataRequest {
        AF.request("http://\(device.ipaddress ?? ""):\(device.port)/presets.json").validate()
    }
    
    static func setPreset(_ device: Device, preset: WledPreset) -> DataRequest {
        return AF.request("http://\(device.ipaddress ?? ""):\(device.port)/win&PL=\(preset.key)")
    }
    
    static func setUdpnSend(_ device: Device, send: Bool) -> DataRequest {
        let params: Parameters = [
            "udpn": [
                "send": send
            ]
        ]
        
        return AF.request(
            "http://\(device.ipaddress ?? ""):\(device.port)/json",
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default
        )
    }
}
