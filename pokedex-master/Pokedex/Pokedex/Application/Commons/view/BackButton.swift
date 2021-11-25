//
//  BackButton.swift
//  Pokedex
//
//  Created by Marlon David Ruiz Arroyave on 7/03/21.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image("back")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30, alignment: .leading)
        })
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
            .background(Color.blue)
    }
}
