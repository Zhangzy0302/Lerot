import SwiftUI

struct VnwualBlakclist: View {
    @EnvironmentObject var vnwauUserVM: LwianzBAwaUserViewModel
    
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
                VNauwAUWTopBar(){
                    MwunzArtTitle(title: "blacklist", width: 160, mwuIsShowStar: false)
                }
                if let vnwauUserInfo = vnwauUserVM.currentUser {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(vnwauUserInfo.lwianzBAwaBlacklist, id: \.self) {blockUserId in
                                HStack {
                                    if let blockUser = vnwauUserVM.returnUserInfoById(userId: blockUserId){
                                        KalfwalxImage(KalfwalxImageUrl: blockUser.lwianzBAwaAvatar,
                                                      KalfwalxWidth: 47,
                                                      KalfwalxHeight: 47,
                                                      KalfwalxIsCircle: true)
                                            .padding(.trailing, 14)
                                        Text(blockUser.lwianzBAwaUserName)
                                            .font(LerWifaTheme.LerotFont.baigo(16))
                                            .foregroundColor(LerWifaTheme.Color.mainPurple)
                                        Spacer()
                                        Button(action: {}){
                                            RoundedRectangle(cornerRadius: 77)
                                                .fill(LerWifaTheme.Color.mainPurple)
                                                .frame(width: 59, height: 27)
                                                .overlay{
                                                    Image("cponlzna_remove")
                                                        .resizable()
                                                        .frame(width: 16, height: 16)
                                                }
                                        }
                                    }
                                    
                                }.padding(.horizontal, 18)
                                    .frame(height: 67)
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
                        }.padding(.horizontal, 20)
                    }
                }
            }
            
        }.navigationBarHidden(true)
    }
}
