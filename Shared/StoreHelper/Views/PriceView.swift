//
//  PriceView.swift
//  StoreHelper
//
//  Created by Russell Archer on 21/06/2021.
//

import SwiftUI
import StoreKit

/// Displays a product price and a button that enables purchasing.
struct PriceView: View {
    @EnvironmentObject var storeHelper: StoreHelper
    @State private var canMakePayments: Bool = false
    @Binding var purchaseState: PurchaseState
    
    var productId: ProductId
    var price: String
    var product: Product
    
    var body: some View {
        
        let priceViewModel = PriceViewModel(storeHelper: storeHelper, purchaseState: $purchaseState)
        
        HStack {
            
            #if os(iOS)
            Button(action: {
                withAnimation { purchaseState = .inProgress }
                Task.init { await priceViewModel.purchase(product: product) }
            }) {
                if canMakePayments {
                    Text(price)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 95, height: 40)
                        .fixedSize()
                        .background(Color.blue)
                        .cornerRadius(25)
                        .padding(.leading, 10)
                } else {
                    Text("Disabled")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 95, height: 40)
                        .fixedSize()
                        .background(Color.blue)
                        .cornerRadius(25)
                        .padding(.leading, 10)
                }
            }
            .disabled(!canMakePayments)
            #elseif os(macOS)
            HStack {
                if canMakePayments {
                    Text(price)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 100, height: 40)
                        .fixedSize()
                        .background(Color.blue)
                        .cornerRadius(25)
                        .padding(.leading, 10)
                } else {
                    Text("Disabled")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 100, height: 40)
                        .fixedSize()
                        .background(Color.blue)
                        .cornerRadius(25)
                        .padding(.leading, 10)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation { purchaseState = .inProgress }
                Task.init { await priceViewModel.purchase(product: product) }
            }
            #endif
        }
        .onAppear { canMakePayments = AppStore.canMakePayments }
    }
}

struct PriceView_Previews: PreviewProvider {

    static var previews: some View {
        HStack {
            Button(action: {}) {
                Text("£1.98")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(height: 40)
                    .background(Color.blue)
                    .cornerRadius(25)
            }
        }
        .padding()
    }
}

