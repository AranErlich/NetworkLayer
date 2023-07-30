//
//  ContentView.swift
//  NetworkLayer
//
//  Created by Aran Erlich on 16/06/2022.
//

import SwiftUI

struct ContentView<ViewModel:ContentViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
            TextField("Password", text: $viewModel.password)
            Button("Send") {
                viewModel.auth()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
