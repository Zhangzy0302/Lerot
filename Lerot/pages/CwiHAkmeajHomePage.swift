//
//  CwiHAkmeajHomePage.swift
//  Lerot
//
//  Created by yangyang on 2026/2/2.
//

import SwiftUI

struct CwiHAkmeajHomePage: View {
    var body: some View {
        VStack{
            HStack {
                MwunzArtTitle(title: "LEROT", width: 105)
                Spacer()
                Circle().fill(.white.opacity(0.4)).frame(width: 44)
                    
            }.padding(.horizontal, 20)
                .padding(.top, 6)
            ZStack{
                VStack {
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.black)
                )
            }.padding(.horizontal, 20)
        }
    }
}

#Preview {
    CwiHAkmeajHomePage()
}
