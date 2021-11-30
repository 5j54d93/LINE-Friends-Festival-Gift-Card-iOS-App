//
//  FinishView.swift
//  LINE Festival Card
//
//  Created by 莊智凱 on 2021/12/1.
//

import SwiftUI

struct FinishView: View {
    @Binding var selectedFestival : String
    @Binding var name : String
    @Binding var wordColor : Color
    @Binding var year : Double
    @Binding var love : Double
    var body: some View {
        VStack {
            Image(selectedFestival)
                .resizable()
                .scaledToFit()
            HStack {
                Text("祝 " + name + "：")
                    .font(.title)
                    .bold()
                    .foregroundColor(wordColor)
                Text(Int(year).description)
                    .font(.title)
                    .bold()
                    .foregroundColor(wordColor)
                Text(selectedFestival + "快樂！")
                    .font(.title)
                    .bold()
                    .foregroundColor(wordColor)
            }
            Text("with \(Int(love))❤️")
                .font(.title2)
                .foregroundColor(wordColor)
        }
        .padding()
    }
}
