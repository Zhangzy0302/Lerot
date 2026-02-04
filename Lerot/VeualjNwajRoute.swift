import SwiftUI

enum VeulaNwiAppRoute: Hashable {
    case guide
    case sign(vealcStatus: ZwiaqhonSignPageStatus)
    case agreementWeb(webUrl: String)
    case mainNav
    
    // mine
    case mySetting
    case myBlacklist
    case editInfo
    case myWallet
    
    // user
    case bejadlUserPage
    case wanvlzReportPage
    
    // chat
    case viqoanChatRoom
}

struct VeualjNwajRoute: View {
    @EnvironmentObject private var navManager: NavigationManager
    @Binding var vealkIsShowBLock: Bool
    
    var body: some View {
        NavigationStack(path: $navManager.path) {
            CbuaoiAwhgmGuidePage().navigationDestination(for: VeulaNwiAppRoute.self) { route in
                switch route {
                case .guide:
                    CbuaoiAwhgmGuidePage()
                case .sign(let vealcStatus):
                    ZwqhonWUaSign(initialStatus: vealcStatus)
                case .mainNav:
                    FhuahNAhfloNavPage()
                case .agreementWeb(let webUrl):
                    LKAwhaAHwahdWeb(lakawnWnda: webUrl)
                    
                // mine
                case .editInfo:
                    GgaunAbAgdEditInfo()
                case .mySetting:
                    NyaywMySetting()
                case .myBlacklist:
                    VnwualBlakclist()
                case .myWallet:
                    OwuqcWallet()
                    
                // user
                case .bejadlUserPage:
                    EwtaohNAgaUserPage()
                case .wanvlzReportPage:
                    IwbnaLcwReportPage()
                    
                    // chat
                case .viqoanChatRoom:
                    TuyancWyvzChatRoom(turyajIsShowBLock: $vealkIsShowBLock)
                }
                
            }
        }
    }
}

class NavigationManager: ObservableObject {
    // 核心：全局共享的导航路径
    @Published var path: NavigationPath = NavigationPath()
    
    // 便捷方法：跳转到指定路由
    func push(_ route: VeulaNwiAppRoute) {
        path.append(route)
    }
    
    // 便捷方法：返回上一页
    func pop() {
        path.removeLast()
    }
    
    // 便捷方法：返回根页面
    func popToRoot() {
        path.removeLast(path.count)
    }
}
