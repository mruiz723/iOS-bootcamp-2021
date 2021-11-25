//
//  PokemonRow.swift
//  Pokedex
//
//  Created by Marlon David Ruiz Arroyave on 27/02/21.
//

import SwiftUI
import PokemonAPI
import Kingfisher

struct PokemonRow: View {
    let pokemon: PKMPokemon?
    
    var body: some View {
        HStack {
            KFImage(URL(string: pokemon?.sprites?.frontDefault ?? "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"))
                .resizable()
                .padding(-10.0)
                .frame(width: 68, height: 68, alignment: .center)
                .scaledToFit()

            VStack(alignment: .leading) {
                Text(pokemon?.name?.capitalized ?? "")
                    .font(.headline)
                    .fontWeight(.medium)
                Text(pokemon?.formattedNumber() ?? "")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
            }

            Spacer()

            if let nameSecondaryType = pokemon?.secondaryType() {
                Image(nameSecondaryType)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .scaledToFit()
            }

            if let namefirstType = pokemon?.primaryType() {
                Image(namefirstType)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .scaledToFit()
            }
        }
        .padding(.horizontal, 20.0)
        .padding(.vertical, 5.0)
    }
}

struct PokemonRow_Previews: PreviewProvider {

    static var previews: some View {
        PokemonRow(pokemon: PKMPokemon.pokemonMock())
    }
}
