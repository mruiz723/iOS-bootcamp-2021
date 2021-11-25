//
//  CustomButton.swift
//  IOSBootcampChallengeSwiftUI
//
//  Created by Marlon David Ruiz Arroyave on 24/11/21.
//

import SwiftUI

struct CustomButton: View {
    private var title: String
    private var bgColor: Color
    private var action: () -> ()

    init(title: String, bgColor: Color, action: @escaping () -> ()) {
        self.title = title
        self.bgColor = bgColor
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
        }
        .foregroundColor(.white)
        .frame(height: 50)
        .padding(.horizontal)
        .background(bgColor)
        .cornerRadius(10)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(title: "TestButton", bgColor: .blue, action: {})
    }
}
