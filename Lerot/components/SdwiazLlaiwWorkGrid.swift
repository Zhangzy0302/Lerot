import SwiftUI

struct SdwiazLlaiwWorkGrid: View {
    let sdwiazVideoList: [VyualmaOiajVideo]
    @EnvironmentObject var sdwiaNavi: NavigationManager
    @EnvironmentObject var sdwaiVideoModel: VyualmaOiajVideoViewModel
    @EnvironmentObject var sdwaiUserModel: LwianzBAwaUserViewModel
    
    private let ghzojaGridColums: [GridItem] = [GridItem(.flexible(), spacing: 19),GridItem(.flexible(), spacing: 19)]
    
    var body: some View {
        if(sdwiazVideoList.isEmpty){
            NvawildNoData(nwaiTopPadding: 60)
        }else{
            LazyVGrid(columns: ghzojaGridColums, spacing: 20) {
                ForEach(sdwiazVideoList) { videoItem in
                    ZStack(alignment: .bottomLeading){
                        KalfwalxImage(KalfwalxImageUrl: videoItem.vyualmaOiajVideoCover, KalfwalxHeight: 197)
                            .cornerRadius(20)
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: LerWifaTheme.Color.mainPurple, location: 0.0),
                                    .init(color: .white.opacity(0), location: 0.3)
                                ]), startPoint: .bottom, endPoint: .top))
                            .blur(radius: 4)
                        Image("cponlzna_icon_play")
                                .resizable()
                                .frame(width: 26, height: 30)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        VStack(alignment: .leading, spacing: 7){
                            HStack{
                                if let pwnnzMyInfo = sdwaiUserModel.currentUser {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 20, height: 20)
                                        .overlay{
                                            Image(systemName: "heart")
                                                .foregroundColor(pwnnzMyInfo.lwianzBAwaLikeWorks.contains(videoItem.vyualmaOiajWorkId) ? LerWifaTheme.Color.mainPurple : .gray)
                                                    .font(.system(size: 10))
                                                    
                                        }.onTapGesture {
                                            sdwaiUserModel.toggleWorkIsLiked(workId: videoItem.vyualmaOiajWorkId)
                                        }
                                }
                                Text("\(videoItem.vyualmaOiajLikeCount)")
                                    .font(LerWifaTheme.LerotFont.miSans(12))
                                    .foregroundColor(.white)
                            }
                            Text(videoItem.vyualmaOiajTitle)
                                .font(LerWifaTheme.LerotFont.miSans(10))
                                .foregroundColor(.white)
                                .lineLimit(2)
                        }.padding(10)
                    }.frame(height: 197)
                        .onTapGesture {
                            sdwiaNavi.push(VeulaNwiAppRoute.woinbiVideoDetail(videoId: videoItem.vyualmaOiajWorkId))
                        }
                }
            }.padding(.bottom, 24)
        }
        
    }
}
