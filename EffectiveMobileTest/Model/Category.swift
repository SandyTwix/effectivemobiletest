//
 //  Category.swift
 //  EffectiveMobileTest
 //
 //  Created by Руслан Трищенков on 05.12.2022.
 //

 import Foundation

 class Category {
     var id: Int
     var image: String
     var text: String

     init(id: Int?, image: String?, text: String?) {
         self.id = id ?? 0
         self.image = image ?? ""
         self.text = text ?? ""
     }
 }
