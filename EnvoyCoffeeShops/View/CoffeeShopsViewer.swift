//
//  CoffeeShopsViewer.swift
//  EnvoyCoffeeShops
//
//  Created by Akshay Yadav on 2/23/25.
//

import SwiftUI

public struct CoffeeShopsViewer: View {
    
    @Bindable
    var viewModel = CoffeeShopsViewModel()
    
    public var body: some View {
        NavigationStack {
            CoffeeShopsView(
                coffeeShops: $viewModel.coffeeShops
            ) {
                Task {
                    await viewModel.loadMore()
                }
            }
            .onAppear {
                Task {
                    await viewModel.loadMore()
                }
            }
            .padding(0)
            .navigationBarTitle("Coffee Shops")
            .toolbarBackground(.navbarBackground2, for: .navigationBar)
        }
        
    }
    
    private struct CoffeeShopsView: View {
        
        @Binding
        var coffeeShops: [CoffeeShop]
        
        let loadMore: () -> Void
        
        public var body: some View {
            
            List(coffeeShops) { coffeeShop in
                CoffeeShopListItemView(
                    title: coffeeShop.name,
                    imageURL: coffeeShop.imageURL(),
                    address: coffeeShop.location?.display_address, price: coffeeShop.price,
                    phone: coffeeShop.phone,
                    distance: coffeeShop.distanceString(),
                    url: coffeeShop.websiteURL()
                )
                .padding(.top)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .background(.customListBackground2)
                .onAppear {
                    if (coffeeShops.last?.id == coffeeShop.id) {
                        loadMore()
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(.customListBackground2)
        }
    }
}

#Preview {
        CoffeeShopsViewer()
}
