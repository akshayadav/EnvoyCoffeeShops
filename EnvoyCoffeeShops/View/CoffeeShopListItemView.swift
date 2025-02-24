//
//  CoffeeShopListItemView.swift
//  EnvoyCoffeeShops
//
//  Created by Akshay Yadav on 2/23/25.
//

import SwiftUI

struct CoffeeShopListItemView: View {
    @Environment(\.openURL) private var openURL
    
    let title: String
    var imageURL: URL?
    var address: [String]?
    var price: String?
    var phone: String?
    var distance: String?
    var url: URL?
    
    @ScaledMetric
    private var scale: CGFloat = 1
    
    var body: some View {
        VStack(spacing: 10.0) {
            HStack(alignment: .top, spacing: 20) {
                Group {
                    if let imageURL = imageURL {
                        AsyncImage(url: imageURL) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 120, height: 120)
                                    .background(Color.secondary.opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            case .success(let image):
                                image
                                    .resizable()
                                    .frame(width: 120, height: 120)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            case .failure(_):
                                Image(systemName: "exclamationmark.icloud")
                            @unknown default:
                                Image(systemName: "exclamationmark.icloud")
                            }
                        }
                    }
                }
                
                VStack(spacing: 10) {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.medium)
                        .fontDesign(.serif)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                        .foregroundStyle(.customForeground)
                        .fixedSize(horizontal: false, vertical: true)
                    VStack(alignment: .leading, spacing: 10) {
                        if let price {
                            bulletPointView(text: price)
                        }
                        if let address {
                            bulletPointView(text: address.joined(separator: ", "))
                        }
                        
                    }
                    
                }
            }
            Divider()
            ViewThatFits {
                HStack {
                    if let phone {
                        Text("\(Image(systemName: "phone.fill")) \(phone == "" ? "Not Available" : phone)")
                    }
                    Spacer()
                    if let distance {
                        Text("\(Image(systemName: "mappin.and.ellipse")) \(distance)")
                    }
                    Spacer()
                    if let url {
                        Button {
                            openURL(url)
                        } label: {
                            Image("yelp")
                                .resizable()
                                .frame(width: 15 * scale, height: 15 * scale)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                }
                VStack {
                    if let phone {
                        Text("\(Image(systemName: "phone.fill")) \(phone == "" ? "Not Available" : phone)")
                    }
                    Spacer()
                    if let distance {
                        Text("\(Image(systemName: "mappin.and.ellipse")) \(distance)")
                    }
                    Spacer()
                    if let url {
                        Button {
                            openURL(url)
                        } label: {
                            Image("yelp")
                                .resizable()
                                .frame(width: 15 * scale, height: 15 * scale)
                        }
                    }
                    
                }
            }
            .foregroundStyle(.customForeground)
            .font(.footnote)
            
        }
        .padding()
        .background(.customListItemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    @ViewBuilder
    fileprivate func bulletPointView(text: String) -> some View {
        HStack(alignment: .top) {
            Text("•")
                .modifier(BulletTextStyle())
            Text(text)
            .modifier(CustomTextStyle())
            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    CoffeeShopListItemView(
        title: "Ooh La La Coffee",
        price: "$"
    )
    .padding()
    
    CoffeeShopListItemView(
        title: "Ooh La La Coffee",
        address: ["223 Baker St", "New York, NY 10012"], price: "$$$",
        phone: "(999) 999-9999",
        distance: "2.8 miles",
        url: URL(string: "https:\\www.google.com")
    )
    .padding()
}
