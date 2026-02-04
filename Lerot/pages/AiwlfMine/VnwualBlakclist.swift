import SwiftUI

struct VnwualBlakclist: View {
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
                LazyVStack(spacing: 20) {
                    HStack {
                        Circle().frame(width: 47)
                            .padding(.trailing, 14)
                        Text("nyaywName")
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
                }.padding(.horizontal, 20)
            }
            
        }.navigationBarHidden(true)
    }
}
