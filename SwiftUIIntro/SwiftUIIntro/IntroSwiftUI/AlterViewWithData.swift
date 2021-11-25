//
//  AlterViewWithData.swift
//  IOSBootcampChallengeSwiftUI
//
//  Created by Marlon David Ruiz Arroyave on 24/11/21.
//

import SwiftUI

struct AlterViewWithData: View {

    @State private var circleColor: Color = .gray

    var body: some View {

        VStack {
            HStack{
                CustomButton(title: "Yellow Color", bgColor: .yellow) {
                    withAnimation(.linear(duration: 0.7)) {
                        circleColor = .yellow
                    }
                }
                Button(action: {
                    withAnimation(.easeInOut(duration: 1)) {
                        circleColor = .blue
                    }
                }) {
                    Text("Blue Color")
                }
                .frame(height: 50)
                .padding(.horizontal)
                .background(.blue)
                .cornerRadius(10)

                Button("Pink Color") {
                    withAnimation(.easeIn(duration: 1)) {
                        circleColor = .pink
                    }
                }
                .frame(height: 50)
                .padding(.horizontal)
                .background(.pink)
                .cornerRadius(10)
            }
            .padding()
            .foregroundColor(.white)

            Circle()
                .fill(circleColor)
                .padding()
//                .animation(.easeInOut(duration: 0.2), value: circleColor)
        }
    }
}

struct AlterViewWithData_Previews: PreviewProvider {
    static var previews: some View {
        AlterViewWithData()
    }
}
