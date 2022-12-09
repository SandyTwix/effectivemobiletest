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
     
         @Binding var showStrokeBorder: Bool
         @Binding var showSplash: Bool
         @Binding var showSplashTilted: Bool
         @Binding var showHeart: Bool
     
     var onTap: () -> Void
     
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
     
     // MARK: Category Functions
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
     
     
     // MARK: Hot sales Scroll
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
     
     // MARK: Seller Card Functions
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
                             
                             Image(systemName: "heart")
                                 .frame(width: 26, height: 26)
                                 .foregroundColor(Color.mainOrange)
                                 .aspectRatio(contentMode: .fit)

                             Circle() 
                                 .strokeBorder(lineWidth: showStrokeBorder ? 1 : 35/2,
                                               antialiased: false)
                                 .opacity(showStrokeBorder ? 0 : 1)
                                 .frame(width: 35, height: 35)
                                 .foregroundColor(.purple)
                                 .scaleEffect(showStrokeBorder ? 1 : 0)
                                 .animation(Animation.easeInOut(duration: 0.5))

                             Image("splash")
                                             .resizable()
                                             .aspectRatio(contentMode: .fit)
                                             .opacity(showSplash ? 0 : 1)
                                             .frame(width: 48, height: 48)
                                             .scaleEffect(showSplash ? 1 : 0)
                                             .animation(Animation.easeInOut(duration: 0.5).delay(0.1))

                             Image("splash_tilted")
                                             .resizable()
                                             .aspectRatio(contentMode: .fit)
                                             .opacity(showSplashTilted ? 0 : 1)
                                             .frame(width: 50, height: 50)
                                             .scaleEffect(showSplashTilted ? 1.1 : 0)
                                             .scaleEffect(1.1)
                                             .animation(Animation.easeOut(duration: 0.5).delay(0.1))

                                         Image(systemName: "heart.fill")
                                             .aspectRatio(contentMode: .fit)
                                             .frame(width: 26, height: 26)
                                             .foregroundColor(.pink)
                                             .scaleEffect(showHeart ? 1.1 : 0)
                                             .animation(Animation.interactiveSpring().delay(0.2))
                         }
                         .onTapGesture() {
                                     self.showHeart.toggle()
                                     onTap()
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

 struct HomePage_Previews: PreviewProvider {
     static var previews: some View {
         HomePage(filterPresentation: .constant(false), showStrokeBorder: .constant(false), showSplash: .constant(false), showSplashTilted: .constant(false), showHeart: .constant(false), onTap: { print("Like")
         })
     }
 }

