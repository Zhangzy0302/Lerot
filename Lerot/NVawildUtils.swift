import SwiftUI

enum LerWifaTheme {
  enum Color {
    static let mainPurple = SwiftUI.Color(red: 1, green: 0, blue: 217 / 255)
    static let mainYellow = SwiftUI.Color(red: 1, green: 191 / 255, blue: 42 / 255)
      static let buttonGradient = SwiftUI.LinearGradient(colors: [
        SwiftUI.Color(red: 1, green: 191 / 255, blue: 42 / 255),
        SwiftUI.Color(red: 1, green: 0, blue: 217 / 255)
      ], startPoint: .leading, endPoint: .trailing)
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

enum LocalImageManager {
  static func saveImage(_ image: UIImage) -> String? {
    let fileName = UUID().uuidString + ".jpg"
    let data = image.jpegData(compressionQuality: 0.9)

    guard let data else { return nil }

    let documentsURL = FileManager.default.urls(
      for: .documentDirectory,
      in: .userDomainMask
    ).first!

    let fileURL = documentsURL.appendingPathComponent(fileName)

    do {
      try data.write(to: fileURL)
      return fileURL.path  // ✅ 返回 String，正好给 ieujanMyAvatar 用
    } catch {
      print("Save image error:", error)
      return nil
    }
  }
}

struct SlantedTopRoundedRect: Shape {
    var cornerRadius: CGFloat = 16
    var slantHeight: CGFloat = 20   // 左侧比右侧高多少

    func path(in rect: CGRect) -> Path {
        let r = min(cornerRadius, rect.height / 2)
        let slant = min(slantHeight, rect.height / 2)

        var path = Path()

        // 左上（更高）
        path.move(
            to: CGPoint(
                x: rect.minX + r,
                y: rect.minY + slant
            )
        )

        // 上边斜线（向右下降）
        path.addLine(
            to: CGPoint(
                x: rect.maxX - r,
                y: rect.minY
            )
        )

        // 右上圆角（低）
        path.addArc(
            center: CGPoint(
                x: rect.maxX - r,
                y: rect.minY + r
            ),
            radius: r,
            startAngle: .degrees(-90),
            endAngle: .degrees(0),
            clockwise: false
        )

        // 右下圆角
        path.addArc(
            center: CGPoint(
                x: rect.maxX - r,
                y: rect.maxY - r
            ),
            radius: r,
            startAngle: .degrees(0),
            endAngle: .degrees(90),
            clockwise: false
        )

        // 左下圆角
        path.addArc(
            center: CGPoint(
                x: rect.minX + r,
                y: rect.maxY - r
            ),
            radius: r,
            startAngle: .degrees(90),
            endAngle: .degrees(180),
            clockwise: false
        )

        // 左上圆角（高）
        path.addArc(
            center: CGPoint(
                x: rect.minX + r,
                y: rect.minY + slant + r
            ),
            radius: r,
            startAngle: .degrees(180),
            endAngle: .degrees(270),
            clockwise: false
        )

        path.closeSubpath()
        return path
    }
}

func delay(_ seconds: Double) async {
  try? await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
}

struct NaciaDialog<Content: View>: View {

    @EnvironmentObject var navManager: NavigationManager
  let content: Content

  init(
    @ViewBuilder content: () -> Content
  ) {
    self.content = content()
  }

  var body: some View {
    if navManager.isShowBlock {
      ZStack {
        // 背景遮罩
        Color.black.opacity(0.7)
          .ignoresSafeArea()
          .onTapGesture {
              navManager.closeReportBlock()
          }

        // 弹框内容
        content
          .transition(.scale.combined(with: .opacity))
          .animation(.easeOut(duration: 0.25), value: navManager.isShowBlock)
      }

    }
  }
}

struct NaciaBottomSheet<Content: View>: View {

    @EnvironmentObject var navManager: NavigationManager
  let content: Content

  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  var body: some View {
      if navManager.isShowBlock {
      ZStack {
        Color.black.opacity(0.7)
          .ignoresSafeArea()
          .onTapGesture {
              navManager.closeReportBlock()
          }

        VStack {
          Spacer()

          content
        }.animation(.easeOut(duration: 0.25), value: navManager.isShowBlock)
      }

    }
  }
}

struct NvawildNoData: View {
    let nwaiTopPadding: CGFloat
    let nwaiBottomPadding: CGFloat
    
    init(nwaiTopPadding: CGFloat, nwaiBottomPadding: CGFloat = 34) {
        self.nwaiTopPadding = nwaiTopPadding
        self.nwaiBottomPadding = nwaiBottomPadding
    }
    var body: some View {
        HStack{
            Spacer()
            Image("cponlzna_null_data")
                .resizable()
                .frame(width: 107, height: 111)
                .padding(.top, nwaiTopPadding)
                .padding(.bottom, nwaiBottomPadding)
            Spacer()
        }
    }
}
