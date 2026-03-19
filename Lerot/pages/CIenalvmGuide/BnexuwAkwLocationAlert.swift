import SwiftUI
import CoreLocation

struct BnexuwAkwLocationAlert: View {
    
    @Binding var vhjreAxjkwuaIsShow: Bool
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var xuweAlxwIsCheckingSettings = false
    
    func xuweAlxwlGoToSettings() {
            xuweAlxwIsCheckingSettings = true
            
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(url)
        }

    func xuweAlxwlCheckLocatrion() {
        let manager = CLLocationManager()
        let status = manager.authorizationStatus
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            vhjreAxjkwuaIsShow = false
        }
    }
    
    var body: some View {
        ZStack{
            Color.black.opacity(0.5).ignoresSafeArea()
                .onTapGesture {
                    vhjreAxjkwuaIsShow = false
                }
            VStack(spacing: 20){
                ZStack(alignment: .bottom){
                    Image("ixwhaAKuwkxuA")
                        .resizable()
                        .frame(width: 315, height: 355)
                    Text("This app needs to access your location information to provide more personalized services. We promise that your location data will be strictly confidential and will only be used with your explicit authorization to enhance your user experience.")
                        .font(LerWifaTheme.LerotFont.miSans(16))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .frame(width: 256)
                        .padding(.bottom, 60)
                }
                Button(action: {
                    xuweAlxwlGoToSettings()
                }) {
                    Text("Go to settings")
                        .font(LerWifaTheme.LerotFont.miSansSemibold(20))
                        .foregroundStyle(.white)
                        .frame(width: 229, height: 50)
                        .background{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(LerWifaTheme.Color.mainPurple)
                        }
                }
            }
        }.onChange(of: scenePhase) { newPhase in
            if newPhase == .active && xuweAlxwIsCheckingSettings {
                xuweAlxwIsCheckingSettings = false
                
                // 可选：重新检查权限
                xuweAlxwlCheckLocatrion()
            }
        }
    }
}
