//
//  HomeDeviceItem.swift
//  WLED Swift
//
//  Created by Wisse Hes on 26/09/2021.
//

import SwiftUI
import Alamofire

struct HomeDeviceItem: View {
    var device: Device
    @State var deviceState: Bool = false
    @State var brightness: Float = 255
    @State var currentPresetIndex: Int = -1 {
        didSet {
            if presets.indices.contains(currentPresetIndex) {
                self.currentPreset = presets[currentPresetIndex]
            } else {
                self.currentPreset = nil
            }
        }
    }
    @State var currentPreset: WledPreset?
    @State var brightnessEditing: Bool = false {
        didSet {
            if brightnessEditing == false {
                setBrightness()
            }
        }
    }
    @State var udpnSend: Bool = false
    @State var online: Bool = true
    @State var presets: [WledPreset] = []
    
    var body: some View {
        NavigationLink {
            DeviceView(url: URL(string: "http://\(device.ipaddress!)")!)
        } label: {
            item
        }.onAppear(perform: load)
            .disabled(!online)
    }
    
    var item: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(device.name)
                        .bold()
                    
                    if let preset = currentPreset {
                        Text("Current \(preset.type == .preset ? "preset" : "playlist"): \(preset.name)")
                            .font(.subheadline)
                            .lineLimit(2)
                    }
                }
                
                Spacer()
                
                Button {
                    self.toggle()
                } label: {
                    if !online {
                        Image(systemName: "power")
                            .foregroundColor(.gray)
                    } else if deviceState {
                        Image(systemName: "power")
                            .foregroundColor(.green)
                    } else {
                        Image(systemName: "power")
                            .foregroundColor(.red)
                    }
                }.buttonStyle(.plain).font(Font.system(size: 60))
            }
            
            Slider(value: $brightness, in: 1...255, step: 1) { editing in
                self.brightnessEditing = editing
            }
        }.contextMenu {
            Menu("Presets") {
                ForEach(presets, id: \.key) { preset in
                    Button {
                        setPreset(preset)
                    } label: {
                        switch preset.type {
                        case .preset:
                            Label("\(preset.key). \(preset.name)", systemImage: "lightbulb")
                        case .playlist:
                            Label("\(preset.key). \(preset.name)", systemImage: "list.number")
                        }
                    }
                }
            }
            
            Button("Turn UDPN Sync \(udpnSend ? "off" : "on")") {
                self.setUdpnSend(!udpnSend)
            }
        }
    }
    
    func load() {
        loadInfo().response { _ in loadPresets() }
    }
    
    func loadInfo() -> DataRequest {
        return WledApi.getInfo(device).responseDecodable(of: WledApiResponse.self, completionHandler: self.completionHandler)
    }
    
    func loadPresets() {
        WledApi.getPresets(device).responseDecodable(of: WledPresetResponse.self) { response in
            switch response.result {
            case .success(let presets):
                self.presets = presets.filter({ item in item.value.name != nil }).map {
                    if $0.value.playlist == nil {
                        return WledPreset(key: $0.key, name: $0.value.name ?? "Unknown preset", type: .preset)
                    } else {
                        return WledPreset(key: $0.key, name: $0.value.name ?? "Unknown playlist", type: .playlist)
                    }
                }.sorted(by: {
                    Int($0.key) ?? 0 < Int($1.key) ?? 0
                })
                
                if self.presets.indices.contains(self.currentPresetIndex) {
                    self.currentPreset = self.presets[self.currentPresetIndex]
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func toggle() {
        WledApi.setOnOff(device, on: !deviceState).response { _ in self.deviceState.toggle() }
    }
    
    func setBrightness() {
        WledApi.setBrightness(device, brightness: brightness).response { res in self.deviceState = true }
    }
    
    func setPreset(_ preset: WledPreset) {
        WledApi.setPreset(device, preset: preset).response { _ in let _ = self.loadInfo() }
    }
    
    func setUdpnSend(_ send: Bool) {
        WledApi.setUdpnSend(device, send: send).validate().response { _ in let _ = self.loadInfo() }
    }
    
    func completionHandler(_ response: AFDataResponse<WledApiResponse>) {
        switch response.result {
        case .success(let data):
            self.deviceState = data.state.on
            self.brightness = data.state.brightness
            self.online = true
            self.udpnSend = data.state.udpn.send
            if data.state.playlistIndex > 0 {
                self.currentPresetIndex = data.state.playlistIndex - 1
            } else if data.state.presetIndex == -1 {
                self.currentPresetIndex = data.state.presetIndex
            } else {
                self.currentPresetIndex = data.state.presetIndex - 1
            }
            
        case .failure(let error):
            print(error)
            self.online = false
        }
    }
}

struct HomeDeviceItem_Previews: PreviewProvider {
    static var previews: some View {
        HomeDeviceItem(device: Device(name: "WLED", ipaddress: "0.0.0.0", port: 80))
    }
}
