//
//  ContentView.swift
//  StarAPI-Test
//
//  Created by Mani V on 11/6/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var launchFetcherViewModel = LaunchFetcherViewModel()
    
    var body: some View {
        if launchFetcherViewModel.isLoading {
            LoadingView()
        } else if launchFetcherViewModel.errorMessage != nil {
            ErrorView(launchFetcherViewModel: launchFetcherViewModel)
        } else {
            LaunchListView(launches: launchFetcherViewModel.launches)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
