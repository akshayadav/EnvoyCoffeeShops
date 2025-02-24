//
//  CustomTextViewStyle.swift
//  EnvoyCoffeeShops
//
//  Created by Akshay Yadav on 2/23/25.
//

import SwiftUI

struct CustomTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.customForeground)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
