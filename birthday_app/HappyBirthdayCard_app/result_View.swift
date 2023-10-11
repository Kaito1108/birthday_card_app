//
//  result_View.swift
//  kousin_happybirthday_app
//
//  Created by kaito on 2023/10/11.
//

import SwiftUI

struct result_View: View {
    //画面を閉じるために使う
    @Environment(\.dismiss) var dismiss
    
    @State var my_name: String
    @State var selectedImage: Image?
    
    var body: some View {
        ZStack{
            Color.brown.ignoresSafeArea()
            VStack{
                Text("Happy Birthday!").font(.system(size: 45)).fontWeight(.black).foregroundStyle(Color.red)
                Spacer()
                ZStack{
                    Image("birthday_card").resizable().scaledToFit().frame(width: 700, height:550)
                    VStack{
                        selectedImage?.resizable().scaledToFit().frame(width: 100, height: 100).cornerRadius(100)
                        Text("\(my_name)さん").font(.title2).fontWeight(.black)
                        Text("誕生日おめでとー!").font(.title2).fontWeight(.black)
                    }
                }
                Spacer()
                Button(action: {
                   dismiss()
                }){
                    Text("もう一度作成する").fontWeight(.black).frame(width: 130 , height: 130).background(Color.green).foregroundColor(Color.white).cornerRadius(100)
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}
