//
//  AddView.swift
//  CaloriesApp
//
//  Created by Capgemini-DA161 on 4/6/23.
//

import SwiftUI
struct meal: Identifiable {
    var id = UUID()
    var image: String
}
var icons:[meal] = [
    meal(image: "cheesecake"),
    meal(image: "chicken"),
    meal(image: "coffee"),
    meal(image: "crossiant"),
    meal(image: "donout"),
    meal(image: "fishCooked"),
    meal(image: "frenchfries"),
    meal(image: "icecream"),
    meal(image: "pizza"),
    meal(image: "sausage"),
    meal(image: "vegetables"),
    meal(image: "juice"),
    meal(image: "tea"),
    meal(image: "poachedEgg"),
    meal(image: "orange")
]
struct AddView: View {
    @Environment(\.presentationMode) var envi
    @EnvironmentObject var vm: CaloriesDataModel
    @State var itemSelected: Tab = .Breakfast
    @State var showIcons: Bool = false
    @State var icon: String = "plus2"
    @State var name: String = ""
    @State var title: String = ""
    @State var fat: String = "0"
    @State var protein: String = "0"
    @State var cards: String = "0"
    @State var fatTF: Bool = false
    @State var proteinTF: Bool = false
    @State var cardsTF: Bool = false
    var body: some View {
        
        VStack {
            Spacer()
            TabView(itemSelected: $itemSelected)
            VStack(spacing: 25) {
                Image(icon)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture {
                        withAnimation {
                            showIcons.toggle()
                        }
                    }
                if showIcons {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                        ForEach(icons) { item in
                            Image(item.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .onTapGesture {
                                        icon = item.image
                                        withAnimation {
                                            showIcons.toggle()
                                        }
                                    }
                        }
                     }
                    }
                }
                VStack {
                    TextField("name", text: $name)
                    Divider()
                    TextField("title", text: $title)
                }
                .font(.title3)
                .padding()
                .background(.white)
                .cornerRadius(10)
                .modifier(CustomShadow())
                VStack {
                    Values(number: $fat, show: $fatTF, name: "Fat")
                    Values(number: $protein, show: $proteinTF, name: "Protein")
                    Values(number: $cards, show: $cardsTF, name: "Cards")
                }
                .padding()
                .background(.white)
                .cornerRadius(20)
                .modifier(CustomShadow())
                Button {
                    switch itemSelected {
                    case .Breakfast:
                        vm.addBreakfast(icon: icon, name: name, ingredients: title, fat: CGFloat(Int(fat) ?? 0), protein: CGFloat(Int(protein) ?? 0), cards: CGFloat(Int(cards) ?? 0))
                        envi.wrappedValue.dismiss()
                    case .Lunch:
                        vm.addLunch(icon: icon, name: name, ingredients: title, fat: CGFloat(Int(fat) ?? 0), protein: CGFloat(Int(protein) ?? 0), cards: CGFloat(Int(cards) ?? 0))
                        envi.wrappedValue.dismiss()
                    case .Dinner:
                        print("Dinner")
                    case .Snacks:
                        print("Snacks")
                    }
                } label: {
                    Text("Save").bold()
                        .font(.title2)
                        .foregroundColor(.black)
                        .frame(width: 180, height: 50)
                        .background(.white)
                        .cornerRadius(10)
                        .modifier(CustomShadow())
                }

            }
            .padding()
            Spacer()
        }
        .overlay(alignment: .topTrailing) {
            Button {
                envi.wrappedValue.dismiss()
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                    Image(systemName: "xmark")
                        .imageScale(.small)
                        .foregroundColor(.white)
                }
                .modifier(CustomShadow())
                .padding()
            }

        }
    }
}
struct Values: View {
    @Binding var number: String
    @Binding var show: Bool
    var name = ""
    var body: some View {
        HStack {
            Text(name).bold()
            Spacer()
            Text("\(number)").bold()
                .font(.title2)
                .frame(width: 45, height: 30)
                .background(.black)
                .cornerRadius(5)
                .foregroundColor(.white)
                .onTapGesture {
                    withAnimation {
                        show.toggle()
                    }
                }
            if show {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        ForEach(1..<100) { item in
                            Text("\(item)").bold()
                                .frame(width: 30, height: 30)
                                .background(.black.opacity(0.2))
                                .cornerRadius(5)
                                .onTapGesture {
                                    withAnimation {
                                        show.toggle()
                                        number = "\(item)"
                                    }
                                }
                            
                        }
                    }
                }
                .frame(width: 180, height: 30)
            }
        }
        .padding()
    }
}
struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
            .environmentObject(CaloriesDataModel())
    }
}
