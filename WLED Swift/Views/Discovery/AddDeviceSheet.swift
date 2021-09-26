//
//  AddDeviceSheet.swift
//  WLED Swift
//
//  Created by Wisse Hes on 26/09/2021.
//

import SwiftUI
import Alamofire

struct AddDeviceSheet: View {
    @State var name: String = ""
    @State var ipaddress: String = ""
    @State var port: Int
    
    @Binding var isAdded: Bool
    
    @Environment(\.dismiss) var dismiss
    
    //    init(device: Device, isAdded: ) {
    //        self.name = device.name
    //        self.ipaddress = device.ipaddress ?? ""
    //        self.port = device.port
    //        self.isAdded = isAdded
    //    }
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Text("Name")
                    
                    Spacer()
                    
                    TextField("Name", text: $name)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("Toggle to identify")
                    
                    Spacer()
                    
                    Button("Toggle") {
                        self.toggle()
                    }
                }
                
                Button {
                    DeviceManager.add(device: Device(
                        name: self.name,
                        ipaddress: self.ipaddress,
                        port: self.port
                    ))
                    self.isAdded = true
                    dismiss()
                } label: {
                    HStack {
                        Spacer()
                        Label("Add", systemImage: "checkmark")
                        Spacer()
                    }
                }
            }.navigationTitle("Add device").toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Close", systemImage: "xmark.circle")
                    }
                }
            }
        }
    }
    
    func toggle() {
        WledApi.toggle(ipaddress: ipaddress, port: port)
    }
}

struct AddDeviceSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddDeviceSheet(name: "WLED", ipaddress: "0.0.00", port: 80, isAdded: .constant(false))
    }
}
