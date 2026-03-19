import SwiftUI

struct OwuqcWallet: View {
    @EnvironmentObject var owqucnqUserVM: LwianzBAwaUserViewModel
    @EnvironmentObject var laoqjzWalletVM: LakcqlkIAPManager
    
    let owquColumes: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack(alignment: .top){
            GeometryReader { geo in
              Image("cponlzna_main_bg")
                .resizable()
                .frame(maxHeight: .infinity)
                .clipped()
                .ignoresSafeArea()
            }
            VStack{
                VNauwAUWTopBar() {
                    MwunzArtTitle(title: "wallet", width: 93)
                }
                HStack{
                    Text("Balance: ")
                        .font(LerWifaTheme.LerotFont.baigo(20))
                    if let owiqncUserInfo = owqucnqUserVM.currentUser {
                        Text("\(owiqncUserInfo.lwianzBAwaWalletBalance)")
                            .font(LerWifaTheme.LerotFont.baigo(20))
                    }
                    Spacer()
                    Image("cponlzna_coin")
                        .resizable()
                        .frame(width: 36, height: 36)
                }.padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .overlay{
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(LerWifaTheme.Color.mainPurple, lineWidth: 1)
                            }
                    ).padding(.top, 8)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                ScrollView {
                    LazyVGrid(columns: owquColumes, spacing: 14) {
                        ForEach(bjealALiwlProducst, id: \.self.lakcqlkKeyId) { woajc in
                            QowajmWalletItem(oqiqanItem: woajc)
                                .onTapGesture {
                                    Task {
                                        laoqjzWalletVM.cmeuoALwlnRecharge(woajc.lakcqlkKeyId) { resultStatus in
                                            switch resultStatus {

                                            case .success(let diamond):
                                                owqucnqUserVM.increaseUserDiamond(diamond: diamond)
                                                LealoeoHUD.success("Purchase success")

                                            case .cancelled:
                                                LealoeoHUD.toast("Purchase cancelled")

                                            case .pending:
                                                return

                                            case .failed(let message):
                                                LealoeoHUD.error(message)
                                            }
                                        }

                                        
                                    }
                                }
                        }
                    }.padding(.horizontal, 20)
                        .padding(.bottom, 40)
                }
            }
            
            
        }.navigationBarHidden(true)
    }
    
    struct QowajmWalletItem: View {
        let oqiqanItem: LakcqlkProduct
        var body: some View {
            Image("cponlzna_wallet_item_bg")
                .resizable()
                .frame(height: 138)
                .overlay{
                    VStack{
                        Image("cponlzna_coin")
                            .resizable()
                            .frame(width: 36, height: 36)
                        Text("\(oqiqanItem.lakcqlkGetDiamond)")
                            .font(LerWifaTheme.LerotFont.baigo(16))
                            .foregroundColor(.black)
                            .padding(.bottom, 12)
                            .padding(.top, 2)
                        Text(String(format: "%.2f", oqiqanItem.lakcqlkPrice))
                            .font(LerWifaTheme.LerotFont.miSans(14))
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(LerWifaTheme.Color.buttonGradient)
                                    .frame(width: 72, height: 28)
                            )
                    }
                }
        }
    }
}
