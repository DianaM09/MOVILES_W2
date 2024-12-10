//
//  CeldaProducto.swift
//  EazyShoes
//
//  Created by DAMII on 10/12/24.
//

import SwiftUI

struct CeldaProducto: View {
    let producto: Product
    @Binding var favoritos: [FavoriteProduct] 

    var body: some View {
        VStack {
            
          
            HStack {
                Spacer()
                Button(action: toggleFavorito) {
                    Image(systemName: esFavorito() ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.orange)
                        .padding(8)
                }
                .background(Color.black)
                .clipShape(Circle())
                .shadow(radius: 3)
                .padding(.trailing, 10)
            }
            
            
            AsyncImage(url: URL(string: producto.imagen)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 150)
            } placeholder: {
                ProgressView().frame(height: 150)
            }

            Spacer(minLength: 10)

   
            VStack(alignment: .leading, spacing: 5) {
                Text("$\(Int(producto.precio))")
                       .fontWeight(.bold)
                       .foregroundColor(.white)
                       .padding(.horizontal, 10)
                       .padding(.vertical, 5)
                       .background(Color.orange)
                       .cornerRadius(10)
                Text(producto.nombre)
                    .font(.headline)
                    .lineLimit(1)
                    .foregroundColor(.white)

                Text(producto.marca)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 10)

            Spacer(minLength: 10)

            
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
        .shadow(radius: 5)
    }


    private func esFavorito() -> Bool {
        favoritos.contains(where: { $0.id == Int64(producto.id) })
    }

   
    private func toggleFavorito() {
        if esFavorito() {
            eliminarDeFavoritos()
        } else {
            agregarAFavoritos()
        }
    }

    private func agregarAFavoritos() {
        let contexto = PersistenceController.shared.container.viewContext
        let favorito = FavoriteProduct(context: contexto)
        favorito.id = Int64(producto.id)
        favorito.nombre = producto.nombre
        favorito.marca = producto.marca
        favorito.precio = producto.precio
        favorito.imagen = producto.imagen
        favorito.genero = producto.genero
        favorito.categoria = producto.categoria

        do {
            try contexto.save()
            favoritos.append(favorito)
        } catch {
            print("Error al agregar a favoritos: \(error)")
        }
    }

    private func eliminarDeFavoritos() {
        let contexto = PersistenceController.shared.container.viewContext
        if let index = favoritos.firstIndex(where: { $0.id == Int64(producto.id) }) {
            let favorito = favoritos[index]
            contexto.delete(favorito)

            do {
                try contexto.save()
                favoritos.remove(at: index)
            } catch {
                print("Error al eliminar de favoritos: \(error)")
            }
        }
    }
}
