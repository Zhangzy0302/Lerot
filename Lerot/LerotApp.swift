
import SwiftUI

@main
struct LerotApp: App {
    @StateObject private var naviManager: NavigationManager = NavigationManager()
    
    @StateObject private var jflawhPracRecordViewModel: JflawhPracRecordViewModel = JflawhPracRecordViewModel()
    @StateObject private var ksajwufslChatViewModel: KsajwufslChatViewModel = KsajwufslChatViewModel()
    @StateObject private var lwianzBAwaUserViewModel: LwianzBAwaUserViewModel = LwianzBAwaUserViewModel()
    @StateObject private var pwqomaACowCommentsViewModel: PwqomaACowCommentsViewModel = PwqomaACowCommentsViewModel()
    @StateObject private var vyualmaOiajVideoViewModel: VyualmaOiajVideoViewModel = VyualmaOiajVideoViewModel()
    @StateObject private var lakcqlkIAPManager: LakcqlkIAPManager = LakcqlkIAPManager()
    
  var body: some Scene {
    WindowGroup {
        ZStack{
            VeualjNwajRoute()
            NaciaDialog(){
                WYofavNaReportBlock()
            }
            LealoeoHUDView()
        }.environmentObject(naviManager)
            .environmentObject(jflawhPracRecordViewModel)
            .environmentObject(ksajwufslChatViewModel)
            .environmentObject(lwianzBAwaUserViewModel)
            .environmentObject(pwqomaACowCommentsViewModel)
            .environmentObject(vyualmaOiajVideoViewModel)
            .environmentObject(lakcqlkIAPManager)
            .onAppear{
                LerotStorageManager.shared.initializeAllDefaults()
                Task{
                    await lakcqlkIAPManager.woiqhnFqoietchProducts()
                }
            }
    }
  }
}
