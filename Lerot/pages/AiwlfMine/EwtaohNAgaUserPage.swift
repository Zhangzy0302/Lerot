import SwiftUI

struct EwtaohNAgaUserPage: View {
    let ewtaohnUserId: Int
    let ewtaohnIsMinePage: Bool
    
    @EnvironmentObject var ewiacUserVM: LwianzBAwaUserViewModel
    @EnvironmentObject var ewaitVideoModel: VyualmaOiajVideoViewModel
    
    var body: some View {
        GeometryReader{geo in
            ZStack(alignment: .top) {
                ScrollView {
                    VStack{
                        if let ewiqoUserInfo = ewiacUserVM.userInfo {
                            ZStack(alignment: .top) {
                                KalfwalxImage(KalfwalxImageUrl: ewiqoUserInfo.lwianzBAwaAvatar, KalfwalxWidth: geo.size.width, KalfwalxHeight: 278 + geo.safeAreaInsets.top)
                                LinearGradient(colors: [
                                    Color(red: 1, green: 236/255, blue: 251/255),
                                    Color.white.opacity(0)
                                ], startPoint: .bottom, endPoint: .top)
                                VStack(spacing: 0){
                                    KalfwalxImage(KalfwalxImageUrl: ewiqoUserInfo.lwianzBAwaAvatar, KalfwalxWidth: 68, KalfwalxHeight: 68, KalfwalxIsCircle: true)
                                    Text(ewiqoUserInfo.lwianzBAwaUserName)
                                        .font(LerWifaTheme.LerotFont.baigo(20))
                                        .foregroundColor(.black)
                                        .padding(.top, 10)
                                        .padding(.bottom, 20)
                                    HStack{
                                        VStack(spacing: 14){
                                            Text("\(ewiqoUserInfo.lwianzBAwaFollowing.count)")
                                                .font(LerWifaTheme.LerotFont.baigo(16))
                                            Text("Followings")
                                                .font(LerWifaTheme.LerotFont.miSans(16))
                                        }.frame(maxWidth: .infinity)
                                        Rectangle()
                                            .frame(width: 1, height: 18)
                                        VStack(spacing: 14){
                                            Text("\(ewiqoUserInfo.lwianzBAwaFans.count)")
                                                .font(LerWifaTheme.LerotFont.baigo(16))
                                            Text("Followers")
                                                .font(LerWifaTheme.LerotFont.miSans(16))
                                        }.frame(maxWidth: .infinity)
                                    }.padding(.bottom, 12)
                                    EwiaziaWalletButtons(ewqooanUserInfo: ewiqoUserInfo, ewqIsMinePage: ewtaohnIsMinePage)
                                }.padding(.horizontal, 34)
                                    .padding(.top, 12 + geo.safeAreaInsets.top)
                            }.frame(height: 278 + geo.safeAreaInsets.top)
                                .ignoresSafeArea()
                        }
                        
                        VStack(alignment: .leading, spacing: 16){
                            Text("Recommended")
                                .font(LerWifaTheme.LerotFont.baigo(20))
                                .foregroundColor(LerWifaTheme.Color.mainPurple)
                                .padding(10)
                                .background(.white)
                                .cornerRadius(40)
                                .padding(.top, 20)
                            SdwiazLlaiwWorkGrid(sdwiazVideoList: ewaitVideoModel.userWorks)
                        }.padding(.horizontal, 20)
                    }
                }.ignoresSafeArea()
                
                EwtaohbTopBar(ewiaIsMinePage: ewtaohnIsMinePage, ewiaUserId: ewtaohnUserId)
                
            }.navigationBarHidden(true)
        }.onAppear{
            ewiacUserVM.getUserInfoByUid(uid: ewtaohnUserId)
            ewaitVideoModel.getWorksByUserId(userId: ewtaohnUserId)
        }
    }
    
    private struct EwiaziaWalletButtons: View {
        let ewqooanUserInfo: LwianzBAwaUser
        let ewqIsMinePage: Bool
        @EnvironmentObject var ewqiaUserVM: LwianzBAwaUserViewModel
        @EnvironmentObject var ewaitNavi: NavigationManager
        @EnvironmentObject var eqoChatVM: KsajwufslChatViewModel
        
        var body: some View {
            if(ewqIsMinePage){
                HStack{
                    Text("Balance: ")
                        .font(LerWifaTheme.LerotFont.baigo(20))
                    Text("\(ewqooanUserInfo.lwianzBAwaWalletBalance)")
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
                            .overlay{
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(LerWifaTheme.Color.mainPurple, lineWidth: 1)
                            }
                    )
                    .onTapGesture {
                        ewaitNavi.push(VeulaNwiAppRoute.myWallet)
                    }
            }else if(ewqooanUserInfo.lwianzBAwaUserId != ewqiaUserVM.currentUser?.lwianzBAwaUserId){
                HStack(spacing: 13){
                    Button(action: {
                    }) {
                        Text("+ Follow")
                            .font(LerWifaTheme.LerotFont.baigo(18))
                            .foregroundColor(.black)
                            .frame(width: 120, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.white)
                            )
                    }
                    Button(action: {
                        let matchOrCreateRoom = eqoChatVM.findOrCreateChatRoom(chatUserId: ewqooanUserInfo.lwianzBAwaUserId)
                        eqoChatVM.getMyChatRoomsNotBlock()
                        ewaitNavi.push(VeulaNwiAppRoute.viqoanChatRoom(roomId: matchOrCreateRoom.ksajwufslRoomId))
                    }) {
                        Text("Chat")
                            .font(LerWifaTheme.LerotFont.baigo(18))
                            .foregroundColor(.white)
                            .frame(width: 120, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(LerWifaTheme.Color.mainPurple)
                                    
                            )
                    }
                }
            }else{
                Color.clear
            }
            
        }
    }
    
    private struct EwtaohbTopBar: View {
        let ewiaIsMinePage: Bool
        let ewiaUserId: Int
        @EnvironmentObject var ewaitNavi: NavigationManager
        
        var body: some View {
            if(ewiaIsMinePage) {
                HStack{
                    Spacer()
                    Button(action: {
                        ewaitNavi.push(VeulaNwiAppRoute.mySetting)
                    }) {
                        Image("cponlzna_setting")
                            .resizable()
                            .frame(width: 52, height: 52)
                    }
                }.padding(.horizontal, 20)
                    .padding(.top, 12)
            }else{
                VNauwAUWTopBar() {
                    Circle().fill(.white)
                        .frame(width: 52)
                        .overlay{
                            Image(systemName: "ellipsis")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 6)
                        }.onTapGesture {
                            ewaitNavi.showReportBlock()
                        }
                }
            }
            
        }
    }
}

