import SwiftUI
import AVFoundation

struct HorqhqVideoPlayer: View {

    let videoPath: String
    let autoPlay: Bool

    @State private var player: AVPlayer?
    @State private var isPlaying = false
    @State private var aspectRatio: CGFloat = 16 / 9
    
    

    var body: some View {
        ZStack {
            if let player {
                LerotPlayerLayerView(player: player)
                    .frame(maxWidth: .infinity)
                    .aspectRatio(aspectRatio, contentMode: .fit)
            } else {
                Color.black
                    .aspectRatio(16 / 9, contentMode: .fit)
            }

            // ▶️ / ⏸ 按钮
            if(!isPlaying){
                Image(systemName: "play.fill")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                        .padding(20)
                        .background(Color.black.opacity(0.4))
                        .clipShape(Circle())
            }
            
        }.onTapGesture {
            togglePlay()
        }
        .task(id: videoPath) {
            replaceVideo(with: videoPath)
        }
        .onDisappear {
            player?.pause()
        }
    }
}

private extension HorqhqVideoPlayer {

    func setup(with path: String) {
            replaceVideo(with: path)
        }

    func replaceVideo(with path: String) {
        guard let url = makeURL(from: path) else {
            print("❌ Invalid video path:", path)
            return
        }

        // 1️⃣ 停掉旧的
        player?.pause()
        isPlaying = false

        // 2️⃣ 创建新 item
        let item = AVPlayerItem(url: url)
        let newPlayer = AVPlayer(playerItem: item)
        player = newPlayer

        // 3️⃣ 重新算比例
        Task {
            await loadAspectRatio(from: item)
        }

        // 4️⃣ 是否自动播放
        if autoPlay {
            play()
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
        player?.play()
        isPlaying = true
    }

    func pause() {
        player?.pause()
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
