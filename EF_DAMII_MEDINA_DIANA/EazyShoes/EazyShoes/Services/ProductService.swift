//
//  ServicioProducto.swift
//  EazyShoes
//
//  Created by DAMII on 10/12/24.
//

import Foundation

class ProductService{
    func obtenerProductos(genero: String, completion: @escaping (Result<[Product], Error>) -> Void) {
            let urlString = "https://sugary-wool-penguin.glitch.me/shoes?gender=\(genero.uppercased())"
            guard let url = URL(string: urlString) else { return }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: HttpRequestHelper.manejarError(error)])))
                    return
                }

                if let mensajeError = HttpRequestHelper.manejarRespuesta(response) {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: mensajeError])))
                    return
                }

                guard let data = data else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se recibieron datos del servidor."])))
                    return
                }

                do {
                    let productos = try JSONDecoder().decode([Product].self, from: data)
                    completion(.success(productos))
                } catch {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error al decodificar los datos: \(error.localizedDescription)"])))
                }
            }.resume()
        }
}
