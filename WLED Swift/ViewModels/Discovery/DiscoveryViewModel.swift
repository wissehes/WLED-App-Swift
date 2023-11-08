//
//  DiscoveryViewModel.swift
//  DiscoveryViewModel
//
//  Created by Wisse Hes on 12/08/2021.
//

import Foundation

class DiscoveryViewModel: ObservableObject {
    private let bonjour: Bonjour = Bonjour()
    
    @Published var newDevices: [Device] = []
    @Published var alreadyAddedDevices: [Device] = []
    
    @Published var sheetshown: Bool = false
    
    func discover(){
        print("discovering")
        
        bonjour.noServicesFoundClosure = {
            print("No services were found on the network")
        }
        
        bonjour.serviceDiscoveryFinishedClosure = { (services) in
            print("Found services: \(services)")
        }
        
        _ = bonjour.findService(type: "_http._tcp.", domain: Bonjour.LocalDomain) { service in
            print("found service:")
            print("Service \(service.name) - \(String(describing: service.getHost()))")
            if service.name.contains("wled") {
                guard let ipAddress = service.ipaddress else { return }
                let device = Device(
                    name: service.name,
                    ipaddress: service.ipaddress,
                    port: service.port
                )
                
                if DeviceManager.checkIfExists(ipAddress) {
                    self.alreadyAddedDevices.append(device)
                } else {
                    self.newDevices.append(device)
                }
            }
        }
    }
}
