//
//  Product.swift
//  EazyShoes
//
//  Created by DAMII on 10/12/24.
//

import Foundation

struct Product: Identifiable, Codable{
    let id: Int
        let nombre: String
        let marca: String
        let precio: Double
        let imagen: String
        let genero: String
        let categoria: String
        let tamanosDisponibles: [TamanoDisponible]
    
    enum CodingKeys: String, CodingKey {
            case id
            case nombre = "name"
            case marca = "brand"
            case precio = "price"
            case imagen = "image"
            case genero = "gender"
            case categoria = "category"
            case tamanosDisponibles = "sizes_available"
        }
}

struct TamanoDisponible: Codable {
    let tamano: Double
    let cantidad: Int

    enum CodingKeys: String, CodingKey {
        case tamano = "size"
        case cantidad = "quantity"
    }
}
