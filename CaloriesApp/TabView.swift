//
//  TabView.swift
//  CaloriesApp
//
//  Created by Capgemini-DA161 on 4/6/23.
//

import SwiftUI
struct FoodSelected: Identifiable {
    var id = UUID()
    var food: String
    var tab: Tab
}
var selectedTab: [FoodSelected] = [
    FoodSelected(food: "Breakfast", tab: .Breakfast),
    FoodSelected(food: "Lunch", tab: .Lunch),
    FoodSelected(food: "Dinner", tab: .Dinner),
    FoodSelected(food: "Snacks", tab: .Snacks)
]
enum Tab: String {
    case Breakfast
    case Lunch
    case Dinner
    case Snacks
}
struct TabView: View {
    @Binding var itemSelected : Tab
    var body: some View {
        HStack(spacing: 30) {
            ForEach(selectedTab) {item in
                Button {
                    withAnimation {
                        itemSelected = item.tab
                    }
                } label: {
                    Text(item.food)
                        .foregroundColor(itemSelected == item.tab ? .white : .black)
                        .padding(8)
                        .background(itemSelected == item.tab ? .black : Color(""))
                        .cornerRadius(10)
                }

            }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView(itemSelected: .constant(.Breakfast))
    }
}
