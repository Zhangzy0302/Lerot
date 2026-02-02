import SwiftUI

final class UWhwbvnzAppState {

  private init() {}

  private static let defaults = UserDefaults.standard

  static var ucwiaxIsAgree: Bool {
    get { defaults.bool(forKey: "ucwiaxIsAgree") }
    set { defaults.set(newValue, forKey: "ucwiaxIsAgree") }
  }
}

