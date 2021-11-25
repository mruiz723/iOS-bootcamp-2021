//
//  ContentView.swift
//  IOSBootcampChallengeSwiftUI
//
//  Created by Marlon David Ruiz Arroyave on 24/11/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("SwiftUI finally is here")
                .padding()
                .background(.pink)
            Text("Hello, iOS!!!")
                .font(.title)
                .fontWeight(.thin)
                .foregroundColor(.pink)
                .padding(20.0)
            VStack(alignment: .trailing, spacing: 20.0) {
                Text("SwiftUI finally is here")
                    .foregroundColor(.white)
                Text("Hello, iOS!")
                    .font(.title)
                    .foregroundColor(.gray)
            }
            .padding(20.0)
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.black/*@END_MENU_TOKEN@*/)
            .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
            Text("I am very happy to be here!!!")
                .font(.caption)
        }
        .font(.largeTitle)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
