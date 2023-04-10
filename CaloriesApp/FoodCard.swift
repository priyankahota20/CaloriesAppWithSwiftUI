//
//  FoodCard.swift
//  CaloriesApp
//
//  Created by Capgemini-DA161 on 4/6/23.
//

import SwiftUI

struct FoodCard: View {
    var width: CGFloat = 200
    @State var cards: CGFloat = 20
    @State var protein: CGFloat = 100
    @State var fat: CGFloat = 70
    @State var name: String = ""
    @State var title: String = ""
    @State var icon: String = ""
    
    var body: some View {
        let multiplier = width / 40
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(name)
                    .font(.title2)
                    .bold()
                    .frame(width: 160)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }

            HStack {
                Text(title)
                Spacer()
            }
            .frame(width: 200, height: 30)
            .minimumScaleFactor(0.6)
        }
        .offset(x: 20, y: -20)
        .frame(width: 270, height: 110)
        .background(.white)
        .cornerRadius(10)
        .modifier(CustomShadow())
        .overlay(alignment: .topLeading) {
            Image(icon)
                .resizable()
                .scaledToFill()
                .frame(width: 65, height: 65)
                .offset(x: -12, y: -16)
        }
        .overlay(alignment: .bottom) {
            HStack {
             Elements(name: "cards", foodElement: cards, multiplier: multiplier, color: "cards")
             Elements(name: "fat", foodElement: fat, multiplier: multiplier, color: "fat")
             Elements(name: "protein", foodElement: protein, multiplier: multiplier, color: "protein")
            }
        }
    }
}

struct FoodCard_Previews: PreviewProvider {
    static var previews: some View {
        FoodCard()
    }
}

struct Elements: View {
    var name = "name"
    var foodElement: CGFloat = 0
    var multiplier: CGFloat = 0
    var color = ""
    var body: some View {
        let width: CGFloat = 130
        var multiplier: CGFloat = width / 200
        VStack {
            Text(name)
                .font(.system(size: 12))
            Rectangle()
                .frame(width: foodElement * multiplier, height: 5)
                .cornerRadius(5)
                .foregroundColor(Color(color))
        }
        .padding(.bottom, 5)
        .frame(width: 90)
    }
}
