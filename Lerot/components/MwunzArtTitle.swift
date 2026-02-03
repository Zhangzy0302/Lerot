import SwiftUI

struct MwunzArtTitle: View {
    let title: String
    let width: CGFloat
    let mwuIsShowStar: Bool?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("cponlzna_underline")
                .resizable()
                .frame(width: width, height: 20)
            Text(title)
                .font(LerWifaTheme.LerotFont.baigo(36))
                .foregroundColor(.black)
            if(mwuIsShowStar ?? true){
                Image("cponlzna_text_star")
                    .resizable()
                    .frame(width: 29, height: 23)
                    .offset(x: width/2 + 13, y: -31)
            }
            
        }
    }
}
