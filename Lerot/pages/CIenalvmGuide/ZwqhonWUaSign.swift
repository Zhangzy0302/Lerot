import SwiftUI

struct ZwqhonWUaSign: View {
    @Binding var appPath: NavigationPath
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
            VStack{
                Text("sign in")
                    .font(LerWifaTheme.LerotFont.neoneon(36))
                    .foregroundColor(LerWifaTheme.Color.mainPurple)
                    .padding(.top, 72)
                VStack(alignment: .leading){
                    Text("Email")
                        .font(LerWifaTheme.LerotFont.baigo(18))
                        .foregroundColor(LerWifaTheme.Color.mainPurple)
                }
            }
            HStack{
                Image("cponlzna_back")
                    .resizable()
                    .frame(width: 52, height: 52)
                    
                Spacer()
            }.padding(.horizontal, 20)
                .padding(.vertical, 12)
        }.navigationBarHidden(true)
    }
}

struct Cinlkajd: View {
  @State private var appPath = NavigationPath()

  var body: some View {
      ZwqhonWUaSign(appPath: $appPath)
  }
}

#Preview {
    Cinlkajd()
}
