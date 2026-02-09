
import SwiftUI

struct HGwgakhGHaDiscoverPage: View {
    @EnvironmentObject var hggajNavi: NavigationManager
    @EnvironmentObject var hgaiUserVM: LwianzBAwaUserViewModel
    
    @Binding var ghajIsNoMoney: Bool
    @Binding var hgawagIsShowPayment: Bool
    
    var body: some View {
        GeometryReader{geo in
            ZStack(alignment: .top){
                ScrollView {
                    VStack(spacing: 0) {
                        HStack {
                            MwunzArtTitle(title: "Discover", width: 173)
                            Spacer()
                            Circle().fill(.white.opacity(0.4)).frame(width: 44)
                                .overlay{
                                    Image("cponlzna_add")
                                        .resizable()
                                        .frame(width: 27, height: 27)
                                }.onTapGesture {
                                    hggajNavi.push(VeulaNwiAppRoute.qonnafjUploadVideo)
                                }
                                
                        }.padding(.horizontal, 20)
                            .padding(.top, 6)
                        ZStack(alignment: .bottom){
                            SlantedTopRoundedRect(cornerRadius: 30, slantHeight: 26)
                                .fill(LinearGradient(colors: [
                                    Color(red: 1, green: 0, blue: 217 / 255).opacity(0.13),
                                    Color.white.opacity(0)
                                ], startPoint: .topTrailing, endPoint: .bottomLeading))
                                .frame(height: 197)
                            SlantedTopRoundedRect(cornerRadius: 30, slantHeight: 13)
                                .fill(LinearGradient(colors: [
                                    Color(red: 1, green: 0, blue: 217 / 255).opacity(0.35),
                                    Color.white.opacity(0)
                                ], startPoint: .topTrailing, endPoint: .bottomLeading))
                                .frame(height: 183)
                                .overlay{
                                    HStack {
                                        VStack(alignment: .leading, spacing: 10){
                                            Text("Encountering difficulties in practicing the violin? Click to summon the AI exclusive assistant")
                                                .font(LerWifaTheme.LerotFont.miSans(14))
                                                .foregroundColor(.white)
                                                .shadow(color: .black.opacity(0.5), radius: 0, x: 0, y: 1)
                                            HStack(spacing: 0){
                                                Image("cponlzna_coin")
                                                    .resizable()
                                                    .frame(width: 25, height: 25)
                                                    .padding(.trailing, 4)
                                                Text("-300")
                                                    .font(LerWifaTheme.LerotFont.baigo(14))
                                                    .padding(.trailing, 8)
                                                Text("go")
                                                    .font(LerWifaTheme.LerotFont.baigo(14))
                                            }.padding(.horizontal, 10)
                                                .padding(.vertical, 6)
                                                .background(.white)
                                                .cornerRadius(99)
                                        }.frame(width: 178)
                                        Spacer()
                                    }.padding(.horizontal, 18)
                                    HStack{
                                        Spacer()
                                        Image("cponlzna_ai_character")
                                            .resizable()
                                            .frame(width: 170, height: 224)
                                            .offset(x: -8, y: -22)
                                    }
                                }
                            
                        }.frame(height: 197).padding(.horizontal, 20)
                            .onTapGesture {
                                if let qohmjfa = hgaiUserVM.currentUser {
                                    
                                    if(qohmjfa.lwianzBAwaWalletBalance >= 300){
                                        ghajIsNoMoney = false
                                    }else{
                                        ghajIsNoMoney = true
                                    }
                                    withAnimation(.easeOut) {
                                        hgawagIsShowPayment = true
                                    }
                                }
                            }
                        HguanzaRecommendVideosGrid()
                    }
                }
            }
            
            
        }.navigationBarHidden(true)
    }
    
    private struct HguanzaRecommendVideosGrid: View {
        @EnvironmentObject var hgwaANavi: NavigationManager
        @EnvironmentObject var hgwagkVideoModel: VyualmaOiajVideoViewModel
        
        var body: some View {
            VStack(alignment: .leading, spacing: 16){
                Text("Recommended")
                    .font(LerWifaTheme.LerotFont.baigo(20))
                    .foregroundColor(LerWifaTheme.Color.mainPurple)
                    .padding(10)
                    .background(.white)
                    .cornerRadius(40)
                    .padding(.top, 20)
                SdwiazLlaiwWorkGrid(sdwiazVideoList: hgwagkVideoModel.allNotBlockWorks)
            }.padding(.horizontal, 20)
                .onAppear{
                    hgwagkVideoModel.getAllNotBlockWorks()
                }
        }
    }
}
