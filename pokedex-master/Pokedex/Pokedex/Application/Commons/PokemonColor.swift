//
//  PokemonColor.swift
//  Pokedex
//
//  Created by Marlon David Ruiz Arroyave on 27/02/21.
//

import SwiftUI
import PokemonAPI

struct PokemonColor {

    static func typeLinearGradient(name: String?) -> LinearGradient {
        let type = PokemonType(rawValue: name ?? "")
        switch type {
        case .grass:
            return LinearGradient(gradient: Gradient(colors: [.primaryGrass, .secondaryWater]), startPoint: .leading, endPoint: .trailing)
        case .poison:
            return LinearGradient(gradient: Gradient(colors: [.primaryPoison, .secondaryPoison]), startPoint: .leading, endPoint: .trailing)
        case .fire:
            return LinearGradient(gradient: Gradient(colors: [.primaryFire, .secondaryFire]), startPoint: .leading, endPoint: .trailing)
        case .flying:
            return LinearGradient(gradient: Gradient(colors: [.primaryFlying, .secondaryFlying]), startPoint: .leading, endPoint: .trailing)
        case .bug:
            return LinearGradient(gradient: Gradient(colors: [.primaryBug, .secondaryBug]), startPoint: .leading, endPoint: .trailing)
        case .water:
            return LinearGradient(gradient: Gradient(colors: [.primaryWater, .secondaryWater]), startPoint: .leading, endPoint: .trailing)
        default:
            return  LinearGradient(gradient: Gradient(colors: [.primaryNormal, .secondaryNormal]), startPoint: .leading, endPoint: .trailing)
        }
    }
}

extension Color {
    static let primaryWater = Color(red: 85.0/255, green: 158.0/255, blue: 223.0/255)
    static let secondaryWater = Color(red: 105.0/255, green: 185.0/255, blue: 227.0/255)
    static let primaryGrass = Color(red: 95.0/255, green: 188.0/255, blue: 81.0/255)
    static let secondaryGrass = Color(red: 90.0/255, green: 193.0/255, blue: 120.0/255)
    static let primaryBug = Color(red: 146.0/255, green: 188.0/255, blue: 44.0/255)
    static let secondaryBug = Color(red: 175.0/255, green: 200.0/255, blue: 54.0/255)
    static let primaryNormal = Color(red: 146.0/255, green: 152.0/255, blue: 164.0/255)
    static let secondaryNormal = Color(red: 163.0/255, green: 164.0/255, blue: 158.0/255)
    static let primaryFire = Color(red: 251.0/255, green: 155.0/255, blue: 81.0/255)
    static let secondaryFire = Color(red: 251.0/255, green: 174.0/255, blue: 70.0/255)
    static let primaryPoison = Color(red: 168.0/255, green: 100.0/255, blue: 199.0/255)
    static let secondaryPoison = Color(red: 194.0/255, green: 97.0/255, blue: 212.0/255)
    static let primaryFlying = Color(red: 144.0/255, green: 167.0/255, blue: 218.0/255)
    static let secondaryFlying = Color(red: 166.0/255, green: 194.0/255, blue: 242.0/255)
}


//func typeTextColor(_ type: Pokemon.PokemonType?) -> Color {
//    switch type {
//    case .flying:
//        return .black
//    default:
//        return .white
//    }
//}
