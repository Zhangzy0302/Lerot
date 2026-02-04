import SwiftUI

struct EwtaohNAgaUserPage: View {
    @EnvironmentObject var ewaitNavi: NavigationManager
    
    var body: some View {
        GeometryReader{geo in
            ZStack(alignment: .top) {
                ZStack(alignment: .top) {
                    LinearGradient(colors: [
                        Color(red: 1, green: 236/255, blue: 251/255),
                        Color.white
                    ], startPoint: .bottom, endPoint: .top)
                    VStack(spacing: 0){
                        Circle().frame(width: 68)
                        Text("Jaida Sykes")
                            .font(LerWifaTheme.LerotFont.baigo(20))
                            .foregroundColor(.black)
                            .padding(.top, 10)
                            .padding(.bottom, 20)
                        HStack{
                            VStack(spacing: 14){
                                Text("99")
                                    .font(LerWifaTheme.LerotFont.baigo(16))
                                Text("Followings")
                                    .font(LerWifaTheme.LerotFont.miSans(16))
                            }.frame(maxWidth: .infinity)
                            Rectangle()
                                .frame(width: 1, height: 18)
                            VStack(spacing: 14){
                                Text("99")
                                    .font(LerWifaTheme.LerotFont.baigo(16))
                                Text("Followers")
                                    .font(LerWifaTheme.LerotFont.miSans(16))
                            }.frame(maxWidth: .infinity)
                        }.padding(.bottom, 12)
                        HStack{
                            Text("Balance: ")
                                .font(LerWifaTheme.LerotFont.baigo(20))
                            Text("100")
                                .font(LerWifaTheme.LerotFont.baigo(20))
                            Spacer()
                            Image("cponlzna_coin")
                                .resizable()
                                .frame(width: 36, height: 36)
                        }.padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.white)
                            )
                            .onTapGesture {
                                ewaitNavi.push(VeulaNwiAppRoute.myWallet)
                            }
                    }.padding(.horizontal, 34)
                        .padding(.top, 12 + geo.safeAreaInsets.top)
                }.frame(height: 278 + geo.safeAreaInsets.top)
                    .ignoresSafeArea()
                VNauwAUWTopBar() {
                    Button(action: {
                        ewaitNavi.push(VeulaNwiAppRoute.mySetting)
                    }) {
                        Image("cponlzna_setting")
                            .resizable()
                            .frame(width: 52, height: 52)
                    }
                }
            }.navigationBarHidden(true)
        }
    }
}

