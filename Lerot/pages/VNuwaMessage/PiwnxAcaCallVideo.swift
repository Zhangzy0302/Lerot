import SwiftUI

struct PiwnxAcaCallVideo: View {
    let piwnaxCallUserId: Int
    
    @EnvironmentObject var pwianUserVm: LwianzBAwaUserViewModel
    @EnvironmentObject var pwianCAaNavi: NavigationManager
    
    var body: some View {
        ZStack(alignment: .top){
            if let piwnaxaAcaUserInfo = pwianUserVm.returnUserInfoById(userId: piwnaxCallUserId) {
                GeometryReader { geo in
                    ZStack{
                        KalfwalxImage(KalfwalxImageUrl: piwnaxaAcaUserInfo.lwianzBAwaAvatar).frame(maxWidth: .infinity, maxHeight: .infinity)
                        LinearGradient(colors: [
                            LerWifaTheme.Color.mainPurple,
                            LerWifaTheme.Color.mainPurple.opacity(0)
                        ], startPoint: .bottom, endPoint: .top)
                    }.ignoresSafeArea()
                    
                    VStack{
                        VNauwAUWTopBar()
                        VStack(spacing: 10){
                            KalfwalxImage(KalfwalxImageUrl: piwnaxaAcaUserInfo.lwianzBAwaAvatar, KalfwalxWidth: 122, KalfwalxHeight: 122)
                                .clipShape(Circle())
                            Text(piwnaxaAcaUserInfo.lwianzBAwaUserName)
                                .font(LerWifaTheme.LerotFont.baigo(20))
                                .foregroundColor(.white)
                        }.padding(.top, geo.size.height * 0.2)
                        Spacer()
                        Circle()
                            .fill(.white)
                            .frame(width: 70, height: 70)
                            .shadow(color: .black.opacity(0.2), radius: 4, y: 4)
                            .overlay{
                                Image("cieALwjxmuAkjd")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                            }.onTapGesture {
                                pwianCAaNavi.pop()
                            }.padding(.bottom, 71)
                    }
                }
                
            }
        }.navigationBarHidden(true)
    }
}
