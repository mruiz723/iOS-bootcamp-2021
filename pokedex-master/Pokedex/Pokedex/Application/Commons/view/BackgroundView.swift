//
//  BackgroundView.swift
//  Pokedex
//
//  Created by Marlon David Ruiz Arroyave on 7/03/21.
//

import SwiftUI

struct BackgroundView: View {
    let name: String?

    var body: some View {
        PokemonColor.typeLinearGradient(name: name)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(name: "fire")
    }
}
