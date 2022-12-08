//
 //  CartModel.swift
 //  EffectiveMobileTest
 //
 //  Created by Руслан Трищенков on 06.12.2022.
 //

 import Foundation

 struct CartModel: Codable {
     let basket: [Basket]
     let delivery, id: String?
     let total: Int?
 }

 struct Basket: Codable, Hashable {
     let id: Int?
     let images: String?
     let price: Int?
     let title: String?
     var count: Int?
 }
