//
 //  HomePage.swift
 //  EffectiveMobileTest
 //
 //  Created by Руслан Трищенков on 05.12.2022.
 //

 import SwiftUI

 struct HomePage: View {
         @EnvironmentObject var cartManager: CartManager
         @StateObject var networkManager: NetworkServiceManager = NetworkServiceManager()
         @State private var isPresent: Bool = false
         @Binding var filterPresentation: Bool
         @State private var search: String = ""

     @State var citiesList = false
         let columns = [
             GridItem(.flexible()),
             GridItem(.flexible())
         ]
         var body: some View{
             VStack(spacing: 0){
                 HStack{
                     ZStack{
                         Button {

                         } label: {
                             HStack{
                                 Image("pin")
                                 Text("Zihuatanejo, Gro")
                                     .font(.custom(mainFont500, size: 15))
                                     .foregroundColor(Color.mainDarkBlue)

                                 Image(systemName: "chevron.down")
                                     .foregroundColor(Color.gray)
                             }
                         }
                         .frame(alignment: .center)

                         VStack(alignment: .trailing){
                             Button {
                                 filterPresentation.toggle()
                             } label: {
                                 Image("filter")
                                     .resizable()
                                     .aspectRatio(contentMode: .fit)
                                     .frame(width: 11, height: 13)
                             }
                             .frame(maxWidth: .infinity, alignment: .trailing)

                         }

                     }
                 }
                 .padding(.vertical)
                 .padding(.horizontal, 35)
                 .background(.white)

                 ScrollView(.vertical, showsIndicators: false){
                     VStack(spacing: 0){
                         HStack{
                             Text("Select Category")
                                 .font(.custom(mainFont700, size: 25))
                             Spacer()
                             Button {
                                 //
                             } label: {
                                 Text("view all")
                                     .font(.custom(mainFont400, size: 15))
                                     .foregroundColor(Color.mainOrange)
                             }
                         }
                         .padding(.vertical)
                         .padding(.leading, 17)
                         .padding(.trailing, 33)
                         .padding(.top, -10)


                         ScrollView(.horizontal, showsIndicators: false){
                             HStack(spacing: 23){
                                 ForEach(SelectedCategory.allCases, id: \.self) { category in
                                     selectedCategory(category: category)
                                         .onTapGesture {
                                             anumateSelectedCategory(category: category)
                                         }
                                 }
                             }
                             .padding(.vertical)
                             .padding(.horizontal, 27)
                         }
                         .padding(.top, -10)

                         HStack{
                             HStack(spacing: 20){
                                 Button {

                                 } label: {
                                     Image(systemName: "magnifyingglass")
                                         .foregroundColor(Color.mainOrange)
                                         .font(.title2)
                                 }

                                 TextField("Search", text: $search)
                                     .font(.custom(mainFont400, size: 12))
                                     .foregroundColor(Color.gray)
                             }
                             .padding(.vertical, 11)
                             .padding(.leading, 24)
                             .background(
                                 Capsule()
                                     .fill(.white)
                                     .shadow(color: .black.opacity(0.1), radius: 7)
                                     .frame(maxWidth: .infinity)
                             )

                             ZStack {
                                 Button {

                                 } label: {
                                     ZStack {
                                         Circle()
                                             .fill(Color.mainOrange)
                                         Image("qrButton")
                                             .resizable()
                                             .renderingMode(.template)
                                             .aspectRatio(contentMode: .fit)
                                             .frame(height: 20)
                                             .foregroundColor(Color.white)
                                     }
                                 }
                             }
                             .frame(maxWidth: 45)
                             .offset(x: 10)
                         }
                         .padding(.vertical)
                         .padding(.leading, 32)
                         .padding(.trailing, 32)

                         HStack{
                             Text("Hot Sales")
                                 .font(.custom(mainFont700, size: 25))
                             Spacer()
                             Button {

                             } label: {
                                 Text("see more")
                                     .font(.custom(mainFont400, size: 15))
                                     .foregroundColor(Color.mainOrange)
                             }
                         }
                         .padding(.top, 10)
                         .padding(.leading, 17)
                         .padding(.trailing, 33)

                         VStack {
                             TabView {
                                 ForEach(networkManager.shopModels.first?.homeStore ?? [], id: \.id) { data in
                                     hotSalesScroll(data: data)
                                 }
                             }
                             .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                             .shadow(color: Color.black.opacity(0.14), radius: 10)
                         }
                         .frame(height: 200)

                         HStack {
                             Text("Best seller")
                                 .font(.custom(mainFont700, size: 25))
                             Spacer()
                             Button {

                             } label: {
                                 Text("see more")
                                     .font(.custom(mainFont400, size: 15))
                                     .foregroundColor(Color.mainOrange)
                             }
                         }
                         .padding(.top, 10)
                         .padding(.trailing, 27)
                         .padding(.leading, 17)

                         LazyVGrid(columns: columns, spacing: 20) {
                             ForEach(networkManager.shopModels.first?.bestSeller ?? [], id: \.id) { bestSeller in
                                // sellerCard(bestSeller: bestSeller)
                                 NavigationLink {
                                     ProductCardPage()
                                 } label: {
                                     sellerCard(bestSeller: bestSeller)
                                 }
                             }
                         }
                         .padding(.horizontal, 13)
                         .padding(.vertical)

                     }
                 }
             }
             .onAppear{
                 networkManager.getData(){print("Getting Data")}
             }
         }
 }

 struct HomePage_Previews: PreviewProvider {
     static var previews: some View {
         HomePage(filterPresentation: .constant(false))
     }
 }

 extension HomePage {
     @ViewBuilder
     private func selectedCategory(category: SelectedCategory) -> some View {
         VStack {
             ZStack {
                 Circle()
                     .fill(networkManager.selectedCategory == category ? Color.mainOrange : Color.white)
                     .frame(width: 71, height: 71)
                     .shadow(color: .black.opacity(0.1), radius: 10)

                 Image(category.imageName)
                     .resizable()
                     .renderingMode(.template)
                     .aspectRatio(contentMode: .fit)
                     .frame(height: 30)
                     .foregroundColor(networkManager.selectedCategory == category ? Color.white : Color.black.opacity(0.3))
             }

             Text(category.title)
                 .font(.custom(mainFont500, size: 12))
                 .foregroundColor(networkManager.selectedCategory == category ? Color
                     .mainOrange: Color.black)
         }
         .background(Color.white)
     }
     private func anumateSelectedCategory(category: SelectedCategory) {
         withAnimation {
             networkManager.selectedCategory = category
         }
     }
 }

 extension HomePage {
     @ViewBuilder
     private func hotSalesScroll(data: HomeStore) -> some View {
         HStack {
             VStack(alignment: .leading) {

                 if let _ = data.isNew {
                     Text("New")
                         .font(.custom(mainFont700, size: 10))
                         .foregroundColor(Color.white)
                         .padding(8)
                         .background(
                             Circle()
                                 .fill(Color.mainOrange)
                         )
                         .padding(.leading, -5)
                 }

                 VStack(alignment: .leading) {
                     Text(data.title ?? "")
                         .font(.custom(mainFont700, size: 25))
                         .foregroundColor(Color.white)
                     Text(data.subtitle ?? "")
                         .font(.custom(sfProDisplay, size: 11))
                         .foregroundColor(Color.white)
                 }
                 Spacer()
                 Text("Buy now!")
                     .font(.custom(sfProDisplay, size: 11).bold())
                     .padding(.vertical, 7)
                     .padding(.horizontal, 27)
                     .background(
                         RoundedRectangle(cornerRadius: 5)
                             .fill(Color.white)
                     )
             }
             Spacer()
         }
         .frame(maxWidth: .infinity)
         .padding()
         .padding(.horizontal, 6)
         .background(
             AsyncImages(url: data.picture ?? "")
                 .frame(height: 182)
                 .clipShape(RoundedRectangle(cornerRadius: 12))
         )
         .padding()
     }
 }

 extension HomePage {
     @ViewBuilder
     private func sellerCard(bestSeller: BestSeller) -> some View {
         VStack(spacing: 0) {
             ZStack {
                 AsyncImages(url: bestSeller.picture)
                     .aspectRatio(contentMode: .fill)
                     .frame(width: UIScreen.main.bounds.width / 2.3, height: UIScreen.main.bounds.height / 4, alignment: .center)
                     .clipped()
                 VStack {
                     HStack() {
                         Spacer()
                         ZStack {

                             Image(systemName: bestSeller.isFavorites! ? "heart.fill" : "heart")
                                 .resizable()
                                 .aspectRatio(contentMode: .fit)
                                 .frame(height: 11)
                                 .foregroundColor(Color.mainOrange)
                                 .background(
                                     Circle()
                                         .fill(.white)
                                         .frame(width: 25, height: 25)
                                         .shadow(color: .black.opacity(0.1), radius: 10)
                                 )
                         }
                     }
                     .frame(maxWidth: .infinity)
                     Spacer()
                 }
                 .frame(maxHeight: .infinity)
                 .padding()

             }

             HStack(alignment: .bottom) {
                 Text("$" + "\(bestSeller.priceWithoutDiscount)")
                     .font(.custom(mainFont700, size: 16))
                     .foregroundColor(Color.mainDarkBlue)
                 Text("$" + "\(bestSeller.discountPrice)")
                     .font(.custom(mainFont500, size: 10))
                     .foregroundColor(Color.black.opacity(0.3))
                 Spacer()
             }
             .padding(.horizontal, 16)

             HStack {
                 Text(bestSeller.title)
                     .font(.custom(mainFont400, size: 10))
                     .foregroundColor(Color.mainDarkBlue)
                 Spacer()

             }
             .padding(.horizontal, 16)
             .padding(.bottom)


         }
         .frame(width: UIScreen.main.bounds.width / 2.3, height: UIScreen.main.bounds.height / 3)
         .background(
             RoundedRectangle(cornerRadius: 12)
                 .fill(.white)
                 .shadow(color: Color.black.opacity(0.1), radius: 12)
         )
     }
 }
