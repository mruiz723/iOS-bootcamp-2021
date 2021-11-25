//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Marlon David Ruiz Arroyave on 27/02/21.
//

import SwiftUI
import PokemonAPI
import Kingfisher

struct PokemonDetailView: View {
    var pokemon: PKMPokemon
    var backButton = BackButton()

    var body: some View {
        ZStack {
            Color(.systemPink)
            BackgroundView(name: pokemon.types?.first?.type?.name)
                .edgesIgnoringSafeArea(.all)
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: -geometry.size.height * 1.15) {
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color.white)
                            .cornerRadius(50)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .padding(.top, 100)
                            .zIndex(-1.0)

                        VStack {
                            KFImage(URL(string: pokemon.sprites?.frontDefault ?? "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 170, height: 170)
                                .padding(.bottom, 20)

                            Text(pokemon.name?.capitalized ?? "Squirtle")
                                .font(.title)
                                .foregroundColor(Color.gray)
                                .multilineTextAlignment(.center)
                                .padding(.top, -30)

                            HStack(spacing: 5) {
                                Button(action: {}, label: {
                                    Image(pokemon.types?.first?.type?.name?.capitalized ?? "Water")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .padding(.leading, 20)
                                    Text(pokemon.types?.first?.type?.name?.uppercased() ?? "Water")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .padding(.trailing, 20)
                                })
                                .disabled(true)
                                .background(BackgroundView(name: pokemon.types?.first?.type?.name))
                                .cornerRadius(20)
                            }

                            Text("Squirtle’s shell is not merely used for protection. The shell’s rounded shape and the grooves on its surface help minimize resistance in water, enabling this pokemon to swim at high speed.")
                                .foregroundColor(Color.gray)
                                .multilineTextAlignment(.center)
                                .padding(20)
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: PKMPokemon.pokemonMock()!)
    }
}
