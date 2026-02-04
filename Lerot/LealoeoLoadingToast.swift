import SwiftUI

enum LealoeoHUD {

  static func toast(_ text: String) {
    Task { @MainActor in
      LealoeoLoadingToast.shared.showToast(text)
    }
  }

  static func success(_ text: String) {
    Task { @MainActor in
      LealoeoLoadingToast.shared.showToast(text, type: .success)
    }
  }

  static func error(_ text: String) {
    Task { @MainActor in
      LealoeoLoadingToast.shared.showToast(text, type: .error)
    }
  }

  static func showLoading() {
    Task { @MainActor in
      LealoeoLoadingToast.shared.showLoading()
    }
  }

  static func hideLoading() {
    Task { @MainActor in
      LealoeoLoadingToast.shared.hideLoading()
    }
  }
}

@MainActor
final class LealoeoLoadingToast: ObservableObject {

  static let shared = LealoeoLoadingToast()

  @Published var toast: LealoeoToast?
  @Published var isLoading: Bool = false

  private init() {}

  func showToast(
    _ text: String,
    type: LealoeoToastType = .normal,
    duration: TimeInterval = 1.8
  ) {
    toast = LealoeoToast(text: text, type: type)

    Task {
      try? await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
      self.toast = nil
    }
  }

  func showLoading() {
    isLoading = true
  }

  func hideLoading() {
    isLoading = false
  }
}


struct LealoeoHUDView: View {

  @ObservedObject private var hud = LealoeoLoadingToast.shared

  var body: some View {
    ZStack {
    // 🚫 Loading 时的点击拦截层
          if hud.isLoading {
            Color.black
              .opacity(0.001) // 必须 > 0，否则不拦截事件
              .ignoresSafeArea()
          }
      // Loading
      if hud.isLoading {
        // 弹窗内容
        VStack(spacing: 12) {
          ProgressView()
            .progressViewStyle(.circular)
            .scaleEffect(1.4)
            .tint(.white)

          Text("Loading...")
            .foregroundColor(.white)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 20)
        .background(
          RoundedRectangle(cornerRadius: 20)
            .fill(.black.opacity(0.8))
            .frame(width: 120, height: 120)
            .blur(radius: 6)
            .cornerRadius(20))
        .padding(.horizontal, 40)

      }

      // Toast
      if let toast = hud.toast {
        VStack {
          Spacer()
            VStack(spacing: 16) {

            if let icon = toast.type.icon {
              Image(systemName: icon)
                    .frame(width: 30)
                .foregroundColor(.white)
            }

            Text(toast.text)
              .font(.system(size: 14, weight: .medium))
              .foregroundColor(.white)
          }
          .padding(.horizontal, 20)
          .padding(.vertical, 14)
          .background(toast.type.backgroundColor)
          .cornerRadius(20)
          .transition(.opacity.combined(with: .move(edge: .top)))

          Spacer()
        }
      }
    }
    .animation(.easeInOut, value: hud.isLoading)
  }
}

enum LealoeoToastType {
  case normal
  case success
  case error

  var backgroundColor: Color {
    switch self {
    case .normal:
      return .black.opacity(0.85)
    case .success:
      return .green.opacity(0.9)
    case .error:
      return .red.opacity(0.9)
    }
  }

  var icon: String? {
    switch self {
    case .success:
      return "checkmark.circle.fill"
    case .error:
      return "xmark.octagon.fill"
    default:
      return nil
    }
  }
}

struct LealoeoToast {
  let text: String
  let type: LealoeoToastType
}
