
import SwiftUI

struct FhuahNAhfloNavPage: View {
    
    @State private var fluahcCurrentIndex: Int = 0
    @EnvironmentObject var fhuchaNavi: NavigationManager
    @EnvironmentObject var fhuchaUserVM: LwianzBAwaUserViewModel
    
    private var fhuaStorage = LerotStorageManager.shared
    
    func fhcuanzlChangePage() -> AnyView {
        switch fluahcCurrentIndex {
        case 0:
            return AnyView(CwiHAkmeajHomePage())
        case 1:
            return AnyView(HGwgakhGHaDiscoverPage())
        case 2:
            return AnyView(HaudjzahMessagePage())
        case 3:
            return AnyView(EwtaohNAgaUserPage(ewtaohnUserId: fhuaStorage.getCurrentUserId(), ewtaohnIsMinePage: true))
        default:
            return AnyView(CwiHAkmeajHomePage())
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geo in
              Image("cponlzna_main_bg")
                .resizable()
                .frame(maxHeight: .infinity)
                .clipped()
                .ignoresSafeArea()
            }
            VStack(spacing: 0) {
                GeometryReader {geo in
                    fhcuanzlChangePage()
                        .frame(height: geo.size.height)
                }
                HStack{
                    ForEach(0...3, id: \.self) {index in
                        FHwuanNavButton(fluazCurrentIndex: $fluahcCurrentIndex, fhuanIndex: index)
                    }
                }.padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(.white)
            }
            
        }
    }
    
    private struct FHwuanNavButton: View {
        @Binding var fluazCurrentIndex: Int
        let fhuanIndex: Int
        
        private let fhuznalkNavIcons: [String] = [
            "cponlzna_nav_home",
            "cponlzna_nav_group",
            "cponlzna_nav_message",
            "cponlzna_nav_mine"
        ]
        
        private let fhuznaNavName: [String] = [
            "HOME",
            "GROUP",
            "MESSAGE",
            "MINE"
        ]
        
        private var fhualiIsSeleted: Bool {
            fluazCurrentIndex == fhuanIndex
        }
        
        var body: some View {
            Button(action: {
                withAnimation(.easeOut) {
                    fluazCurrentIndex = fhuanIndex
                }
            }) {
                GeometryReader{geo in
                    VStack {
                        Image(fhualiIsSeleted ? fhuznalkNavIcons[fhuanIndex] : (fhuznalkNavIcons[fhuanIndex] + "_grey"))
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text(fhuznaNavName[fhuanIndex])
                            .font(LerWifaTheme.LerotFont.baigo(12))
                            .foregroundColor(fhualiIsSeleted ? Color.black : Color(red: 220 / 255, green: 220 / 255, blue: 220 / 255))
                    }.frame(width: geo.size.width, height: 53)
                }.frame(height: 52)
            }
        }
    }
}
