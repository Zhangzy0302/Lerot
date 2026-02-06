import SwiftUI

struct KalfwalxImage: View {

  let KalfwalxImageUrl: String
  let KalfwalxWidth: CGFloat?
  let KalfwalxHeight: CGFloat?
  let KalfwalxIsCircle: Bool
  let KalfwalxContentMode: ContentMode

  init(
    KalfwalxImageUrl: String,
    KalfwalxWidth: CGFloat? = nil,
    KalfwalxHeight: CGFloat? = nil,
    KalfwalxIsCircle: Bool = false,
    KalfwalxContentMode: ContentMode = .fill
  ) {
    self.KalfwalxImageUrl = KalfwalxImageUrl
    self.KalfwalxWidth = KalfwalxWidth
    self.KalfwalxHeight = KalfwalxHeight
    self.KalfwalxIsCircle = KalfwalxIsCircle
    self.KalfwalxContentMode = KalfwalxContentMode
      
  }

  var body: some View {
    let imageView = buildImage()
      .frame(width: KalfwalxWidth, height: KalfwalxHeight)
      .clipped()

    if KalfwalxIsCircle {
      imageView
        .clipShape(Circle())
        .overlay {
          Circle().stroke(LerWifaTheme.Color.mainPurple, lineWidth: 1)
        }
    } else {
      imageView
    }
  }
}

// MARK: - Build Image
extension KalfwalxImage {

  fileprivate func isLocalFilePath(_ path: String) -> Bool {
    path.hasPrefix("/")
  }

  fileprivate func isNetworkUrl(_ path: String) -> Bool {
    path.hasPrefix("http://") || path.hasPrefix("https://")
  }

  @ViewBuilder
  fileprivate func buildImage() -> some View {

    // 1️⃣ 空
    if KalfwalxImageUrl.isEmpty {
      placeholderView()
    }

    // 2️⃣ 网络图片
    else if isNetworkUrl(KalfwalxImageUrl),
            let url = URL(string: KalfwalxImageUrl) {

      AsyncImage(url: url) { phase in
        switch phase {
        case .empty:
          placeholderView()
        case .success(let image):
          image
            .resizable()
            .aspectRatio(contentMode: KalfwalxContentMode)
        case .failure:
          placeholderView()
        @unknown default:
          placeholderView()
        }
          
          
      }

    }

    // 3️⃣ 本地文件
    else if isLocalFilePath(KalfwalxImageUrl),
            let uiImage = UIImage(contentsOfFile: KalfwalxImageUrl) {

      Image(uiImage: uiImage)
        .resizable()
        .aspectRatio(contentMode: KalfwalxContentMode)

    }

    // 4️⃣ Asset
    else {

      Image(KalfwalxImageUrl)
        .resizable()
        .aspectRatio(contentMode: KalfwalxContentMode)

    }
  }

  fileprivate func placeholderView() -> some View {
    ZStack {
      Color(.systemGray5)
      Image(systemName: "photo")
        .foregroundColor(.gray)
    }
  }
}
