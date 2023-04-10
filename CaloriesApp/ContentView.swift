//
//  ContentView.swift
//  CaloriesApp
//
//  Created by Capgemini-DA161 on 4/6/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var vm: CaloriesDataModel
    @State var itemSelected: Tab = .Breakfast
    @State var show = false
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Hi Sucodee").bold()
                        .font(.system(size: 35))
                    Spacer()
                    Image("burger")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .shadow(color: .blue, radius: 20, x: 0, y: 0)
                        .clipShape(Circle())
                }
                .padding(.horizontal)
                 RingView()
                 Divider()
                 TabView(itemSelected: $itemSelected)
                 Spacer()
                 if itemSelected == .Breakfast {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(vm.saveBreakfastEntity) {item in
                                FoodCard(width: 200, cards: CGFloat(item.cards), protein: CGFloat(item.cards), fat: CGFloat(item.cards), name: item.name ?? "", title: item.ingredients ?? "", icon: item.icon ?? "")
                                    .padding(.leading)
                                    .overlay(alignment: .topTrailing) {
                                        Button {
                                            vm.addValue(fat: CGFloat(item.fat), protein: CGFloat(item.protein), cards: CGFloat(item.cards))
                                            vm.addMealTagged(meal: item)
                                            vm.addRingCalories(calories: CGFloat(item.cards))
                                        } label: {
                                            ZStack{
                                                Circle()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(.white)
                                                     Image(systemName: item.addmeal ? "checkmark" : "plus")
                                                     .imageScale(.small)
                                                     .foregroundColor(.black)
                                                }
                                            .modifier(CustomShadow())
                                        }
                                        .offset(x: -5, y: 5)
                                    }
                            }
                        }
                        .frame(height: 180)
                    }
                    .offset(y: -30)
                } else if itemSelected == .Lunch {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(vm.saveLunchEntity) {item in
                                FoodCard(width: 200, cards: CGFloat(item.cards), protein: CGFloat(item.protein), fat: CGFloat(item.fat), name: item.name ?? "", title: item.ingredients ?? "", icon: item.icon ?? "")
                                    .padding(.leading)
                            }
                        }
                        .frame(height: 180)
                    }
                    .offset(y: -30)

                }
                WaterView()
                    .offset(y: -60)
                     Spacer()
                    .overlay(alignment: .bottomLeading) {
                     Button {
                        show.toggle()
                     } label: {
                        Text("New Meal").bold()
                            .foregroundColor(.black)
                            .frame(width: 150, height: 50)
                            .background(.white)
                            .clipShape(Capsule())
                            .modifier(CustomShadow())
                    }
                     .padding()
                    }
                    .sheet(isPresented: $show) {
                        AddView()
                     }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CaloriesDataModel())
    }
}
