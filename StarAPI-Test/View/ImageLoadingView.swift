//
//  ImageLoadingView.swift
//  StarAPI-Test
//
//  Created by Mani V on 11/6/23.
//

import SwiftUI

struct ImageLoadingView: View {
    
    @StateObject var imageLoadingViewModel: ImageLoadingViewModel
    
    let imageSize: CGFloat = 100
    
    init(url: String?) {
        self._imageLoadingViewModel = StateObject(wrappedValue: ImageLoadingViewModel(url: url))
    }
    
    var body: some View {
        Group {
            if imageLoadingViewModel.image != nil {
                Image(uiImage: imageLoadingViewModel.image!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageSize, height: imageSize)
                    .clipped()
            } else if imageLoadingViewModel.errorMessage != nil {
                Text(imageLoadingViewModel.errorMessage!)
                    .foregroundColor(Color.white)
                    .frame(width: imageSize, height: imageSize)
            } else {
                ProgressView()
                    .frame(width: imageSize, height: imageSize)
            }
        }
        .onAppear {
            imageLoadingViewModel.fetchLaunches()
        }
    }
}

struct ImageLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoadingView(url: nil)
    }
}
