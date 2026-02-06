import SwiftUI

struct PwiancAUhVideoDetail: View {
    let pwiancAhuVideoId: Int
    @EnvironmentObject var pwianNavi: NavigationManager
    @EnvironmentObject var pwiancAUhVideoModel: VyualmaOiajVideoViewModel
    @EnvironmentObject var pwianUserVM: LwianzBAwaUserViewModel
    
    @State private var pwianIsPalying: Bool = false
    
    
    var body: some View {
        GeometryReader{geo in
            if let pwiancVideoInfo = pwiancAUhVideoModel.workDetail {
                ZStack(alignment: .top){
                    Color.black.ignoresSafeArea()
                    HorqhqVideoPlayer(videoPath: pwiancVideoInfo.vyualmaOiajVideoUrl, autoPlay: true).ignoresSafeArea()
                        .clipped()
                    VStack {
                        Spacer()
                        HStack{
                            Spacer()
                            if let pwianUserInfo = pwiancAUhVideoModel.getUserByCreatorId(creatorId: pwiancVideoInfo.vyualmaOiajCreatorId) {
                                VStack{
                                    KalfwalxImage(KalfwalxImageUrl: pwianUserInfo.lwianzBAwaAvatar, KalfwalxWidth: 60, KalfwalxHeight: 60, KalfwalxIsCircle: true).padding(.bottom, 24)
                                        .onTapGesture {
                                            pwianNavi.push(VeulaNwiAppRoute.bejadlUserPage(userId: pwiancVideoInfo.vyualmaOiajCreatorId, isMine: false))
                                        }
                                    VStack(spacing: 10){
                                        Circle()
                                            .fill(.black.opacity(0.2))
                                            .frame(width: 48, height: 48)
                                            .overlay{
                                                Image("cponlzna_like_fill")
                                                    .resizable()
                                                    .frame(width: 22, height: 22)
                                            }
                                        Text("\(pwiancVideoInfo.vyualmaOiajLikeCount)")
                                            .font(LerWifaTheme.LerotFont.baigo(16))
                                            .foregroundColor(.white)
                                    }.padding(.bottom, 17)
                                    VStack(spacing: 10){
                                        Circle()
                                            .fill(.black.opacity(0.2))
                                            .frame(width: 48, height: 48)
                                            .overlay{
                                                Image("cponlzna_comment")
                                                    .resizable()
                                                    .frame(width: 22, height: 22)
                                            }
                                        Text("99")
                                            .font(LerWifaTheme.LerotFont.baigo(16))
                                            .foregroundColor(.white)
                                    }
                                }.padding(.horizontal, 10)
                            }
                        }.padding(.bottom, 36)
                        Text(pwiancVideoInfo.vyualmaOiajTextContent)
                            .font(LerWifaTheme.LerotFont.miSans(16))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.top, 8)
                            .padding(.bottom, 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                Color.black.opacity(0.1)
                                    .ignoresSafeArea()
                            )
                    }
                    VNauwAUWTopBar() {
                        if(pwiancVideoInfo.vyualmaOiajCreatorId != pwianUserVM.currentUser?.lwianzBAwaUserId) {
                            Circle().fill(.white)
                                .frame(width: 52)
                                .overlay{
                                    Image(systemName: "ellipsis")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 6)
                                }.onTapGesture {
                                    pwianNavi.showReportBlock()
                                }
                        }
                        
                    }
                }
            }
            
        }.navigationBarHidden(true)
            .onAppear{
                pwiancAUhVideoModel.getWorkDetailByWorkId(workId: pwiancAhuVideoId)
                print("videoID: \(pwiancAhuVideoId)")
            }
    }
}
