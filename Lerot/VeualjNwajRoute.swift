import SwiftUI

enum VeulaNwiAppRoute: Hashable {
    case guide
    case sign
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
            
            }
        }
    }
}
