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
    @State var brightnessEditing: Bool = false {
        didSet {
            if brightnessEditing == false {
                setBrightness()
            }
        }
    }
    @State var online: Bool = true
    
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
                Text(device.name)
                    .bold()
                
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
        }
    }
    
    func load() {
        WledApi.getInfo(device).responseDecodable(of: WledApiResponse.self, completionHandler: self.completionHandler)
    }
    
    func toggle() {
        WledApi.setOnOff(device, on: !deviceState).response { _ in self.deviceState.toggle() }
    }
    
    func setBrightness() {
        WledApi.setBrightness(device, brightness: brightness).response { res in self.deviceState = true }
    }
    
    func completionHandler(_ response: AFDataResponse<WledApiResponse>) {
        switch response.result {
        case .success(let data):
            self.deviceState = data.state.on
            self.brightness = data.state.brightness
            self.online = true
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
