import SwiftUI

struct TuyancWyvzChatRoom: View {
    @FocusState private var truryIsFocus: Bool
    @EnvironmentObject var tuyanNavi: NavigationManager
    let tuyancWyvzRoomId: Int
    
    var body: some View {
        GeometryReader{geo in
            ZStack(alignment: .top) {
                ZStack{
                    LinearGradient(colors: [
                        LerWifaTheme.Color.mainPurple,
                        LerWifaTheme.Color.mainPurple.opacity(0)
                    ], startPoint: .bottom, endPoint: .top)
                }.frame(height: geo.safeAreaInsets.top + 159)
                .ignoresSafeArea()
                VStack {
                    VNauwAUWTopBar() {
                        Circle().fill(.white)
                            .frame(width: 52)
                            .overlay{
                                Image(systemName: "ellipsis")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 6)
                            }.onTapGesture {
                                
                                tuyanNavi.showReportBlock()
                            }
                    }
                    
                    ZStack(alignment: .topLeading){
                        UnevenRoundedRectangle(
                            topLeadingRadius: 30,
                            topTrailingRadius: 30
                        )
                        .fill(.white)
                        
                        .overlay{
                            VStack{
                                ScrollView {
                                    VStack{
                                        HStack{
                                            Text("The weather is really nice today. Do you want to go out dancing with me?")
                                                .font(LerWifaTheme.LerotFont.miSans(16))
                                                .foregroundColor(.black)
                                                .padding(15)
                                                .background(
                                                    UnevenRoundedRectangle(
                                                        bottomLeadingRadius: 16,
                                                        bottomTrailingRadius: 16,
                                                        topTrailingRadius: 16
                                                    ).fill(LerWifaTheme.Color.mainYellow)
                                                ).frame(maxWidth: 278)
                                            Spacer()
                                        }
                                        HStack(alignment: .top){
                                            Spacer()
                                            Text("The weather is really nice today. Do you want to go out dancing with me?")
                                                .font(LerWifaTheme.LerotFont.miSans(16))
                                                .foregroundColor(.white)
                                                .padding(15)
                                                .background(
                                                    UnevenRoundedRectangle(
                                                        topLeadingRadius: 16,
                                                        bottomLeadingRadius: 16,
                                                        bottomTrailingRadius: 16  ).fill(LerWifaTheme.Color.mainPurple)
                                                ).frame(maxWidth: 230)
                                            Circle().frame(width: 50)
                                        }
                                    }.padding(.horizontal, 20)
                                        .padding(.vertical, 30)
                                }
                                TuyahcBottomInput(turyIsFocus: $truryIsFocus)
                                    .padding(.bottom, geo.safeAreaInsets.bottom < 10 ? 24 : 6)
                            }
                        }
                        .padding(.top, 42)
                        HStack(spacing: 6){
                            Circle().frame(width: 60)
                            Text("Lumina")
                                .font(LerWifaTheme.LerotFont.baigo(20))
                                .foregroundColor(.white)
                        }.padding(.leading, 20)
                    }
                }
            }
        }.navigationBarHidden(true)
            .onTapGesture {
                truryIsFocus = false
            }
    }
    
    private struct TuyahcBottomInput:View {
        @State private var turyInput: String = ""
        @FocusState.Binding var turyIsFocus: Bool
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20){
                HStack{
                    Circle().frame(width: 34)
                        .overlay{
                            Image("cponlzna_micphone")
                                .resizable()
                                .frame(width: 16, height: 16)
                        }
                    Circle().frame(width: 34)
                        .overlay{
                            Image("cponlzna_picture")
                                .resizable()
                                .frame(width: 14, height: 14)
                        }
                }
                HStack{
                    TextField("Say something...", text: $turyInput)
                        .focused($turyIsFocus)
                        .tint(.black)
                        .font(LerWifaTheme.LerotFont.miSans(14))
                        .foregroundColor(.black)
                        
                    Image("cponlzna_send_icon")
                        .resizable()
                        .frame(width: 40, height: 40)
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
                    )
            }.padding(.horizontal, 20)
        }
    }
}
