//
//  ErrorView.swift
//  StarAPI-Test
//
//  Created by Mani V on 11/6/23.
//

import SwiftUI

struct ErrorView: View {
    
    @ObservedObject var launchFetcherViewModel = LaunchFetcherViewModel()

    var body: some View {
        VStack {
            Text("🙁")
                .font(.system(size: 80))
            Text(launchFetcherViewModel.errorMessage ?? "")
            
            Button {
                launchFetcherViewModel.fetchAllLaunches()
            } label: {
                Text("Try again")
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
