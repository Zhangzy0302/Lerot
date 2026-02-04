//
//  NyaywMySetting.swift
//  Lerot
//
//  Created by yangyang on 2026/2/3.
//

import SwiftUI

struct NyaywMySetting: View {
    
    
    
    @State private var nywashIsShowDeleteAccount: Bool = false
    
    var body: some View {
        ZStack(alignment: .top){
            GeometryReader { geo in
              Image("cponlzna_main_bg")
                .resizable()
                .frame(maxHeight: .infinity)
                .clipped()
                .ignoresSafeArea()
            }
            VStack{
                VNauwAUWTopBar()
                VStack(spacing: 20) {
                    ForEach(0...5, id: \.self) {
                        NyaywSettingItem(nyaysIsShowDialog: $nywashIsShowDeleteAccount, nyaywIndex: $0)
                    }
                }.padding(.horizontal, 20)
                    .padding(.top, 12)
            }
            NaciaDialog(naicaIsPresented: $nywashIsShowDeleteAccount) {
                SwbauDeleteAccount(swbauIsShow: $nywashIsShowDeleteAccount)
            }
        }.navigationBarHidden(true)
    }
    
    private struct NyaywSettingItem: View {
        @EnvironmentObject var nyaysNavi: NavigationManager
        
        @Binding var nyaysIsShowDialog: Bool
        let nyaywIndex: Int
        
        func nyayawSettingGo() {
            switch nyaywIndex {
            case 0:
                nyaysNavi.push(VeulaNwiAppRoute.editInfo)
            case 1:
                nyaysNavi.push(VeulaNwiAppRoute.myBlacklist)
            case 2:
                nyaysNavi.push(VeulaNwiAppRoute.agreementWeb(webUrl: "https://app.ul5exwgd.link/privacy"))
            case 3:
                nyaysNavi.push(VeulaNwiAppRoute.agreementWeb(webUrl: "https://app.ul5exwgd.link/users"))
            case 4:
                nyaysIsShowDialog = true
            case 5:
                nyaysNavi.popToRoot()
            default:
                return
            }
        }
        private let naydsettingName: [String] = [
            "Edit personal information",
            "Blacklist",
            "Privacy Policy",
            "User Agreement",
            "Delete Account",
            "Log Out"
        ]
        
        var body: some View {
            Button(action: {
                nyayawSettingGo()
            }){
                HStack {
                    Text(naydsettingName[nyaywIndex])
                        .font(LerWifaTheme.LerotFont.miSans(16))
                        .foregroundColor(LerWifaTheme.Color.mainPurple)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .frame(width: 16, height: 16)
                        .foregroundColor(LerWifaTheme.Color.mainPurple)
                }.padding(.horizontal, 18)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white.opacity(0.4))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(
                                        LerWifaTheme.Color.mainPurple.opacity(0.3),
                                        lineWidth: 1
                                    )
                            )
                    )
            }
        }
    }
}
