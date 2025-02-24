//
//  BulletTextStyle.swift
//  EnvoyCoffeeShops
//
//  Created by Akshay Yadav on 2/23/25.
//

import SwiftUI

struct BulletTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fontDesign(.monospaced)
            .fontWeight(.bold)
            .foregroundStyle(.bulletText)
    }
}
