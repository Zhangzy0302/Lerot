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
    case bejadlUserPage(userId: Int, isMine: Bool)
    case wanvlzReportPage
    
    // chat
    case viqoanChatRoom
    
    // video
    case woinbiVideoDetail
    
    // record
    case rinxbmRecordHistory
    case potsnaRecordUpload
}

struct VeualjNwajRoute: View {
    @EnvironmentObject private var navManager: NavigationManager
    @Binding var vealkIsShowBLock: Bool
    
    private let storage = LerotStorageManager.shared
    
    var body: some View {
        NavigationStack(path: $navManager.path) {
            Group {
                let cqialmm = storage.getCurrentUserId()
                
                if(cqialmm == 7700) {
                    CbuaoiAwhgmGuidePage()
                }else {
                    FhuahNAhfloNavPage()
                }
            }
            .navigationDestination(for: VeulaNwiAppRoute.self) { route in
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
                case .bejadlUserPage(let userID, let isMine):
                    EwtaohNAgaUserPage(ewtaohnUserId: userID, ewtaohnIsMinePage: isMine)
                case .wanvlzReportPage:
                    IwbnaLcwReportPage()
                    
                    // chat
                case .viqoanChatRoom:
                    TuyancWyvzChatRoom(turyajIsShowBLock: $vealkIsShowBLock)
                    
                // video
                case .woinbiVideoDetail:
                    PwiancAUhVideoDetail(pwainzcIsShowBlock: $vealkIsShowBLock)
                // record
                case .rinxbmRecordHistory:
                    OwzmwpdRecordHistory()
                case .potsnaRecordUpload:
                    MrlnzlaUploadRecord()
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
