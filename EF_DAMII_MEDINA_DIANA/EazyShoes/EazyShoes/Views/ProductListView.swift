//
//  ProductListView.swift
//  EazyShoes
//
//  Created by DAMII on 10/12/24.
//

import SwiftUI
import CoreData

struct ProductListView: View {
    @StateObject private var vistaModelo = ProductListViewModel()
    @State private var generoSeleccionado = "WOMEN"
    @State private var favoritos: [FavoriteProduct] = []

    let generos = ["WOMEN", "MEN", "KIDS"]

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.black, .gray]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            VStack {
                // Título
                Text("EazyShoes")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.orange)
                    .padding(.top)

                // Botones de selección de género
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(generos, id: \.self) { genero in
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    generoSeleccionado = genero
                                    vistaModelo.cargarProductos(genero: genero)
                                }
                            }) {
                                Text(genero.capitalized)
                                    .font(.headline)
                                    .padding()
                                    .frame(minWidth: 100)
                                    .background(
                                        generoSeleccionado == genero
                                            ? Color.orange
                                            : Color.white.opacity(0.1)
                                    )
                                    .foregroundColor(
                                        generoSeleccionado == genero
                                            ? .black
                                            : .white
                                    )
                                    .cornerRadius(20)
                                    .shadow(
                                        color: generoSeleccionado == genero
                                            ? Color.orange.opacity(0.6)
                                            : Color.clear,
                                        radius: 8, x: 0, y: 4
                                    )
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer().frame(height: 20)

                // Contenido principal con transición
                ZStack {
                    if vistaModelo.cargando {
                        ProgressView()
                            .foregroundColor(.white)
                            .transition(.opacity.animation(.easeInOut))
                    } else if let mensajeError = vistaModelo.mensajeError {
                        Text("Error: \(mensajeError)")
                            .foregroundColor(.red)
                            .padding()
                            .multilineTextAlignment(.center)
                            .transition(.opacity.animation(.easeInOut))
                    } else {
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                                ForEach(vistaModelo.productos) { producto in
                                    CeldaProducto(producto: producto, favoritos: $favoritos)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(Color.white.opacity(0.1))
                                                .shadow(radius: 5)
                                        )
                                        .padding(5)
                                        .transition(.scale.animation(.easeInOut(duration: 0.3)))
                                }
                            }
                            .padding()
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding()
            .onAppear {
                withAnimation(.easeInOut(duration: 0.3)) {
                    vistaModelo.cargarProductos(genero: generoSeleccionado)
                }
                cargarFavoritos()
            }
        }
    }

    private func cargarFavoritos() {
        let contexto = PersistenceController.shared.container.viewContext
        let request = NSFetchRequest<FavoriteProduct>(entityName: "FavoriteProduct")
        do {
            favoritos = try contexto.fetch(request)
        } catch {
            print("Error al cargar favoritos: \(error)")
        }
    }
}

#Preview {
    ProductListView()
}
