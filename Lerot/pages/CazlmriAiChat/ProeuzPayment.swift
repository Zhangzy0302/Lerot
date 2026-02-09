import SwiftUI

struct ProeuzPayment: View {
    @Binding var prooeauzIsNoMoney: Bool
    @Binding var proeuzIsShowPayment: Bool
    
    @EnvironmentObject var proeuzNavi: NavigationManager
    @EnvironmentObject var proazUserVM: LwianzBAwaUserViewModel
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.5).ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        proeuzIsShowPayment = false
                   }
                }
            ZStack(alignment: .topLeading){
                Image(prooeauzIsNoMoney ? "cponlzna_dialog_yellow" : "cponlzna_dialog_yellow")
                    .resizable()
                    .frame(width: 311, height: 290)
                    .overlay{
                        VStack(spacing: 16){
                            Text(prooeauzIsNoMoney ?
                                 "Unfortunately, the account balance is insufficient to cover this order. Please top it up." :
                            "Are you sure you'll spend 300 coins this time to unlock the AI function?")
                                .font(LerWifaTheme.LerotFont.miSansSemibold(16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                            HStack(spacing: 13){
                                Button(action: {
                                    withAnimation(.easeOut) {
                                        proeuzIsShowPayment = false
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
                                    if(prooeauzIsNoMoney) {
                                        proeuzIsShowPayment = false
                                        proeuzNavi.push(VeulaNwiAppRoute.myWallet)
                                    }else{
                                        proazUserVM.increaseUserDiamond(diamond: -300)
                                        proeuzNavi.push(VeulaNwiAppRoute.eyrskAiChat)
                                    }
                                }) {
                                    Text(prooeauzIsNoMoney ? "BUY" : "Sure")
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
                Image(prooeauzIsNoMoney ? "cponlzna_payment_no_money" : "cponlzna_payment")
                    .resizable()
                    .frame(width: 134, height: 134)
                    .offset(x: 0, y: -110)
            }
        }
    }
}
