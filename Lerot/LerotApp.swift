
import SwiftUI

@main
struct LerotApp: App {
    @State private var leriadIsShowBlock: Bool = false
    @StateObject private var naviManager: NavigationManager = NavigationManager()
    
    @StateObject private var jflawhPracRecordViewModel: JflawhPracRecordViewModel = JflawhPracRecordViewModel()
    @StateObject private var ksajwufslChatViewModel: KsajwufslChatViewModel = KsajwufslChatViewModel()
    @StateObject private var lwianzBAwaUserViewModel: LwianzBAwaUserViewModel = LwianzBAwaUserViewModel()
    @StateObject private var pwqomaACowCommentsViewModel: PwqomaACowCommentsViewModel = PwqomaACowCommentsViewModel()
    @StateObject private var vyualmaOiajVideoViewModel: VyualmaOiajVideoViewModel = VyualmaOiajVideoViewModel()
    
  var body: some Scene {
    WindowGroup {
        ZStack{
            VeualjNwajRoute(vealkIsShowBLock: $leriadIsShowBlock)
            NaciaDialog(naicaIsPresented: $leriadIsShowBlock){
                WYofavNaReportBlock()
            }
            LealoeoHUDView()
        }.environmentObject(naviManager)
            .environmentObject(jflawhPracRecordViewModel)
            .environmentObject(ksajwufslChatViewModel)
            .environmentObject(lwianzBAwaUserViewModel)
            .environmentObject(pwqomaACowCommentsViewModel)
            .environmentObject(vyualmaOiajVideoViewModel)
            .onAppear{
                LerotStorageManager.shared.initializeAllDefaults()
            }
    }
  }
}
