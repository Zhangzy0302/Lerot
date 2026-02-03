import SwiftUI

struct RyyeuaButton: View {
    let ryyeuaText: String
    let ryyeuaFontSize: CGFloat?
    let ryyeuaIsGradient: Bool?
    let ryyeaAction: () -> Void
    
    var body: some View {
        Button(action: {
            ryyeaAction()
        }) {
            RoundedRectangle(cornerRadius: 66)
                .fill(Color.clear)
                .background(
                    ZStack{
                        if(ryyeuaIsGradient ?? true){
                            LerWifaTheme.Color.buttonGradient
                        }else{
                            LerWifaTheme.Color.mainPurple
                        }
                    }.cornerRadius(66)
                )
                .frame(width: 193, height: 56)
                // ⬆️ 上内阴影
                .overlay(
                    RoundedRectangle(cornerRadius: 66)
                        .stroke(Color.white, lineWidth: 2)
                        .blur(radius: 4)
                        .offset(y: 2)
                        .mask(
                            RoundedRectangle(cornerRadius: 66)
                        )
                )
                // ⬇️ 下内阴影
                .overlay(
                    RoundedRectangle(cornerRadius: 66)
                        .stroke(Color.white, lineWidth: 2)
                        .blur(radius: 4)
                        .offset(y: -2)
                        .mask(
                            RoundedRectangle(cornerRadius: 66)
                        )
                ).overlay{
                    Text(ryyeuaText)
                        .font(LerWifaTheme.LerotFont.baigo(ryyeuaFontSize ?? 16))
                        .foregroundColor(.white)
                }
        }
    }
}
