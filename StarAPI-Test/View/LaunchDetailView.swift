//
//  LaunchDetailView.swift
//  StarAPI-Test
//
//  Created by Mani V on 11/6/23.
//

import SwiftUI

struct LaunchDetailView: View {
    
    let launch: Launch
    let imageSize: CGFloat = 350
    
    var body: some View {
        VStack {
            if launch.links?.mission_patch != nil {
                AsyncImage(url: URL(string: launch.links?.mission_patch ?? "")) { phase in
                    if let image = phase.image {
                        image.resizable()
                            .scaledToFit()
                            .frame(width: imageSize, height: imageSize)
                            .clipped()
                    } else if phase.error != nil {
                        Text(phase.error?.localizedDescription ?? "N/A")
                            .foregroundColor(Color.white)
                            .frame(width: imageSize, height: imageSize)
                    } else {
                        ProgressView() // Acts as a placeholder
                            .frame(width: imageSize, height: imageSize)
                    }
                    
                }
            } else {
                Image("image")
                    .frame(width: imageSize, height: imageSize)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(LaunchConstants.missionName + (launch.missionName ?? "N/A"))
                Text(LaunchConstants.rocketType + (launch.rocket?.rocket_type ?? "Not Found"))
                Text(LaunchConstants.launchSite + (launch.launchSite?.site_name ?? "N/A"))
                Text(LaunchConstants.rocketID + (launch.rocket?.rocket_id ?? "Not Found"))
                Text(LaunchConstants.launchDate + (launch.launchDate ?? "N/A"))
                Spacer()
            }
            .font(.headline)
            .padding()
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LaunchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchDetailView(launch: Launch.testLaunch1())
    }
}
