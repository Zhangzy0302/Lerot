import SwiftUI
import WebKit

struct LKAwhaAHwahInAppWebView: UIViewRepresentable {

  let urlString: String

  func makeUIView(context: Context) -> WKWebView {
    let webView = WKWebView()
    return webView
  }

  func updateUIView(_ webView: WKWebView, context: Context) {
    guard let url = URL(string: urlString) else { return }
    let request = URLRequest(url: url)
    webView.load(request)
  }

}

struct LKAwhaAHwahdWeb: View {
  let lakawnWnda: String

  var body: some View {
    VStack {
        VNauwAUWTopBar()
        LKAwhaAHwahInAppWebView(urlString: lakawnWnda)
        .ignoresSafeArea()
    }.navigationBarHidden(true).toolbar(.hidden, for: .navigationBar)  // 隐藏整个导航栏
  }
}
