//
 //  LoadImage.swift
 //  EffectiveMobileTest
 //
 //  Created by Руслан Трищенков on 05.12.2022.
 //

 import SwiftUI
 import Combine
 import Foundation

 class LoadImage: ObservableObject {
     @Published var image: UIImage?
     private let url: String
     private var cancellable: AnyCancellable?

     init(url: String) {
         self.url = url
     }

     deinit {
         cancel()
     }

     func loadData() {
         guard let safeUrl = URL(string: url) else { return }

         cancellable = URLSession.shared.dataTaskPublisher(for: safeUrl)
                     .map { UIImage(data: $0.data) }
                     .replaceError(with: nil)
                     .receive(on: DispatchQueue.main)
                     .sink { [weak self] in self?.image = $0 }
     }

     func cancel() {
         cancellable?.cancel()
     }
 }
