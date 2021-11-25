//
//  ShimmerPokemonRow.swift
//  Pokedex
//
//  Created by Marlon David Ruiz Arroyave on 2/03/21.
//

import SwiftUI
import PokemonAPI

struct ShimmerPokemonRow: View {
    @State var show = false
    var center = (UIScreen.main.bounds.width / 2) + 110

    var body: some View {
        ZStack {
            HStack() {
                Circle()
                    .fill(Color.black.opacity(0.09))
                    .frame(width: 68, height: 68)

                VStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.black.opacity(0.09))
                        .frame(width: 150, height: 15)
                    Rectangle()
                        .fill(Color.black.opacity(0.09))
                        .frame(width: 70, height: 15)
                }

                Spacer()

                Circle()
                    .fill(Color.black.opacity(0.09))
                    .frame(width: 30, height: 30)

                Circle()
                    .fill(Color.black.opacity(0.09))
                    .frame(width: 30, height: 30)
            }
            .padding(.horizontal, 20.0)

            HStack {
                Circle()
                    .fill(Color.white.opacity(0.6))
                    .frame(width: 68, height: 68)

                VStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.white.opacity(0.6))
                        .frame(width: 150, height: 15)
                    Rectangle()
                        .fill(Color.white.opacity(0.6))
                        .frame(width: 70, height: 15)
                }

                Spacer()

                Circle()
                    .fill(Color.white.opacity(0.6))
                    .frame(width: 30, height: 30)

                Circle()
                    .fill(Color.white.opacity(0.6))
                    .frame(width: 30, height: 30)
            }
            .padding(.horizontal, 20.0)
            .mask(
                Rectangle()
                    .fill(
                        LinearGradient(gradient: .init(colors: [.clear, Color.white.opacity(0.60), .clear]), startPoint: .top, endPoint: .bottom)
                    )
                    .rotationEffect(.init(degrees: 70))
                    .offset(x: show ? center : -center)
            )
        }
    }
}

struct ShimmerRow_Previews: PreviewProvider {
    static var previews: some View {
        ShimmerPokemonRow()
    }
}
