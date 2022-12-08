//
 //  CartModel.swift
 //  EffectiveMobileTest
 //
 //  Created by Руслан Трищенков on 06.12.2022.
 //

 import Foundation
 import SwiftUI

 class CartManager: ObservableObject {
     @Published var products: [Basket] = []
     @Published var total: Int = 0
     @Published var delivery: String = "Free"

     func onIncrement(product: Basket) {
         if products == products.filter({$0.id != product.id}) {
             products.append(product)
             total += product.price ?? 0
         } else {
             total += product.price ?? 0
         }
     }

     func onDecrement(product: Basket) {
         if products == products.filter({$0.id == product.id}) {
             total -= product.price ?? 0
         }
     }

     func removeProductFromPage(product: Basket) {
         products = products.filter({$0.id != product.id})
         total -= (product.price ?? 0) * (product.count ?? 0)
     }
 }
