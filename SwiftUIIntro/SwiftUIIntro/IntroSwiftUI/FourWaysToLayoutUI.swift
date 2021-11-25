//
//  FourWaysToLayoutUI.swift
//  IOSBootcampChallengeSwiftUI
//
//  Created by Marlon David Ruiz Arroyave on 24/11/21.
//

import SwiftUI

struct FourWaysToLayoutUI: View {

    var customDivider: some View {
        Divider()
            .frame(height: 10)
            .background(.green)
    }

    var colorRing: some View {
        ZStack {
            Circle()
                .fill(.green)
            Circle()
                .fill(.yellow)
                .scaleEffect(0.8)
            Circle()
                .fill(.orange)
                .scaleEffect(0.6)
            Circle()
                .fill(.red)
                .scaleEffect(0.4)
            Circle()
                .fill(.pink)
                .scaleEffect(0.2)
        }
        .padding()
    }

    var body: some View {
        HStack {
            Text("Hey iOS Devs: ")
                .font(.largeTitle)
                .layoutPriority(1)
            Text("It's nice to be here!")
        }
        .foregroundColor(.white)
        .padding()
        .background(.blue)
        .cornerRadius(20)

        VStack {
            Text("Hey iOS Devs: ")
                .font(.largeTitle)
            Text("It's nice to be here!")
        }
        .foregroundColor(.white)
        .padding()
        .background(.blue)
        .cornerRadius(20)

        ZStack {

            VStack {
                Spacer()
                customDivider
                HStack {
                    Text("Hey iOS Devs: ")
                        .font(.largeTitle)
                        .layoutPriority(1)
                    Text("It's nice to be here!")
                }
                .foregroundColor(.white)
                .padding()
                .background(.blue)
                .cornerRadius(20)
                customDivider
                Spacer()
                colorRing

                customDivider
                VStack {
                    Text("Hey iOS Devs: ")
                        .font(.largeTitle)
                    Text("It's nice to be here!")
                }
                .foregroundColor(.white)
                .padding()
                .background(.blue)
                .cornerRadius(20)
                customDivider
                Spacer()
            }
        }
    }
}

struct FourWaysToLayoutUI_Previews: PreviewProvider {
    static var previews: some View {
        FourWaysToLayoutUI()
    }
}
