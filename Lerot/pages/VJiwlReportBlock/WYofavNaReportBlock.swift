import SwiftUI

struct WYofavNaReportBlock: View {
    @EnvironmentObject var wyofajcNavi: NavigationManager
    var body: some View {
        ZStack{
            Image("cponlzna_dialog_purple")
                .resizable()
                .frame(width: 320, height: 290)
            HStack(spacing: 30){
                VStack(spacing: 30){
                    Image("cponlzna_icon_report")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(.white.opacity(0.1))
                                .frame(width: 80, height: 79)
                        ).frame(width: 80, height: 79)
                    Button(action: {
                        wyofajcNavi.push(VeulaNwiAppRoute.wanvlzReportPage)
                    }) {
                        Text("report")
                            .font(LerWifaTheme.LerotFont.baigo(20))
                            .foregroundColor(.black)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(LerWifaTheme.Color.mainYellow)
                                    .frame(width: 108, height: 50)
                            )
                    }
                }
                VStack(spacing: 30){
                    Image("cponlzna_block_user")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(.white.opacity(0.1))
                                .frame(width: 80, height: 79)
                        ).frame(width: 80, height: 79)
                    Button(action: {
                        
                    }) {
                        Text("block")
                            .font(LerWifaTheme.LerotFont.baigo(20))
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(LerWifaTheme.Color.mainPurple)
                                    .frame(width: 108, height: 50)
                            )
                    }
                }
            }
        }
    }
}
