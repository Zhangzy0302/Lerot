//
//  GgaunAbAgdEditInfo.swift
//  Lerot
//
//  Created by yangyang on 2026/2/3.
//

import SwiftUI

struct GgaunAbAgdEditInfo: View {
    @State private var guanWiadjUserName: String = ""
    @FocusState private var guanwiIsFocus: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geo in
              Image("cponlzna_main_bg")
                .resizable()
                .frame(maxHeight: .infinity)
                .clipped()
                .ignoresSafeArea()
            }
            VStack{
                VNauwAUWTopBar()
                RoundedRectangle(cornerRadius: 40)
                    .frame(width: 139, height: 139)
                    .overlay{
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(LerWifaTheme.Color.mainPurple, lineWidth: 1)
                        GeometryReader{geo in
                            ZStack(alignment: .topTrailing){
                                Circle().fill(.white).frame(width: 38, height: 38)
                                    .overlay{
                                        Circle().stroke(LerWifaTheme.Color.mainPurple, lineWidth: 1)
                                        Image("cponlzna_camera")
                                            .resizable()
                                            .frame(width: 18, height: 18)
                                    }.offset(x: 0, y: -11)
                            }.frame(width: geo.size.width, height: geo.size.height, alignment: .topTrailing)
                        }
                    }.padding(.top, 40)
                VStack(alignment: .leading, spacing: 16) {
                    Text("Username:")
                        .font(LerWifaTheme.LerotFont.baigo(20))
                    TextField("Enter your username", text: $guanWiadjUserName)
                        .focused($guanwiIsFocus)
                        .font(LerWifaTheme.LerotFont.miSans(14))
                        .textInputAutocapitalization(.never)
                        .tint(.black)
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(LerWifaTheme.Color.mainPurple, lineWidth: 1)
                                }
                        )
                }.padding(.horizontal, 20)
                    .padding(.top, 50)
                
                
            }
            VStack{
                Spacer()
                RyyeuaButton(ryyeuaText: "Save", ryyeaAction: {})
                    .padding(.bottom, 20)
            }
        }.navigationBarHidden(true)
            .onTapGesture {
                guanwiIsFocus = false
            }
    }
}

#Preview {
    GgaunAbAgdEditInfo()
}
