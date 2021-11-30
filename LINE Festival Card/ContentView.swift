//
//  ContentView.swift
//  LINE Festival Card
//
//  Created by 莊智凱 on 2021/11/29.
//

import SwiftUI

struct ContentView: View {
    let festival = ["春節", "中秋節", "萬聖節", "聖誕節"]
    @State private var editCard = false
    @State private var selectedFestival = "春節"
    @State private var num: Double = 1
    @State private var festivalTime = Date()
    @State private var year: Double = Double(Calendar.current.component(.year, from: Date()))
    @State private var name = ""
    @FocusState private var activeState : Bool
    @State private var wordColor = Color.black
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var showSecondPage = false
    @State private var love = 1.0
    var body: some View {
        VStack {
            Image(selectedFestival)
                .resizable()
                .scaledToFit()
                .scaleEffect(num)
            HStack {
                Text("祝 " + name + "：" + selectedFestival + "快樂！")
                    .foregroundColor(wordColor)
                Spacer()
                Text(Int(year).description)
            }
            .padding(.leading)
            .padding(.trailing)
            Form {
                Toggle("編輯賀卡", isOn: $editCard)
                if editCard {
                    TextField("送給誰", text: $name)
                        .focused($activeState)
                    HStack {
                        Button("隨機選擇") {
                            selectedFestival = festival.randomElement()!
                        }
                        Picker(selection: $selectedFestival) {
                            ForEach(festival, id: \.self) { festival in
                                Text(festival)
                            }
                        } label: {
                            Text("選擇節日")
                        }
                        .pickerStyle(.segmented)
                    }
                    HStack {
                        Text("圖片大小")
                        Slider(value: $num, in: 0...2, step: 0.1)
                        Button("恢復預設") {
                            num = 1
                        }
                    }
                    HStack {
                        DatePicker("節日日期", selection: $festivalTime, displayedComponents: .date)
                            .onChange(of: festivalTime, perform: { value in
                                year = Double(Calendar.current.component(.year, from: value))
                        })
                    }
                    ColorPicker("文字顏色", selection: $wordColor)
                    Stepper("\(Int(love)) ❤️", value: $love, in: 0...1000)
                }
                DisclosureGroup("LINE Friends 相關連結") {
                    Link("LINE Friends 官方帳號", destination: URL(string: "https://line.me/ti/p/%40linefriends_tw")!)
                    Link("LINE Friends 商城", destination: URL(string: "https://www.linefriends.com.tw/linefriends/index.php")!)
                    Link("Instagram", destination: URL(string: "https://www.instagram.com/linefriends_taiwan")!)
                    Link("Facebook", destination: URL(string: "https://www.facebook.com/linefriendstw")!)
                }
            }
            HStack {
                Spacer()
                Button {
                    showSecondPage = true
                } label: {
                    Text("預覽")
                        .font(.title2)
                }
                .sheet(isPresented: $showSecondPage) {
                    FinishView(selectedFestival: $selectedFestival, name: $name, wordColor: $wordColor, year: $year, love: $love)
                }
                Spacer()
                Button {
                    showAlert = true
                    alertTitle = "恭喜！"
                } label: {
                    Text("完成")
                        .font(.title2)
                }
                .alert(alertTitle, isPresented: $showAlert, actions: {
                    Button("OK") { }
                }, message: {
                    Text("也祝你" + selectedFestival + "快樂！")
                })
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
