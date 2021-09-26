//
//  ServiceListView.swift
//  ServiceListView
//
//  Created by Wisse Hes on 12/08/2021.
//

import SwiftUI

struct ServiceAddListView: View {
    let device: Device
    //    let addDevice: () -> Void
    @State var added: Bool = false
    @State var sheet: Bool = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(device.name)
                
                Spacer()
                
                Text(device.ipaddress ?? "Unknown ip").font(.subheadline)
            }
            
            Spacer()
            
            Button(action: {
//                DeviceManager.add(device: self.device)
//                self.added = true
                self.sheet = true
            }) {
                if added {
                    Image(systemName: "checkmark.circle.fill")
                        .font(Font.system(size: 40))
                } else {
                    Image(systemName: "plus.circle.fill")
                        .font(Font.system(size: 40))
                }
            }
        }.sheet(isPresented: $sheet) {
            AddDeviceSheet(
                name: device.name,
                ipaddress: device.ipaddress ?? "",
                port: device.port,
                isAdded: $added
            )
        }
    }
}

struct ServiceAddListView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceAddListView(device: Device(name: "Test", ipaddress: "0.0.0.0", port: 80))
    }
}
