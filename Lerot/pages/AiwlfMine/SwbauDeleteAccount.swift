import SwiftUI

struct SwbauDeleteAccount: View {
    @Binding var swbauIsShow: Bool
    
    var body: some View {
        ZStack(alignment: .top){
            Image("cponlzna_dialog_yellow")
                .resizable()
                .frame(width: 311, height: 290)
                .overlay{
                    VStack(spacing: 16){
                        Text("Are you sure you want to delete this account? All data in the account will be permanently cleared and cannot be recovered. Please choose carefully.")
                            .font(LerWifaTheme.LerotFont.miSansSemibold(16))
                            .foregroundColor(.white)
                        HStack(spacing: 13){
                            Button(action: {
                                swbauIsShow = false
                            }) {
                                Text("Cancel")
                                    .font(LerWifaTheme.LerotFont.baigo(18))
                                    .foregroundColor(.black)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(.white)
                                            .frame(height: 50)
                                            .frame(maxWidth: .infinity)
                                    )
                            }
                            Button(action: {
                                
                            }) {
                                Text("Sure")
                                    .font(LerWifaTheme.LerotFont.baigo(18))
                                    .foregroundColor(.white)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(LerWifaTheme.Color.mainPurple)
                                            .frame(height: 50)
                                            .frame(maxWidth: .infinity)
                                    )
                            }
                        }
                    }.padding(.horizontal, 32)
                }
            Image("cponlzna_delete_account")
                .resizable()
                .frame(width: 123, height: 148)
        }
    }
}
