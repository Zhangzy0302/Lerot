import SwiftUI
import AVFoundation

struct HorqhqVideoPlayer: View {

    let player: AVPlayer
    let videoPath: String
    let autoPlay: Bool

    @State private var isPlaying = false
    @State private var aspectRatio: CGFloat = 16 / 9
    @State private var endObserver: NSObjectProtocol?

    var body: some View {
        ZStack {
            LerotPlayerLayerView(player: player)
                .frame(maxWidth: .infinity)
                .aspectRatio(aspectRatio, contentMode: .fit)

            if !isPlaying {
                Image(systemName: "play.fill")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .padding(20)
                    .background(Color.black.opacity(0.4))
                    .clipShape(Circle())
            }
        }
        .onTapGesture {
            togglePlay()
        }
        .task(id: videoPath) {
            replaceVideo(with: videoPath)
        }
        .onDisappear {
            pause()
            removeEndObserver()
        }
    }
}

private extension HorqhqVideoPlayer {

    func replaceVideo(with path: String) {
            guard let url = makeURL(from: path) else {
                print("❌ Invalid video path:", path)
                return
            }

            // 1️⃣ 停止 & 重置
            pause()
            removeEndObserver()

            // 2️⃣ 替换 item（关键）
            let item = AVPlayerItem(url: url)
            player.replaceCurrentItem(with: item)

            // 3️⃣ 播放结束监听
            endObserver = NotificationCenter.default.addObserver(
                forName: .AVPlayerItemDidPlayToEndTime,
                object: item,
                queue: .main
            ) { _ in
                player.seek(to: .zero)
                player.play()
                isPlaying = true
            }

            // 4️⃣ 更新比例
            Task {
                await loadAspectRatio(from: item)
            }

            // 5️⃣ 自动播放
            if autoPlay {
                play()
            }
        }

        func removeEndObserver() {
            if let endObserver {
                NotificationCenter.default.removeObserver(endObserver)
                self.endObserver = nil
            }
        }

    func makeURL(from path: String) -> URL? {
        if path.hasPrefix("http://") || path.hasPrefix("https://") {
            return URL(string: path)
        }
        if path.hasPrefix("/") {
            return URL(fileURLWithPath: path)
        }
        if path.hasPrefix("file://") {
            return URL(string: path)
        }
        return nil
    }

    func loadAspectRatio(from item: AVPlayerItem) async {
        do {
            let tracks = try await item.asset.load(.tracks)
            guard let track = tracks.first(where: { $0.mediaType == .video }) else { return }

            let size = try await track.load(.naturalSize)
            let transform = try await track.load(.preferredTransform)
            let realSize = size.applying(transform)

            let w = abs(realSize.width)
            let h = abs(realSize.height)
            guard w > 0, h > 0 else { return }

            await MainActor.run {
                aspectRatio = w / h
            }
        } catch {
            print("❌ Load ratio failed:", error)
        }
    }

    func togglePlay() {
        isPlaying ? pause() : play()
    }

    func play() {
        player.play()
        isPlaying = true
    }

    func pause() {
        player.pause()
        isPlaying = false
    }
}

struct LerotPlayerLayerView: UIViewRepresentable {
    let player: AVPlayer

    func makeUIView(context: Context) -> PlayerContainerView {
        let view = PlayerContainerView()
        view.playerLayer.player = player
        view.backgroundColor = .black
        return view
    }

    func updateUIView(_ uiView: PlayerContainerView, context: Context) {
        uiView.playerLayer.frame = uiView.bounds
    }

    class PlayerContainerView: UIView {
        let playerLayer = AVPlayerLayer()

        override init(frame: CGRect) {
            super.init(frame: frame)
            layer.addSublayer(playerLayer)
            playerLayer.videoGravity = .resizeAspect
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            playerLayer.frame = bounds
        }
    }
}
