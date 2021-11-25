//
//  ViewsCanPullInPushOut.swift
//  IOSBootcampChallengeSwiftUI
//
//  Created by Marlon David Ruiz Arroyave on 24/11/21.
//

import SwiftUI

struct ViewsCanPullInPushOut: View {
    var body: some View {
        VStack {
            // Pull in view
            // Only use the space that it needs
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)

            // Push out view
            // Pushing out & competing for space
            // Use as much space as possible
            // All this view are sharing
            // the space equally.
            Color.red
            Circle()
                .fill(.purple)
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(.yellow)
//            ZStack {
//                Color.red
//                Circle().fill(.purple)
//                RoundedRectangle(cornerRadius: 30)
//                    .padding(.horizontal, 2.0)
//                    .foregroundColor(.yellow)
//                    .frame(height: 100)
//            }

        }
    }
}

struct ViewsCanPullInPushOut_Previews: PreviewProvider {
    static var previews: some View {
        ViewsCanPullInPushOut()
    }
}
