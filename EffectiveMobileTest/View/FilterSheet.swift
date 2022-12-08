//
 //  FilterSheet.swift
 //  EffectiveMobileTest
 //
 //  Created by Руслан Трищенков on 06.12.2022.
 //

 import SwiftUI

 struct FilterSheet: View{
     @Binding var isActiveFilter: Bool
     var brand = ["Samsung", "Apple", "Xiaomi"]
     var price = ["$0 - $300", "$300 - $500", "$500 - $1000"]
     var size = ["4.5 to 5.5 inches", "5.5 to 7.0 inches"]
     @State private var selectedBrand = 0
     @State private var selectedPrice = 0
     @State private var selectedSize = 0
     var body: some View{
         VStack(spacing: 0){
             VStack(alignment: .leading, spacing: 0){
                 HStack(spacing: 0){
                     Button {
                         isActiveFilter.toggle()
                     } label: {
                         Image(systemName: "xmark")
                     }
                     .foregroundColor(Color.white)
                     .frame(width: 37, height: 37)
                     .background(Color.mainDarkBlue)
                     .cornerRadius(10)

                     Spacer()

                     Text("Filter options")
                         .font(.custom(mainFont500, size: 18))

                     Spacer()

                     Button {
                     //Filter function
                     } label: {
                         Text("Done")
                             .foregroundColor(Color.white)
                             .font(.custom(mainFont500, size: 18))
                             .frame(width: 86, height: 37)
                             .background(Color.mainOrange)
                             .cornerRadius(10)
                             .padding(.trailing, 20)
                     }

                 }
                 .padding(.top, 0)

                 FilterSections(indexCell: $selectedBrand, text: "Brand", arrayText: brand)
                     .padding(.top, 40)
                 FilterSections(indexCell: $selectedPrice, text: "Price", arrayText: price)
                     .padding(.top, 20)
                 FilterSections(indexCell: $selectedSize, text: "Size", arrayText: size)
                     .padding(.top, 20)
             }
             .padding(.leading, 44)
         }
         .frame(width: UIScreen.main.bounds.width, height: 380)
         .background(Color.white)
         .cornerRadius(30)
         .shadow(color: Color.mainShadow, radius: 20)
     }
 }


 struct FilterSheet_Previews: PreviewProvider {
     static var previews: some View {
         FilterSheet(isActiveFilter: .constant(true))
     }
 }

 struct FilterSections: View{
     @Binding var indexCell: Int

     @State var text: String
     var arrayText: [String]

     var body: some View{
         VStack(alignment: .leading, spacing: 0){
             Text(text)
                 .font(.custom(mainFont500, size: 18))
                 .foregroundColor(Color.mainDarkBlue)
                 .padding(.bottom, 2)

             Menu{
                 Picker(text, selection: $indexCell){
                     ForEach(arrayText, id: \.self) { index in
                         Text(index)
                             .font(.custom(mainFont400, size: 18))
                             .onTapGesture {
                                 text = index

                             }

                     }
                 }
             } label: {
                 HStack(alignment: .center, spacing: 0){
                     ZStack{
                         RoundedRectangle(cornerRadius: 5)
                             .stroke(Color.mainLigthGray)
                             .foregroundColor(Color.white)
                             .frame(height: 37)

                         Image(systemName: "chevron.down")
                             .padding(.leading, 250)
                             .foregroundColor(Color.gray)
                     }
                 }
                 .overlay(
                     Text("\(arrayText[indexCell])")
                         .font(.custom(mainFont500, size: 18))
                         .foregroundColor(Color.mainDarkBlue)
                         .padding(.leading, -140)
                 )
             }
             .frame(width: 310, height: 37)
             .padding(.top, 5)
         }
         .shadow(color: Color.mainShadow, radius: 20)
     }
 }
