
import SwiftUI

@main
struct LerotApp: App {
    @State private var leriadIsShowBlock: Bool = false
    @StateObject private var naviManager: NavigationManager = NavigationManager()
    
  var body: some Scene {
    WindowGroup {
        ZStack{
            VeualjNwajRoute(vealkIsShowBLock: $leriadIsShowBlock)
            NaciaDialog(naicaIsPresented: $leriadIsShowBlock){
                WYofavNaReportBlock()
            }
            LealoeoHUDView()
        }.environmentObject(naviManager)
    }
  }
}
