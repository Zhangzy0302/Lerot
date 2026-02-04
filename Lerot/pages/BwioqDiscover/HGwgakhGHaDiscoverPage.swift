
import SwiftUI

struct HGwgakhGHaDiscoverPage: View {
    @EnvironmentObject var hggajNavi: NavigationManager
    
    var body: some View {
        GeometryReader{geo in
            VStack(spacing: 0) {
                HStack {
                    MwunzArtTitle(title: "Discover", width: 173)
                    Spacer()
                    Circle().fill(.white.opacity(0.4)).frame(width: 44)
                        .overlay{
                            Image("cponlzna_add")
                                .resizable()
                                .frame(width: 27, height: 27)
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
                HguanzaRecommendVideosGrid()
            }
        }
    }
    
    private struct HguanzaRecommendVideosGrid: View {
        
        private let ghzojaGridColums: [GridItem] = [GridItem(.flexible()),GridItem(.flexible())]
        
        var body: some View {
            VStack(alignment: .leading, spacing: 16){
                Text("Recommended")
                    .font(LerWifaTheme.LerotFont.baigo(20))
                    .foregroundColor(LerWifaTheme.Color.mainPurple)
                    .padding(10)
                    .background(.white)
                    .cornerRadius(40)
                    .padding(.top, 20)
                LazyVGrid(columns: ghzojaGridColums, spacing: 20) {
                    ZStack(alignment: .bottom){
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: LerWifaTheme.Color.mainPurple, location: 0.0),
                                    .init(color: .white.opacity(0), location: 0.3)
                                ]), startPoint: .bottom, endPoint: .top))
                            .blur(radius: 4)
                        VStack(alignment: .leading, spacing: 7){
                            HStack{
                                Circle().fill(.white).frame(width: 20)
                                Text("999")
                                    .font(LerWifaTheme.LerotFont.miSans(12))
                                    .foregroundColor(.white)
                            }
                            Text("Today's performance video is shared with all of you")
                                .font(LerWifaTheme.LerotFont.miSans(10))
                                .foregroundColor(.white)
                                .lineLimit(2)
                        }.padding(10)
                    }.frame(height: 197)
                }
            }.padding(.horizontal, 20)
        }
    }
}
