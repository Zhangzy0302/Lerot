import SwiftUI

enum VeulaNwiAppRoute: Hashable {
    case guide
    case sign
    case agreementWeb(webUrl: String)
    case mainNav
    
    // mine
    case mySetting
    case myBlacklist
    case editInfo
}

struct VeualjNwajRoute: View {
    @State private var vealuxmAppPath: NavigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $vealuxmAppPath) {
            CbuaoiAwhgmGuidePage(appPath: $vealuxmAppPath)
        }.navigationDestination(for: VeulaNwiAppRoute.self) { route in
            switch route {
            case .guide:
                CbuaoiAwhgmGuidePage(appPath: $vealuxmAppPath)
            case .sign:
                ZwqhonWUaSign(appPath: $vealuxmAppPath)
            case .mainNav:
                FhuahNAhfloNavPage(appPath: $vealuxmAppPath)
            case .agreementWeb(let webUrl):
                LKAwhaAHwahdWeb(lakawnWnda: webUrl)
                
            // mine
            case .editInfo:
                GgaunAbAgdEditInfo()
            case .mySetting:
                NyaywMySetting(appPath: $vealuxmAppPath)
            case .myBlacklist:
                VnwualBlakclist()
            }
        }
    }
}

#Preview {
    VeualjNwajRoute()
}
