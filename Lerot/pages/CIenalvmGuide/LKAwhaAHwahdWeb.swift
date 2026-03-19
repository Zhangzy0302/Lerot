import SwiftUI
import WebKit
import ScreenShield

struct LKAwhaAHwahInAppWebView: UIViewRepresentable {

    let urlString: String
    var onLoadingStart: (() -> Void)?
    var onLoadingFinish: ((Int) -> Void)?
    var onClose: (() -> Void)?
    var onRecharge: ((String, String) -> Void)?

    func makeCoordinator() -> Coordinator {
      Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {

      let config = WKWebViewConfiguration()
      let contentController = WKUserContentController()

      // JS 回调
      contentController.add(context.coordinator, name: "rechargePay")
      contentController.add(context.coordinator, name: "Close")
      contentController.add(context.coordinator, name: "openBrowser")

      config.userContentController = contentController
      config.mediaTypesRequiringUserActionForPlayback = []
      config.allowsInlineMediaPlayback = true

      let webView = WKWebView(frame: .zero, configuration: config)

      webView.uiDelegate = context.coordinator
      webView.navigationDelegate = context.coordinator
      webView.isOpaque = false
      webView.backgroundColor = .clear
      webView.scrollView.backgroundColor = .clear
      webView.scrollView.contentInsetAdjustmentBehavior = .never
      webView.scrollView.contentInset = .zero
      webView.scrollView.scrollIndicatorInsets = .zero
      // 网页内左滑返回
      webView.allowsBackForwardNavigationGestures = true

      // ✅ 直接用 urlString
      if let url = URL(string: urlString) {
        webView.load(URLRequest(url: url))
      }

      return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
    }

    @MainActor
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate {

      var parent: LKAwhaAHwahInAppWebView
      var startTime: Date?

      init(_ parent: LKAwhaAHwahInAppWebView) {
        self.parent = parent
      }

      // MARK: - 加载开始
      func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        startTime = Date()
        parent.onLoadingStart?()
      }

      // MARK: - 加载结束
      func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        if let start = startTime {
          let duration = Int(Date().timeIntervalSince(start) * 1000)
          parent.onLoadingFinish?(duration)
        }
      }

      // MARK: - 外链拦截
      func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
      ) {

        if let url = navigationAction.request.url,
          !["http", "https", "file", "about", "javascript"].contains(url.scheme)
        {

          UIApplication.shared.open(url)
          decisionHandler(.cancel)
          return
        }

        decisionHandler(.allow)
      }
        
        // 跳转商店
        func webView(
          _ webView: WKWebView,
          createWebViewWith configuration: WKWebViewConfiguration,
          for navigationAction: WKNavigationAction,
          windowFeatures: WKWindowFeatures
        ) -> WKWebView? {

            guard let url = navigationAction.request.url else { return nil }

            let urlString = url.absoluteString.lowercased()
            if url.scheme == "itms-apps"
                || url.scheme == "itms-services"
                || urlString.contains("apps.apple.com")
            {
                DispatchQueue.main.async {
                    UIApplication.shared.open(url)
                }
                return nil
            }

            return nil
        }

      func webView(
        _ webView: WKWebView,
        requestMediaCapturePermissionFor origin: WKSecurityOrigin,
        initiatedByFrame frame: WKFrameInfo,
        type: WKMediaCaptureType,
        decisionHandler: @escaping (WKPermissionDecision) -> Void
      ) {
        decisionHandler(.grant)
      }

      // MARK: - JS 通信
      func userContentController(
        _ userContentController: WKUserContentController,
        didReceive message: WKScriptMessage
      ) {

        if message.name == "rechargePay",
          let dict = message.body as? [String: Any],
          let orderCode = dict["orderCode"] as? String,
          let batchNo = dict["batchNo"] as? String
        {

          parent.onRecharge?(orderCode, batchNo)
        }

        if message.name == "Close" {
          parent.onClose?()
        }
          if message.name == "openBrowser" {

              var urlString: String?

              if let dict = message.body as? [String: Any] {
                  urlString = dict["url"] as? String
              } else if let str = message.body as? String {
                  urlString = str
              }

              guard var urlString else { return }

              if !urlString.hasPrefix("http") {
                  urlString = "https://" + urlString
              }

              if let url = URL(string: urlString) {
                  DispatchQueue.main.async {
                      UIApplication.shared.open(url)
                  }
              }
          }
           
      }

    }

}

struct LKAwhaAHwahdWeb: View {
  let lakawnWnda: String
    
    @EnvironmentObject var iapManager: LakcqlkIAPManager
    @EnvironmentObject var lkajsuwNavi: NavigationManager
    
    @State private var loadingProgress: Double = 0
    @State private var isLoading: Bool = true

  var body: some View {
      ZStack() {
          if VaiETdgbaAppStorage.vaiETdgbaIsB && isLoading {
              GeometryReader { geo in
                Image("cponlzna_guide_bg")
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(maxHeight: .infinity)
                  .clipped()
                  .ignoresSafeArea()
              }
              LinearGradient(
                colors: [
                  Color(red: 1, green: 142 / 255, blue: 238 / 255),
                  .white.opacity(0),
                ], startPoint: .bottom, endPoint: .top
              )
              .ignoresSafeArea()
          }
          
          VStack {
              if !VaiETdgbaAppStorage.vaiETdgbaIsB {
                  VNauwAUWTopBar()
              }
              
              LKAwhaAHwahInAppWebView(
                urlString: lakawnWnda,
                onLoadingStart: {
                  isLoading = true
                },
                onLoadingFinish: { duration in
                  isLoading = false

                  if VaiETdgbaAppStorage.vaiETdgbaIsB {
                    Task {
                      try await VNehalAUApiCall()
                        .eskaLAkafLoadingTimeRecord(duration)
                    }
                  }
                },
                onClose: {
                    VaiETdgbaAppStorage.vaiETdgbaUserToken = ""
      //              RuwhxnAKjldkBInfoPer.saveUserToken("")
                    lkajsuwNavi.popToRoot()
                },
                onRecharge: { orderCode, batchNo in
                  yuryxnAhwifkUsersOrdercode = orderCode
                  Task {
                      iapManager.cmeuoALwlnRecharge(batchNo)
                  }
                }
              )
              .ignoresSafeArea()
              
          }
          // 加载遮罩（等价 Flutter loading UI）
          if isLoading {

            VStack(spacing: 30) {
                Spacer()
              ProgressView()
                .scaleEffect(1.5)
                .tint(.black)

              Text("loading...")
                    .font(LerWifaTheme.LerotFont.baigo(16))
                .foregroundColor(.black)
            }
            .padding(.bottom, 100)
          }
      }
    .navigationBarHidden(true).toolbar(.hidden, for: .navigationBar)  // 隐藏整个导航栏
    .protectScreenshot()  // Protect the view
    .ignoresSafeArea()
    .onAppear {
      ScreenShield.shared.protectFromScreenRecording()  // Protect Screen-Recording
    }
  }
}
