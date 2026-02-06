//
//  CwiHAkmeajHomePage.swift
//  Lerot
//
//  Created by yangyang on 2026/2/2.
//

import SwiftUI

struct CwiHAkmeajHomePage: View {
    @EnvironmentObject var ciwaNavi: NavigationManager
    
    var body: some View {
        VStack(spacing: 0){
            HStack {
                MwunzArtTitle(title: "LEROT", width: 105)
                Spacer()
                Circle().fill(.white.opacity(0.4)).frame(width: 44)
                    .overlay{
                        Image("cponlzna_record_hisotry")
                            .resizable()
                            .frame(width: 18, height: 18)
                    }.onTapGesture {
                        ciwaNavi.push(VeulaNwiAppRoute.rinxbmRecordHistory)
                    }
                    
            }.padding(.horizontal, 20)
                .padding(.top, 6)
            ZStack{
                SlantedTopRoundedRect(cornerRadius: 30, slantHeight: 28)
                    .fill(LinearGradient(colors: [
                        Color(red: 1, green: 158 / 255, blue: 240 / 255),
                        .white
                    ], startPoint: .topTrailing, endPoint: .bottomLeading))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                SlantedTopRoundedRect(cornerRadius: 30, slantHeight: 15)
                    .fill(LinearGradient(colors: [
                        LerWifaTheme.Color.mainPurple,
                        .white
                    ], startPoint: .topTrailing, endPoint: .bottomLeading))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 15)
                VStack {
                    HStack{
                        VStack(spacing: 6){
                            Text("MON")
                                .font(LerWifaTheme.LerotFont.baigo(16))
                                .foregroundColor(.white)
                                .padding(2)
                            Text("2")
                                .font(LerWifaTheme.LerotFont.neoneon(16))
                                .foregroundColor(.white)
                        }
                    }.padding(.bottom, 18)
                    Spacer()
                    Text("When applying force from the tip of the bow, slightly increase the pressure. After slow practice, the force should be evenly distributed")
                        .font(LerWifaTheme.LerotFont.miSans(12))
                        .foregroundColor(.white)
                        .padding(.top, 12)
                }.padding(.horizontal, 16)
                    .padding(.top, 24)
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.black)
                            
                ).padding(.top, 32)
            }.padding(.horizontal, 20)
                .padding(.bottom, 10)
                .padding(.top, 6)
        }.navigationBarHidden(true)
    }
}
