//
//  ManualAddDeviceSheet.swift
//  WLED Swift
//
//  Created by Wisse Hes on 09/10/2021.
//

import SwiftUI

struct ManualAddDeviceSheet: View {
    
    @State var ipaddress: String = ""
    @State var name: String = ""
    
    @Environment(\.dismiss) var dismiss
    
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
                    Text("IP Address")
                    Spacer()
                    TextField("IP Address", text: $ipaddress)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("Toggle to identify")
                    Spacer()
                    Button("Toggle") {
                        self.toggle()
                    }
                }
                
            }.navigationTitle("Add device")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            dismiss()
                        } label: {
                            Label("Close", systemImage: "xmark.circle")
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save", action: save)
                    }
                }
        }
    }
    
    func save() {
        if name.isEmpty || ipaddress.isEmpty { return }
        
        DeviceManager.add(device: Device(
            name: self.name,
            ipaddress: self.ipaddress,
            port: 80
        ))
        
        dismiss()
    }
    
    func toggle() {
        if ipaddress.isEmpty { return }
        
        WledApi.toggle(ipaddress: ipaddress, port: 80)
    }
}

struct ManualAddDeviceSheet_Previews: PreviewProvider {
    static var previews: some View {
        ManualAddDeviceSheet()
    }
}
