import SwiftUI

struct ZMwhwpAiChatRoom: View {
    @State private var turyInput: String = ""
    @FocusState.Binding var turyIsFocus: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geo in
              Image("cponlzna_sign_bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxHeight: .infinity)
                .clipped()
                .ignoresSafeArea()
            }
            Image("cponlzna_ai_char_bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: .infinity)
            VStack{
                HStack{
                    Text("Welcome! If you have any questions you want to know or share today's practice results, feel free to let me know at any time!")
                        .font(LerWifaTheme.LerotFont.neoneon(16))
                        .foregroundColor(LerWifaTheme.Color.mainPurple)
                        .padding(10)
                        .background(
                            UnevenRoundedRectangle(
                                topLeadingRadius: 0,
                                bottomLeadingRadius: 16,
                                bottomTrailingRadius: 16,
                                topTrailingRadius: 16
                            ).fill(.white)
                        )
                    Spacer()
                }
                ZwmajBottomInput(zmwhiInput: $turyInput, zwmnaIsFocus: $turyIsFocus)
            }.padding(.horizontal, 20)
            VNauwAUWTopBar()
        }
    }
    
    private struct ZwmajBottomInput: View {
        @Binding var zmwhiInput: String
        @FocusState.Binding var zwmnaIsFocus: Bool
        
        
        var body: some View {
            HStack{
                TextField("Say something...", text: $zmwhiInput)
                    .focused($zwmnaIsFocus)
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
                ).padding(.bottom, 20)
        }
    }
}
