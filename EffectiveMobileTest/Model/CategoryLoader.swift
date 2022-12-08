//
 //  CategoryLoad.swift
 //  EffectiveMobileTest
 //
 //  Created by Руслан Трищенков on 05.12.2022.
 //

 import Foundation

 enum SelectedCategory: CaseIterable {
     case phone
     case computer
     case health
     case books
     case other

     var title: String {
         switch self {
         case .phone:
             return "Phones"
         case .computer:
             return "Computer"
         case .health:
             return "Health"
         case .books:
             return "Books"
         case .other:
             return "Other"
         }
     }

     var imageName: String {
         switch self {
         case .phone:
             return "phone"
         case .computer:
             return "computer"
         case .health:
             return "health"
         case .books:
             return "books"
         case .other:
             return "other"
         }
     }
 }
