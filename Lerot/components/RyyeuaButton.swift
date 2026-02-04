import SwiftUI

struct RyyeuaButton: View {
    let ryyeuaWidth: CGFloat
    let ryyeuaHeight: CGFloat
    let ryyeuaText: String
    let ryyeuaFontSize: CGFloat
    let ryyeuaIsGradient: Bool
    let ryyeaAction: () -> Void
    
    init(ryyeuaWidth: CGFloat = 193, ryyeuaHeight: CGFloat = 56,ryyeuaText: String, ryyeuaFontSize: CGFloat = 16, ryyeuaIsGradient: Bool = true, ryyeaAction: @escaping () -> Void) {
        self.ryyeuaWidth = ryyeuaWidth
        self.ryyeuaHeight = ryyeuaHeight
        self.ryyeuaText = ryyeuaText
        self.ryyeuaFontSize = ryyeuaFontSize
        self.ryyeuaIsGradient = ryyeuaIsGradient
        self.ryyeaAction = ryyeaAction
    }
    
    var body: some View {
        Button(action: {
            ryyeaAction()
        }) {
            RoundedRectangle(cornerRadius: 66)
                .fill(Color.clear)
                .background(
                    ZStack{
                        if(ryyeuaIsGradient){
                            LerWifaTheme.Color.buttonGradient
                        }else{
                            LerWifaTheme.Color.mainPurple
                        }
                    }.cornerRadius(66)
                )
                .frame(width: ryyeuaWidth, height: ryyeuaHeight)
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
                        .font(LerWifaTheme.LerotFont.baigo(ryyeuaFontSize))
                        .foregroundColor(.white)
                }
        }
    }
}
