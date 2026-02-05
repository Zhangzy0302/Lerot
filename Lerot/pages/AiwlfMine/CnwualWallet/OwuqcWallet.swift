import SwiftUI

struct OwuqcWallet: View {
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
                    Text("100")
                        .font(LerWifaTheme.LerotFont.baigo(20))
                    Spacer()
                    Image("cponlzna_coin")
                        .resizable()
                        .frame(width: 36, height: 36)
                }.padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                    ).padding(.top, 8)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                ScrollView {
                    LazyVGrid(columns: owquColumes, spacing: 14) {
                        ForEach(0...9, id: \.self) { woajc in
                            QowajmWalletItem()
                        }
                    }.padding(.horizontal, 20)
                        .padding(.bottom, 40)
                }
            }
            
            
        }.navigationBarHidden(true)
    }
    
    struct QowajmWalletItem: View {
        var body: some View {
            Image("cponlzna_wallet_item_bg")
                .resizable()
                .frame(height: 138)
                .overlay{
                    VStack{
                        Image("cponlzna_coin")
                            .resizable()
                            .frame(width: 36, height: 36)
                        Text("400")
                            .font(LerWifaTheme.LerotFont.baigo(16))
                            .foregroundColor(.black)
                            .padding(.bottom, 12)
                            .padding(.top, 2)
                        Text("$0.99")
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
