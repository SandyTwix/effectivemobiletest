//
 //  ColorHex.swift
 //  EffectiveMobileTest
 //
 //  Created by Руслан Трищенков on 07.12.2022.
 //

 import SwiftUI

 extension Color {
     init?(hex: String) {
         var localhex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
         localhex = localhex.replacingOccurrences(of: "#", with: "")
         var rgb: UInt64 = 0
         var red: CGFloat = 0.0
         var green: CGFloat = 0.0
         var blue: CGFloat = 0.0
         var alpha: CGFloat = 0.0

         let len = localhex.count

         guard Scanner(string: localhex).scanHexInt64(&rgb) else { return nil }

         if len == 6 {
             red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
             green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
             blue = CGFloat(rgb & 0x0000FF) / 255.0
             alpha = 1.0
         } else if len == 8 {
             red = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
             green = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
             blue = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
             alpha = CGFloat(rgb & 0x000000FF) / 255.0
         } else {
             return nil
         }

         self.init(red: red, green: green, blue: blue, opacity: alpha)

     }
 }
