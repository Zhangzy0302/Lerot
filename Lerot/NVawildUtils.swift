import SwiftUI

enum LerWifaTheme {
    enum Color {
        static let mainPurple = SwiftUI.Color(red: 1, green: 0, blue: 217/255);
        static let mainYellow = SwiftUI.Color(red: 1, green: 191/255, blue: 42/255)
    }
    
    enum LerotFont {

      // MARK: - MiSans
      static func miSans(_ size: CGFloat) -> Font {
        .custom("MiSans-Regular", size: size)
      }

      static func miSansSemibold(_ size: CGFloat) -> Font {
        .custom("MiSans-Semibold", size: size)
      }

      // MARK: - Neoneon
      static func neoneon(_ size: CGFloat) -> Font {
        .custom("Neoneon", size: size)
      }

      // MARK: - Baigo
      static func baigo(_ size: CGFloat) -> Font {
        .custom("Baigo-Regular", size: size)
      }
    }
}
