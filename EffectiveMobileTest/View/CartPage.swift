//
 //  CartPage.swift
 //  EffectiveMobileTest
 //
 //  Created by Руслан Трищенков on 06.12.2022.
 //

 import SwiftUI

 struct CartPage: View {
     @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
     @EnvironmentObject var cartManager: CartManager
     let width: CGFloat = UIScreen.main.bounds.width

     var body: some View {
         VStack(spacing: 0) {
             VStack(spacing: 0) {
                 CartNaviganionBarView()

                 HeaderView()
                     .padding(.top, 40)

                 Spacer()

                 VStack(spacing: 0)  {
                     ScrollView(showsIndicators: false) {
                         VStack(spacing: 35) {
                             ForEach(cartManager.products, id: \.id) { index in
                                 ProductView(product: index)
                             }
                         }
                     }
                     .frame(width: width,height: 320)
                     .padding(.top, 35)

                     Divider()
                         .frame(width: 380, height: 2)
                         .background(Color.white.opacity(0.25))
                         .padding(.top, 6)

                     CartTotalView()

                     Divider()
                         .frame(width: 414, height: 1)
                         .background(Color.white.opacity(0.2))
                         .padding(.top, 26)

                     Button {
                         self.presentationMode.wrappedValue.dismiss()
                         
                     } label: {
                         HStack {
                             Text("Checkout")
                                 .font(.custom(mainFont700, size: 20))
                                 .foregroundColor(Color.white)
                         }
                     }
                     .frame(width: 326, height: 54)
                     .background(Color.mainOrange)
                     .cornerRadius(10)
                     .padding(.top, 27)
                 }
                 .frame(width: width, height: 610)
                 .background(Color.mainDarkBlue)
                 .cornerRadius(30)
                 .shadow(color: Color.mainShadow, radius: 20)
                 .padding(.top, 40)
             }
             .padding(.top, 79)
             .navigationBarBackButtonHidden()
         }
         .ignoresSafeArea()
         .background(Color.mainGray)
     }
 }

 struct CartPage_Previews: PreviewProvider {
     static var previews: some View {
         CartPage()
             .environmentObject(CartManager())
     }
 }

 struct CartNaviganionBarView: View {
     @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

     var body: some View {
         HStack(spacing: 0) {
             Button {
                 self.presentationMode.wrappedValue.dismiss()
             } label: {
                 Image(systemName: "chevron.left")
                     .foregroundColor(Color.white)
             }
             .frame(width: 37, height: 37)
             .background(Color.mainDarkBlue)
             .cornerRadius(10)
             .padding(.leading, 42)

             Spacer()

             Text("Add address")
                 .font(.custom(mainFont500, size: 15))
                 .foregroundColor(Color.mainDarkBlue)
                 .padding(.trailing, 9)

             Button {
                 print("Map open")
             } label: {
                 Image("location")
                     .resizable()
                     .frame(width: 14, height: 17.87)
             }
             .frame(width: 37, height: 37)
             .background(Color.mainOrange)
             .cornerRadius(10)
             .padding(.trailing, 46)
         }
     }
 }

 struct HeaderView: View {
     var body: some View {
         HStack(spacing: 0) {
             Text("My Cart")
                 .font(.custom(mainFont700, size: 35))
                 .foregroundColor(Color.mainDarkBlue)

             Spacer()
         }
         .padding(.leading, 42)
     }
 }

 struct ProductView: View {
     @EnvironmentObject var cartManager: CartManager
     @State var stepperValue: Int = 0
     @State var product: Basket

     var body: some View {
         HStack(spacing: 0) {
             ZStack {
                 Color.white

                 AsyncImage(url: URL(string: product.images ?? "")) { imageUrl in
                     if let image = imageUrl.image {
                         image
                             .resizable()
                             .scaledToFill()
                             .frame(width: 88, height: 88)
                             .clipped()
                     }
                 }
             }
             .frame(width: 88, height: 88)
             .overlay(
                 RoundedRectangle (cornerRadius: 17)
                     .stroke(lineWidth: 0.5)
             )
             .cornerRadius(17)
             .shadow(radius: 5)
             .padding(.leading, 33)

             VStack(alignment: .leading, spacing: 0) {
                 Text("\(product.title ?? "")")
                     .font(.custom(mainFont500, size: 20))
                     .foregroundColor(Color.white)

                 Text("$\(product.price ?? 0).00")
                     .font(.custom(mainFont500, size: 20))
                     .foregroundColor(Color.mainOrange)
                     .padding(.top, 7)

             }
             .frame(height: 88)
             .padding(.leading, 17)

             Spacer()

             StepperSheet(text: product.count ?? 0, value: $stepperValue, range: 1...100, step: 1, onIncrement: {
                 product.count = stepperValue
                 cartManager.onIncrement(product: product)
             }, onDecrement: {
                 product.count = stepperValue
                 cartManager.onDecrement(product: product)
             })
             .padding(.trailing, 17)

             Button {
                 print("Remove item")
                 cartManager.removeProductFromPage(product: product)
             } label: {
                 Image("remove")
                     .resizable()
                     .frame(width: 14.75,height: 16)
                     .foregroundColor(Color.mainDarkGray)
             }
             .padding(.trailing, 32)
         }
         .frame(width: UIScreen.main.bounds.width)
     }
 }

 struct CartTotalView: View {
     @EnvironmentObject var cartManager: CartManager

     var body: some View {
         HStack(alignment: .center, spacing: 0) {
             VStack(alignment: .leading, spacing: 0) {
                 Text("Total")
                     .font(.custom(mainFont400, size: 15))
                     .foregroundColor(Color.white)

                 Text("Delivery")
                     .font(.custom(mainFont400, size: 15))
                     .foregroundColor(Color.white)
                     .padding(.top, 12)
             }
             .padding(.leading, 55)
             .padding(.top, 15)

             Spacer()

             VStack(alignment: .leading, spacing: 0) {
                 Text("$\(cartManager.total) us")
                     .font(.custom(mainFont700, size: 15))
                     .foregroundColor(Color.white)
                     .environmentObject(cartManager)

                 Text(cartManager.delivery)
                     .font(.custom(mainFont700, size: 15))
                     .foregroundColor(Color.white)
                     .padding(.top, 12)
                     .environmentObject(cartManager)
             }
             .padding(.trailing, 35)
             .padding(.top, 15)
         }
     }
 }
