
//  LoadingPage.swift
//  EffectiveMobileTest
//
//  Created by Руслан Трищенков on 05.12.2022.
//

import SwiftUI

struct LoadingPage: View {
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var networkManager: NetworkServiceManager
    @State private var isActive = false
    @State private var opacity = 0.0
    @State var filterPresentation: Bool = false

    var body: some View{
        if isActive {
            ZStack {
                if filterPresentation {
                    VStack(spacing: 0) {
                        Spacer()

                        FilterSheet(isActiveFilter: $filterPresentation)

                    }
                    .zIndex(1)
                    .ignoresSafeArea()
                }

                NavigationView {
                    TabBar(filterPresentation: $filterPresentation)
                }
            }
        } else {
            ZStack {
                Color.mainDarkBlue

                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 132)
                    .opacity(opacity)
            }
            .ignoresSafeArea()
            .task {
                networkManager.getData {
                    networkManager.getProductDetails {
                        networkManager.getCart {
                            updatedData {
                                self.isActive = true
                            }
                        }
                    }
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1)) {
                    self.opacity = 1.0
                }
            }
        }
    }

    func updatedData(completion: @escaping () -> ()) {
        cartManager.products = networkManager.cartModels.first?.basket ?? []
        cartManager.total = networkManager.cartModels.first?.total ?? 0
        cartManager.delivery = networkManager.cartModels.first?.delivery ?? ""

        cartManager.products[0].count = 1
        cartManager.products[1].count = 1
        completion()
    }
}

struct LoadingPage_Previews: PreviewProvider {
    static var previews: some View {
        LoadingPage()
            .environmentObject(CartManager())
            .environmentObject(NetworkServiceManager())
    }
}


struct TabBar: View{
    @Binding var filterPresentation: Bool
    @State var isPresentedCart: Bool = false
    @State var selectedIndex: Int = 0

    init(filterPresentation: Binding<Bool>) {
        _filterPresentation = filterPresentation

        UITabBar.appearance().isHidden = true
    }

var body: some View {
    ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            TabView(selection: $selectedIndex) {
                HomePage(filterPresentation: $filterPresentation)
                    .ignoresSafeArea(.all, edges:.all)
                    .tag(0)

                LikePage()
                    .ignoresSafeArea(.all, edges:.all)
                    .tag(2)

                ProfilePage()
                    .ignoresSafeArea(.all, edges:.all)
                    .tag(3)
            }

            VStack(spacing: 0) {
                Spacer()

                HStack(spacing: 0) {
                    TabBarItemExplorerView()
                        .padding(.leading, 68)
                        .onTapGesture {
                            selectedIndex = 0
                        }

                    TabBarCartItemView()
                        .padding(.leading, 47)
                        .onTapGesture {
                            isPresentedCart.toggle()
                        }
                        .fullScreenCover(isPresented: $isPresentedCart, content: CartPage.init)

                    TabBarItemView(image: Image(systemName: "heart"), width: 19, height: 17)
                        .padding(.leading, 52)
                        .onTapGesture {
                            selectedIndex = 2
                        }

                    TabBarItemView(image: Image("profile"), width: 17.01, height: 17.57)
                        .padding(.leading, 52)
                        .padding(.trailing, 60)
                        .onTapGesture {
                            selectedIndex = 3
                        }

                        Spacer()
                }
                .frame(width: 380, height: 72)
                .background(Color.mainDarkBlue)
                .cornerRadius(30)
                .padding(.bottom, 20)
            }
        }
    .padding(.top, 60)
        .padding(.horizontal, 12)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.all, edges:.all)

    }
}

struct TabBarItemExplorerView: View {
    var body: some View {
        HStack {
            Circle()
                .frame(width: 8, height: 8)
                .foregroundColor(Color.white)

            Text("Explorer")
                .foregroundColor(Color.white)
                .font(.custom(mainFont700, size: 15))
        }
        .frame(width: 78, height: 19)
    }
}

struct TabBarItemView: View {
let image: Image
let width: CGFloat
let height: CGFloat

    var body: some View {
        image
            .resizable()
            .frame(width: width, height: height)
            .foregroundColor(Color.white)
    }
}

struct TabBarCartItemView: View {
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        ZStack(alignment: .trailing) {
            Image("shop")
                .resizable()
                .frame(width: 17.54, height: 18)
                .foregroundColor(Color.white)
            if cartManager.products.count > 0 {
                Text("\(cartManager.products.count)")
                    .font(.caption2).bold()
                    .foregroundColor(.white)
                    .frame(width: 15, height: 15)
                    .background(.red)
                    .clipShape(Circle())
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 11, trailing: -8))
            }
        }
    }
}
