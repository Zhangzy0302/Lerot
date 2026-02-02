
import SwiftUI

struct FhuahNAhfloNavPage: View {
    
    @State private var fluahcCurrentIndex: Int = 0
    
    
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
              Image("cponlzna_main_bg")
                .resizable()
                .frame(maxHeight: .infinity)
                .clipped()
                .ignoresSafeArea()
            }
            
        }
    }
}

#Preview {
    FhuahNAhfloNavPage()
}
