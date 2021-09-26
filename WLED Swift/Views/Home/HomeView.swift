//
//  HomeView.swift
//  HomeView
//
//  Created by Wisse Hes on 12/08/2021.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        List {
            if viewModel.devices.count == 0 {
                Text("Press \"Discord devices\" to add devices.")
            }
                
            ForEach(viewModel.devices) { device in
                HomeDeviceItem(device: device)
            }.onDelete { indexSet in
                viewModel.devices.remove(atOffsets: indexSet)
            }
        }
        .navigationTitle("Home")
        .onAppear(perform: viewModel.getDevices)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: DiscoveryView()) {
                    Text("Discover devices")
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
