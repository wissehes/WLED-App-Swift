//
//  ContentView.swift
//  WLED Swift
//
//  Created by Wisse Hes on 08/07/2021.
//

import SwiftUI
import Foundation

struct ContentView: View {
    let bonjour: Bonjour = Bonjour()
    @State var services: [BonjourService] = []
    
    var body: some View {
        NavigationView {
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
