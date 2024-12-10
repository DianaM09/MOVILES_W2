import Foundation

// Respuesta de la API
struct Product: Decodable, Identifiable {
    let id: Int
    let name: String
    let brand: String
    let gender: String
    let category: String
    let price: Double
    let sizesAvailable: [SizeAvailable] // Cambiado a [SizeAvailable] en lugar de [[String: Any]]
    let image: String
    var isLiked: Bool = false // Añadido: estado de "me gusta"
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case brand
        case gender
        case category
        case price
        case sizesAvailable = "sizes_available" // Mapeo del campo de tamaños disponibles
        case image
    }
}

// Tamaño disponible
struct SizeAvailable: Decodable {
    let size: Double
    let quantity: Int
    
    enum CodingKeys: String, CodingKey {
        case size
        case quantity
    }
}
