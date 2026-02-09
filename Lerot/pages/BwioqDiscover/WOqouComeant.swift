import SwiftUI

struct WOqouComeant: View {
    let woqeuVideoId: Int
    @Binding var woqueIsShowComment: Bool
    @EnvironmentObject var wquoCommentVM: PwqomaACowCommentsViewModel
    @EnvironmentObject var wqouNavi: NavigationManager
    @AppStorage("lerotCurrentUserId") var wqouMyId: Int = 0
    
    @State private var wqouInput: String = ""
    @FocusState private var wquouIsFocused: Bool
    
    var body: some View {
        ZStack(alignment: .bottom){
            Color.white.opacity(0.01)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeOut) {
                        woqueIsShowComment = false
                    }
                }
            VStack{
                HStack{
                    Text("Comments")
                        .font(LerWifaTheme.LerotFont.baigo(20))
                        .foregroundColor(.white)
                    Spacer()
                }
                if wquoCommentVM.workCommentsNotBlock.isEmpty {
                    NvawildNoData(nwaiTopPadding: 20)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }else{
                    ScrollView{
                        LazyVStack(spacing: 10) {
                            ForEach(wquoCommentVM.workCommentsNotBlock) {comment in
                                VStack(alignment: .leading, spacing: 4) {
                                    if let wqouCOmmetnUser = wquoCommentVM.getCommetUserInfo(userId: comment.pwqomaACowCommentUserId) {
                                        HStack{
                                            KalfwalxImage(KalfwalxImageUrl: wqouCOmmetnUser.lwianzBAwaAvatar, KalfwalxWidth: 32, KalfwalxHeight: 32, KalfwalxIsCircle: true)
                                                .padding(.trailing, 12)
                                            Text(wqouCOmmetnUser.lwianzBAwaUserName)
                                                .font(LerWifaTheme.LerotFont.baigo(16))
                                                .foregroundColor(.black)
                                            Spacer()
//                                            if(comment.pwqomaACowCommentUserId != wqouMyId){
                                                Image(systemName: "ellipsis")
                                                    .font(.system(size: 20))
                                                    .foregroundColor(.black)
                                                    .onTapGesture{
                                                        wqouNavi.showReportBlock(comment.pwqomaACowCommentUserId)
                                                    }
//                                            }
                                            
                                        }
                                    }
                                    Text(comment.pwqomaACowCommentText)
                                        .font(LerWifaTheme.LerotFont.miSans(14))
                                        .foregroundColor(.black)
                                }.padding(15)
                                    .background{
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(.white)
                                            .overlay{
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(LerWifaTheme.Color.mainPurple, lineWidth: 1)
                                            }
                                    }
                            }
                        }
                    }.scrollIndicators(.hidden)
                }
                HStack{
                    TextField("Say something...", text: $wqouInput)
                        .focused($wquouIsFocused)
                        .tint(.black)
                        .font(LerWifaTheme.LerotFont.miSans(14))
                        .foregroundColor(.black)
                        
                    Image("cponlzna_send_icon")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .onTapGesture{
                            if(wqouInput.isEmpty){
                                return
                            }
                            wquoCommentVM.addCommentItem(commentItem: PwqomaACowComment(pwqomaACowCommentWorkId: woqeuVideoId, pwqomaACowCommentUserId: wqouMyId, pwqomaACowCommentText: wqouInput, pwqomaACowDate: Date()))
                            wquoCommentVM.getCommentsNotBlockByWorkId(workId: woqeuVideoId)
                            wqouInput = ""
                        }
                }.padding(.horizontal, 20)
                    .padding(.vertical, 9)
                    .background(
                        RoundedRectangle(cornerRadius: 29)
                            .fill(.white)
                            .overlay{
                                RoundedRectangle(cornerRadius: 29)
                                    .stroke(LerWifaTheme.Color.mainPurple, lineWidth: 1)
                            }// ⬆️ 上内阴影
                            .overlay(
                                RoundedRectangle(cornerRadius: 29)
                                    .stroke(LerWifaTheme.Color.mainPurple, lineWidth: 2)
                                    .blur(radius: 4)
                                    .offset(y: 2)
                                    .mask(
                                        RoundedRectangle(cornerRadius: 29)
                                    )
                            )
                            // ⬇️ 下内阴影
                            .overlay(
                                RoundedRectangle(cornerRadius: 29)
                                    .stroke(LerWifaTheme.Color.mainPurple, lineWidth: 2)
                                    .blur(radius: 4)
                                    .offset(y: -2)
                                    .mask(
                                        RoundedRectangle(cornerRadius: 29)
                                    )
                            )
                    ).padding(.bottom, 20)
            }.padding(20)
                .frame(height: 450)
                .background(
                    UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20)
                        .fill(
                            LinearGradient(colors: [
                                LerWifaTheme.Color.mainPurple,
                                .white
                            ], startPoint: .top, endPoint: .bottom)
                        )
                )
                .onAppear{
                    wquoCommentVM.getCommentsNotBlockByWorkId(workId: woqeuVideoId)
                }
        }.onTapGesture {
            wquouIsFocused = false
        }
    }
}
