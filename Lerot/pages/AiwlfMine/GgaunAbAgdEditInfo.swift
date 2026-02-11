//
//  GgaunAbAgdEditInfo.swift
//  Lerot
//
//  Created by yangyang on 2026/2/3.
//

import SwiftUI
import PhotosUI

struct GgaunAbAgdEditInfo: View {
    @State private var guanWiadjUserName: String = ""
    @FocusState private var guanwiIsFocus: Bool
    
    @State private var ggauanAvatar: String = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var showAvatarPicker = false
    
    @EnvironmentObject var gguanUserVM: LwianzBAwaUserViewModel
    
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
                        KalfwalxImage(KalfwalxImageUrl: ggauanAvatar, KalfwalxWidth: 139, KalfwalxHeight: 139)
                            .cornerRadius(40)
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
                    }.onTapGesture {
                        showAvatarPicker = true
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
            if !guanwiIsFocus {
                VStack{
                    Spacer()
                    RyyeuaButton(ryyeuaText: "Save", ryyeaAction: {
                        if(guanWiadjUserName.isEmpty){
                            LealoeoHUD.error("Username cannot be empty")
                            return
                        }
                        LealoeoHUD.success("Edit successful")
                        gguanUserVM.editUserInfo(name: guanWiadjUserName, avatar: ggauanAvatar)
                    })
                        .padding(.bottom, 24)
                }.transition(.move(edge: .bottom).combined(with: .opacity))
            }
            
        }.photosPicker(
            isPresented: $showAvatarPicker,
            selection: $selectedItem,
            matching: .images
        )
        .onChange(of: selectedItem) { item in
            guard let item else { return }
            
            Task {
                if let data = try? await item.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    
                    // 1️⃣ 保存到本地
                    if let localPath = LocalImageManager.saveImage(image) {
                        ggauanAvatar = localPath   // ✅ 赋值给头像
                    }
                }
            }
        }
        .navigationBarHidden(true)
            .onTapGesture {
                guanwiIsFocus = false
            }
            .onAppear{
                ggauanAvatar = gguanUserVM.currentUser?.lwianzBAwaAvatar ?? "cponlzna_default_avatar"
                guanWiadjUserName = gguanUserVM.currentUser?.lwianzBAwaUserName ?? "Error"
            }
    }
}
