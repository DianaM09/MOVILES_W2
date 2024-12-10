//
//  MainView.swift
//  EazyShoes
//
//  Created by DAMII on 10/12/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        
        TabView {
            ProductListView()
                .tabItem {
                    Image(systemName: "shoeprints.fill")
                    Text("Shoes")
                }

            FavoriteListView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
        }
        .accentColor(.orange) 
    }
}

#Preview {
    MainView()
}
