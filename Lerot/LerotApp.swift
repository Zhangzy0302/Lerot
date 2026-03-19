
import SwiftUI
import AdjustSdk

@main
struct LerotApp: App {
    @StateObject private var naviManager: NavigationManager = NavigationManager()
    
    @StateObject private var jflawhPracRecordViewModel: JflawhPracRecordViewModel = JflawhPracRecordViewModel()
    @StateObject private var ksajwufslChatViewModel: KsajwufslChatViewModel = KsajwufslChatViewModel()
    @StateObject private var lwianzBAwaUserViewModel: LwianzBAwaUserViewModel = LwianzBAwaUserViewModel()
    @StateObject private var pwqomaACowCommentsViewModel: PwqomaACowCommentsViewModel = PwqomaACowCommentsViewModel()
    @StateObject private var vyualmaOiajVideoViewModel: VyualmaOiajVideoViewModel = VyualmaOiajVideoViewModel()
    @StateObject private var lakcqlkIAPManager: LakcqlkIAPManager = LakcqlkIAPManager()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    var appDelegate
    
    init() {
        Task {
            await KshwuAkjueaGetPhoneInfo.shared.getPhoneInfo()
            UwhxAUBSKAdjustManager.shared.slwinxAiuwnInitialize()
        }
    }
    
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
                    lakcqlkIAPManager.woiqhnFqoietchProducts()
                }
            }
    }
  }
}

final class UwhxAUBSKAdjustManager: UIResponder, UIApplicationDelegate, AdjustDelegate {

  static let shared = UwhxAUBSKAdjustManager()

  private let slwinxAiuwnInstallToken = "y3eq9d"
  private let slwinxAiuwnPurchaseToken = "jtevk8"
  private let slwinxAiuwnAppToken = "4btn3i3555vk"

  private override init() {}

  // MARK: - 初始化
  func slwinxAiuwnInitialize() {
    guard
      let slwinxAiuwnConfitg = ADJConfig(
        appToken: slwinxAiuwnAppToken,
        environment: ADJEnvironmentProduction
      )
    else { return }

    slwinxAiuwnConfitg.logLevel = ADJLogLevel.verbose
    slwinxAiuwnConfitg.enableSendingInBackground()
    slwinxAiuwnConfitg.delegate = self
      print("Adjust:ta_distinct_id: \(RuwhxnAKjldkBInfoPer.shared.ruwhxnAKjldkDevid)")
      Adjust.addGlobalCallbackParameter(RuwhxnAKjldkBInfoPer.shared.ruwhxnAKjldkDevid, forKey: "ta_distinct_id")
    Adjust.attribution { attribution in
      self.adjustAttributionChanged(attribution)
    }
    Adjust.initSdk(slwinxAiuwnConfitg)
  }

  // MARK: - 安装事件
  func adjustAttributionChanged(_ attribution: ADJAttribution?) {
    let event = ADJEvent(eventToken: slwinxAiuwnInstallToken)
    Adjust.trackEvent(event)
  }

  // MARK: - 购买事件
  func slwinxAiuwnTrackPurchase(dollar: Double) {
    let event = ADJEvent(eventToken: slwinxAiuwnPurchaseToken)
    event?.setRevenue(dollar, currency: "USD")
    Adjust.trackEvent(event)
  }

  // MARK: - 请求 ATT 权限
//  func requestTrackingPermission() {
//    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//      if #available(iOS 14, *) {
//        ATTrackingManager.requestTrackingAuthorization { status in
//          print("ATT status:", status.rawValue)
//        }
//      }
//    }
//  }
}
