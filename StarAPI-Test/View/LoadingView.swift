//
//  LoadingView.swift
//  StarAPI-Test
//
//  Created by Mani V on 11/6/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Text("🚀")
                .font(.system(size: 40))
            ProgressView()
            Text("Launching the Rockets")
                .foregroundColor(.red)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
