//
//  FavoriteListView.swift
//  EazyShoes
//
//  Created by DAMII on 10/12/24.
//

import SwiftUI

struct FavoriteListView: View {
    @StateObject private var vistaModelo = FavoriteListViewModel()

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
                Text("Favoritos")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.orange)
                    .padding()

                if vistaModelo.favoritos.isEmpty {
                    VStack {
                        Image(systemName: "heart.slash.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                            .padding(.bottom, 10)
                        
                        Text("No tienes productos en favoritos.")
                            .font(.headline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .transition(.opacity.animation(.easeInOut))
                } else {
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(vistaModelo.favoritos, id: \.id) { favorito in
                                HStack(spacing: 15) {
                                    // Imagen del producto
                                    AsyncImage(url: URL(string: favorito.imagen ?? "")) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 80, height: 80)
                                            .cornerRadius(10)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 80, height: 80)
                                    }

                                    // Información del producto
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(favorito.nombre ?? "Producto")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .lineLimit(1)
                                        Text(favorito.marca ?? "Marca")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        Text("$\(Int(favorito.precio))")
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .foregroundColor(.orange)
                                    }

                                    Spacer()

                                    // Botón de eliminar
                                    Button(action: {
                                        withAnimation(.easeInOut) {
                                            vistaModelo.eliminarFavorito(favorito: favorito)
                                        }
                                    }) {
                                        Image(systemName: "trash")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(.red)
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white.opacity(0.1))
                                )
                                .shadow(radius: 5)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .padding()
            .onAppear {
                withAnimation(.easeInOut(duration: 0.3)) {
                    vistaModelo.cargarFavoritos()
                }
            }
        }
    }
}

#Preview {
    FavoriteListView()
}
