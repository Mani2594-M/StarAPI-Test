//
//  LaunchItem.swift
//  StarAPI-Test
//
//  Created by Mani V on 11/6/23.
//

import SwiftUI

struct LaunchItem: View {
    
    let launch: Launch
    let imageSize: CGFloat = 80
    
    var body: some View {
        HStack {
            if launch.links?.mission_patch != nil {
                AsyncImage(url: URL(string: launch.links?.mission_patch ?? "")) { phase in
                    if let image = phase.image {
                        image.resizable()
                            .scaledToFill()
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
                Image(systemName: "photo.fill")
                    .frame(width: imageSize, height: imageSize)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(launch.missionName ?? "N/A")
                    .font(.headline)
                Text(launch.rocket?.rocket_type ?? "Not Found")
            }
        }
    }
}

struct LaunchItem_Previews: PreviewProvider {
    static var previews: some View {
        LaunchItem(launch: Launch.testLaunch1())
            .previewLayout(.fixed(width: 400, height: 200))
    }
}
