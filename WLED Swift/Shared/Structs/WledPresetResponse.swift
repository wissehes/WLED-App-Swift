//
//  WledPresetResponse.swift
//  WLED Swift
//
//  Created by Wisse Hes on 26/09/2021.
//

import Foundation

enum WledPresetType: String {
    case preset = "preset"
    case playlist = "playlist"
}

struct WledPreset {
    let key: String
    let name: String
    let type: WledPresetType
}

// MARK: - WledPresetResponseValue
struct WledPresetResponseValue: Codable {
    let name: String?
//    let mainseg: Int?
//    let seg: [Seg]?
//    let on: Bool?
//    let brightness, transition: Int?
    let playlist: Playlist?
    
    enum CodingKeys: String, CodingKey {
        case name = "n"
//        case mainseg, seg, on, transition
        case playlist
//        case brightness = "bri"
    }
}

// MARK: - Playlist
struct Playlist: Codable {
    let ps, dur, transition: [Int]
    let playlistRepeat: Int
    let r: Bool
    let end: Int

    enum CodingKeys: String, CodingKey {
        case ps, dur, transition
        case playlistRepeat = "repeat"
        case r, end
    }
}

// MARK: - Seg
struct Seg: Codable {
    let id, start: Int?
    let stop: Int
    let grp, spc, of: Int?
    let on: Bool?
    let bri: Int?
    let col: [[Int]]?
    let fx, sx, ix, pal: Int?
    let sel, rev, mi: Bool?
}

typealias WledPresetResponse = [String: WledPresetResponseValue]
