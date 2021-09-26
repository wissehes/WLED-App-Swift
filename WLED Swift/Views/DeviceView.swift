//
//  DeviceView.swift
//  DeviceView
//
//  Created by Wisse Hes on 12/08/2021.
//

import SwiftUI

struct DeviceView: View {
    var url: URL
    
    var body: some View {
        Webview(url: url)
            .navigationTitle("Device")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct DeviceView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceView(url: URL(string: "http://google.com")!)
    }
}
