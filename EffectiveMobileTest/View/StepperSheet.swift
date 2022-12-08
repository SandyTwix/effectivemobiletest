//
 //  StepperSheet.swift
 //  EffectiveMobileTest
 //
 //  Created by Руслан Трищенков on 06.12.2022.
 //

 import SwiftUI

 struct StepperSheet: View {
     var text: Int
     @Binding var value: Int
     let range: ClosedRange<Int>
     let step: Int
     let onIncrement: (() -> Void)?
     let onDecrement: (() -> Void)?
     @State private var valueChanged = false

     var body: some View {
         VStack {
             ZStack {
                 RoundedRectangle(cornerRadius: 26)
                     .frame(width: 26, height: 68)
                     .foregroundColor(Color.stepperColor)

                 VStack(alignment: .center, spacing: 0) {
                     Button {
                         decrement()
                     } label: {
                         //Image("minus")
                         Image(systemName: "minus")
                             .frame(width: 25, height: 22)
                     }
                     .buttonStyle(.borderless)
                     .foregroundColor(.white)

                     Text(text.description)
                         .font(.custom(mainFont500, size: 20))
                         .foregroundColor(.white)

                     Button {
                         increment()
                     } label: {
                         Image(systemName:"plus")
                             .frame(width: 25, height: 22)
                     }
                     .buttonStyle(.borderless)
                     .foregroundColor(.white)
                 }
             }
         }
         .frame(width: 26, height: 68)
         .onAppear() {
             if value < range.lowerBound {
                 value = range.lowerBound
             } else if value > range.upperBound {
                 value = range.upperBound
             }
         }
     }

     func decrement() {
         if value > range.lowerBound {
             value -= step
             valueChanged = true
         }
         if value < range.lowerBound {
             value = range.lowerBound
         }
         if let onDecrement = onDecrement {
             if valueChanged {
                 onDecrement()
                 valueChanged = false
             }
         }
     }

     func increment() {
        if value < range.upperBound {
            value += step
            valueChanged = true
        }
        if value > range.upperBound {
            value = range.upperBound
        }
        if let onIncrement = onIncrement {
            if valueChanged {
                onIncrement()
                valueChanged = false
            }
        }
    }
 }

 struct StepperView_Previews: PreviewProvider {
     static var previews: some View {
         CartPage()
             .environmentObject(CartManager())
     }
 }
