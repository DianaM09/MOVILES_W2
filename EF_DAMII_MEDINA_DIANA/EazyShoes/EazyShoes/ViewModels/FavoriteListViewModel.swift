//
//  FavoriteListViewModel.swift
//  EazyShoes
//
//  Created by DAMII on 10/12/24.
//

import Foundation

import CoreData

class FavoriteListViewModel: ObservableObject {
    @Published var favoritos: [FavoriteProduct] = []

    private let contexto = PersistenceController.shared.container.viewContext

    func cargarFavoritos() {
        let request: NSFetchRequest<FavoriteProduct> = FavoriteProduct.fetchRequest()
        do {
            favoritos = try contexto.fetch(request)
        } catch {
            print("Error al cargar favoritos: \(error)")
        }
    }

    func agregarFavorito(producto: Product) {
        let favorito = FavoriteProduct(context: contexto)
        favorito.id = Int64(producto.id)
        favorito.nombre = producto.nombre
        favorito.marca = producto.marca
        favorito.precio = producto.precio
        favorito.imagen = producto.imagen
        favorito.genero = producto.genero
        favorito.categoria = producto.categoria
        guardarContexto()
    }

    func eliminarFavorito(favorito: FavoriteProduct) {
        contexto.delete(favorito)
        guardarContexto()
    }

    private func guardarContexto() {
        do {
            try contexto.save()
            cargarFavoritos()
        } catch {
            print("Error al guardar contexto: \(error)")
        }
    }
}
