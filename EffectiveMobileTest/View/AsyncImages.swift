//
 //  AsyncImages.swift
 //  EffectiveMobileTest
 //
 //  Created by Руслан Трищенков on 05.12.2022.
 //

 import SwiftUI

 struct AsyncImages: View {
     @StateObject private var loader: LoadImage

     init(url: String) {
         _loader = StateObject(wrappedValue: LoadImage(url: url))
     }

     var body: some View {
         content
             .onAppear(perform: loader.loadData)
     }

     private var content: some View {
         Group {
             if loader.image != nil {
                 Image(uiImage: loader.image!)
                     .resizable()
             } else {
                 Image(systemName: "heart")
             }
         }
     }
 }
