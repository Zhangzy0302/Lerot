import SwiftUI
import AVFoundation

struct PwiancAUhVideoDetail: View {
    let pwiancAhuVideoId: Int
    @EnvironmentObject var pwianNavi: NavigationManager
    @EnvironmentObject var pwiancAUhVideoModel: VyualmaOiajVideoViewModel
    @EnvironmentObject var pwianUserVM: LwianzBAwaUserViewModel
    @EnvironmentObject var pwainCommentVM: PwqomaACowCommentsViewModel
    
    @State private var pwianIsPalying: Bool = false
    @State private var isShowComment: Bool = false
    
    @State private var player = AVPlayer()
    
    var body: some View {
        GeometryReader{geo in
            if let pwiancVideoInfo = pwiancAUhVideoModel.workDetail {
                ZStack(alignment: .top){
                    Color.black.ignoresSafeArea()
                    HorqhqVideoPlayer(player: player, videoPath: pwiancVideoInfo.vyualmaOiajVideoUrl, autoPlay: true).ignoresSafeArea()
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
                                        if let pwnnzMyInfo = pwianUserVM.currentUser {
                                            Circle()
                                                .fill(.black.opacity(0.2))
                                                .frame(width: 48, height: 48)
                                                .overlay{
                                                    Image(systemName: pwnnzMyInfo.lwianzBAwaLikeWorks.contains(pwiancAhuVideoId) ? "heart.fill" : "heart")
                                                        .foregroundColor(pwnnzMyInfo.lwianzBAwaLikeWorks.contains(pwiancAhuVideoId) ? LerWifaTheme.Color.mainPurple : .white)
                                                            .font(.system(size: 24))
                                                            
                                                }.onTapGesture {
                                                    pwianUserVM.toggleWorkIsLiked(workId: pwiancAhuVideoId)
                                                }
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
                                        Text("\(pwainCommentVM.workCommentsNotBlock.count)")
                                            .font(LerWifaTheme.LerotFont.baigo(16))
                                            .foregroundColor(.white)
                                    }.onTapGesture {
                                        withAnimation(.easeOut) {
                                            isShowComment = true
                                        }
                                    }
                                }.padding(.horizontal, 20)
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
                                    pwianNavi.showReportBlock(pwiancVideoInfo.vyualmaOiajCreatorId)
                                }
                        }
                        
                    }
                    if(isShowComment){
                        WOqouComeant(woqeuVideoId: pwiancAhuVideoId, woqueIsShowComment: $isShowComment)
                            .transition(.move(edge: .bottom))
                    }
                    
                }
            }
            
        }.navigationBarHidden(true)
            .onAppear{
                pwiancAUhVideoModel.getWorkDetailByWorkId(workId: pwiancAhuVideoId)
                pwainCommentVM.getCommentsNotBlockByWorkId(workId: pwiancAhuVideoId)
            }.onChange(of: pwianNavi.isShowBlock) { show in
                guard show == false else { return }
                guard let pwainMyInfo = pwianUserVM.currentUser else { return }
                guard let videoDetail = pwiancAUhVideoModel.workDetail else { return }
                if(pwainMyInfo.lwianzBAwaBlacklist.contains(videoDetail.vyualmaOiajCreatorId)) {
                    print("pop")
                    
                    DispatchQueue.main.async {
                        pwianNavi.popToRoot()
                        }
                }
            }
    }
}
