//
//  LaunchListView.swift
//  StarAPI-Test
//
//  Created by Mani V on 11/6/23.
//

import SwiftUI

struct LaunchListView: View {
    
    let launches: [Launch]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(launches.sorted { $0.launchDate ?? "N/A" > $1.launchDate ?? "N/A" }) { launch in
                    NavigationLink {
                        LaunchDetailView(launch: launch)
                    } label: {
                        LaunchItem(launch: launch)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Launch the Rockets")
        }
        .onAppear {
            URLCache.shared.memoryCapacity = 1024 * 1024 * 512
        }
    }
}

struct LaunchListView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchListView(launches: LaunchFetcherViewModel.successState().launches)
    }
}
