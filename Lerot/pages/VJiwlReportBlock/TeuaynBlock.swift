import SwiftUI

struct TeuaynBlock: View {
    
    @EnvironmentObject var teuaynNavi: NavigationManager
    @EnvironmentObject var teuayUserVM: LwianzBAwaUserViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading){
            Image("cponlzna_dialog_purple")
                .resizable()
                .frame(width: 311, height: 290)
                .overlay{
                    VStack(spacing: 16){
                        Text("Are you sure you want to block this user? No longer receive messages or dynamic content related to it.")
                            .font(LerWifaTheme.LerotFont.miSansSemibold(16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                        HStack(spacing: 13){
                            Button(action: {
                                withAnimation(.easeOut) {
                                    teuaynNavi.closeReportBlock()
                                }
                            }) {
                                Text("Cancel")
                                    .font(LerWifaTheme.LerotFont.baigo(18))
                                    .foregroundColor(.black)
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(.white)
                                    )
                            }
                            Button(action: {
                                if let almzblockUserId = teuaynNavi.blockUserID {
                                    teuayUserVM.toggleUserIsBlocked(blockUserId: almzblockUserId)
                                    teuaynNavi.closeReportBlock()
                                }
                            }) {
                                Text("Sure")
                                    .font(LerWifaTheme.LerotFont.baigo(18))
                                    .foregroundColor(.white)
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(LerWifaTheme.Color.mainPurple)
                                            
                                    )
                            }
                        }
                    }.padding(.horizontal, 32)
                }
            Image("cponlzna_report_alert")
                .resizable()
                .frame(width: 126, height: 126)
                .offset(x: 20, y: -80)
        }
    }
}

