//
//  ProductListViewModel.swift
//  EazyShoes
//
//  Created by DAMII on 10/12/24.
//

import Foundation


class ProductListViewModel: ObservableObject {
    @Published var productos: [Product] = []
    @Published var cargando = false
    @Published var mensajeError: String?

    private let servicio = ProductService()

    func cargarProductos(genero: String) {
        cargando = true
        productos = [] 
        mensajeError = nil

        servicio.obtenerProductos(genero: genero) { [weak self] resultado in
            DispatchQueue.main.async {
                self?.cargando = false
                switch resultado {
                case .success(let productos):
                    self?.productos = productos
                case .failure(let error):
                    self?.mensajeError = (error as NSError).userInfo[NSLocalizedDescriptionKey] as? String
                }
            }
        }
    }
}
