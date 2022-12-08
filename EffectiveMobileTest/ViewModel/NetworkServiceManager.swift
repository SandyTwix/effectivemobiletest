//
 //  NetworkServiceManager.swift
 //  EffectiveMobileTest
 //
 //  Created by Руслан Трищенков on 05.12.2022.
 //

 import Foundation
 import SwiftUI

 class NetworkServiceManager: ObservableObject {
     @Published var shopModels: [ShopModel] = []
     @Published var productCartModels: [ProductCartModel] = []
     @Published var cartModels: [CartModel] = []
     @Published var selectedCategory: SelectedCategory = .phone
     @Published var productCarousel: Int = 0
     @Published var image: UIImage = UIImage()

     func getData(completion: @escaping () -> ()) {
         guard let url = URL(string: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175") else { return }

         URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
             guard let data = data, error == nil else { return }

             do {
                 let model = try JSONDecoder().decode(ShopModel.self, from: data)
                 DispatchQueue.main.async {
                     self?.shopModels.append(model)
                     completion()
                 }
             } catch {
                 print("Failed to decode JSON, \(error.localizedDescription)")
             }
         }
         .resume()
     }

     func getProductDetails(completion: @escaping () -> ()) {
         guard let url = URL(string: "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5") else { return }

         URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
             guard let data = data, error == nil else { return }

             do {
                 let model = try JSONDecoder().decode(ProductCartModel.self, from: data)
                 DispatchQueue.main.async {
                     self?.productCartModels.append(model)
                     completion()
                 }
             } catch {
                 print("Failed to decode JSON, \(error.localizedDescription)")
             }
         }
         .resume()
     }

     func getCart(completion: @escaping () -> ()) {
         guard let url = URL(string: "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149") else { return }

         URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
             guard let data = data, error == nil else { return }

             do {
                 let model = try JSONDecoder().decode(CartModel.self, from: data)
                 DispatchQueue.main.async {
                     self?.cartModels.append(model)
                     completion()
                 }
             } catch {
                 print("Failed to decode JSON, \(error.localizedDescription)")
             }
         }
         .resume()
     }
 }
