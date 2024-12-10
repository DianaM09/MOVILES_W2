//
//  HttpRequestHelper.swift
//  EazyShoes
//
//  Created by DAMII on 10/12/24.
//

import Foundation

class HttpRequestHelper {
    static func manejarRespuesta(_ respuesta: URLResponse?) -> String? {
        guard let httpResponse = respuesta as? HTTPURLResponse else {
            return "Respuesta inválida del servidor."
        }

        switch httpResponse.statusCode {
        case 200...299:
            return nil
        case 400:
            return "Solicitud incorrecta (400)."
        case 401:
            return "No autorizado (401)."
        case 403:
            return "Prohibido (403)."
        case 404:
            return "Recurso no encontrado (404)."
        case 500:
            return "Error interno del servidor (500)."
        default:
            return "Error desconocido: \(httpResponse.statusCode)."
        }
    }

    static func manejarError(_ error: Error) -> String {
        return "Ocurrió un error: \(error.localizedDescription)"
    }
}
