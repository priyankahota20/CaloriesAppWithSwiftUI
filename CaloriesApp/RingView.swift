//
//  RingView.swift
//  CaloriesApp
//
//  Created by Capgemini-DA161 on 4/6/23.
//

import SwiftUI
struct CustomShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
}
struct RingView: View {
    @EnvironmentObject var vm : CaloriesDataModel
    var percent: CGFloat = 50
    var width:CGFloat = 130
    var height: CGFloat = 130
    let perc: CGFloat = 1000
    
    var body: some View {
        let ringValue = vm.saveValueEntity.first
        let multiplier = width / 44
        let progress = 1 - ((ringValue?.ring ?? 0) / 1700)
       // let progress = 1 - (perc / 1700)

        return HStack(spacing: 40) {
            ZStack {
                Circle()
                    .stroke(Color.blue.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multiplier))
                    .frame(width: width, height: height)
                Circle()
                    .trim(from: CGFloat(Int(progress)), to: 1)
                    .stroke(LinearGradient(gradient: Gradient(colors: [Color("cards"), .blue]), startPoint: .top, endPoint: .bottom), style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
                    .rotationEffect(Angle(degrees: 90))
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                    .frame(width: width, height: height)
                Text("1790").bold()
                    .font(.title)
                
            }
            HStack (spacing: 30){
                ForEach(vm.saveValueEntity) { item in
                    FoodElementValue(element: "Cards", gram: String(format: "%.0f", item.cards), color: "cards", elementValue: CGFloat(item.cards))
                    FoodElementValue(element: "fat", gram: String(format: "%.0f", item.fat), color: "fat", elementValue: CGFloat(item.fat))
                    FoodElementValue(element: "protein", gram: String(format: "%.0f", item.protein), color: "protein", elementValue: CGFloat(item.protein))
                }
            }

        }
        .frame(height: 180)
        .frame(width: UIScreen.main.bounds.width - 20)
        .background(Color.white)
        .cornerRadius(20)
        .modifier(CustomShadow())
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView()
            .environmentObject(CaloriesDataModel())
    }
}

struct FoodElementValue: View {
    var element = ""
    var gram = ""
    var color = ""
    var elementValue: CGFloat = 0
    
    var body: some View {
        let height: CGFloat = 130
        let multiplier = height / 2000
        return VStack {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .frame(width: 8, height: 110)
                    .foregroundColor(.gray.opacity(0.3))
                if elementValue != 0 {
                    Rectangle()
                        .frame(width: 8, height: elementValue * multiplier)
                        .foregroundColor(Color(color))
                } else {
                    Rectangle()
                        .frame(width: 8, height: 110)
                        .foregroundColor(Color(color))
                }
            }
            .cornerRadius(10)
            Text(element)
                .font(.system(size: 12))
            Text(gram)
                .font(.system(size: 12))
            
        }
    }
}
