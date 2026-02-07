import SwiftUI

struct SwbauDeleteAccount: View {
    @Binding var swbauIsShow: Bool
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.5).ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                       swbauIsShow = false
                   }
                }
            ZStack(alignment: .top){
                Image("cponlzna_dialog_yellow")
                    .resizable()
                    .frame(width: 311, height: 290)
                    .overlay{
                        VStack(spacing: 16){
                            Text("Are you sure you want to delete this account? All data in the account will be permanently cleared and cannot be recovered. Please choose carefully.")
                                .font(LerWifaTheme.LerotFont.miSansSemibold(16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                            HStack(spacing: 13){
                                Button(action: {
                                    withAnimation {
                                        swbauIsShow = false
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
                Image("cponlzna_delete_account")
                    .resizable()
                    .frame(width: 123, height: 148)
                    .offset(x: 0, y: -110)
            }
        }
    }
}
