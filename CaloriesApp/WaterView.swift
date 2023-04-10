//
//  WaterView.swift
//  CaloriesApp
//
//  Created by Capgemini-DA161 on 4/6/23.
//

import SwiftUI

struct WaterView: View {
    @State var checkMark = true
    var body: some View {
        VStack {
            HStack {
                Text("6 of 6 Glasses").bold()
                    .font(.title3)
                    .offset(y: -10)
                Spacer()
                Image("cup")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
            }
            .padding(.horizontal)
         HStack {
            ForEach(0..<6) { item in
                ZStack {
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue.opacity(checkMark ? 0.1 : 0.03))
                    HStack {
                        Image("water")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                checkMark.toggle()
                            }
                    }
                }
                .overlay(alignment: .topTrailing) {
                    ZStack {
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 15, height: 15)
                        Image(systemName: checkMark ? "checkmark" : "")
                            .font(.system(size: 10))
                            .foregroundColor(.green)
                    }
                }
            }
          }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 130)
        .background(.white)
        .cornerRadius(10)
        .padding(.horizontal)
        .modifier(CustomShadow())
    }
}

struct WaterView_Previews: PreviewProvider {
    static var previews: some View {
        WaterView()
    }
}
