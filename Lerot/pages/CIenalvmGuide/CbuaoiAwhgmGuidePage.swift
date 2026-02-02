
import SwiftUI

struct CbuaoiAwhgmGuidePage: View {
    @Binding var appPath: NavigationPath
    
    var body: some View {
        ZStack{
            Image("cponlzna_guide_bg").resizable().frame(width: .infinity, height: .infinity).ignoresSafeArea()
            LinearGradient(colors: [
                Color(red: 1, green: 142/255, blue: 238/255),
                .white.opacity(0)
            ], startPoint: .bottom, endPoint: .top)
            .ignoresSafeArea()
            VStack{
                Image("cponlzna_app_logo").resizable()
                    .frame(width: 79, height: 79)
                    .cornerRadius(16.63)
            }
        }.onAppear {
            for family in UIFont.familyNames {
      print("family:", family)
      for name in UIFont.fontNames(forFamilyName: family) {
        print("  font:", name)
      }
    }
        }
    }
}
