//
//  DiscoveryView.swift
//  DiscoveryView
//
//  Created by Wisse Hes on 12/08/2021.
//

import SwiftUI

struct DiscoveryView: View {
    @StateObject var viewModel = DiscoveryViewModel()
    
    var body: some View {
        List {
            Section("New devices") {
                ForEach(viewModel.newDevices, id: \.id) { service in
                    ServiceAddListView(device: service)
                }
            }
            
            Section("Already added devices") {
                ForEach(viewModel.alreadyAddedDevices, id: \.id) { service in
                    ServiceAddListView(device: service, added: true)
                }
            }
        }.navigationTitle("Discovery")
            .onAppear { viewModel.discover() }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Manually add WLED") { viewModel.sheetshown.toggle() }
                }
            }
            .sheet(isPresented: $viewModel.sheetshown) {
                ManualAddDeviceSheet()
            }
    }
}

struct DiscoveryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DiscoveryView()
        }
    }
}
