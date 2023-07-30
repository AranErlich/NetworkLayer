//
//  NetworkLayerApp.swift
//  NetworkLayer
//
//  Created by Aran Erlich on 16/06/2022.
//

import SwiftUI

@main
struct NetworkLayerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel())
        }
    }
}
