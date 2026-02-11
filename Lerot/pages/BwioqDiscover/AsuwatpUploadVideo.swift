import SwiftUI
import PhotosUI
import AVFoundation

struct AsuwatpUploadVideo: View {
    @State private var mrlnzlTitle: String = ""
    @State private var mrlnzlCopywriter: String = ""
    @FocusState private var mrlanxIsFocus_1: Bool
    @FocusState private var mrlanxIsFocus_2: Bool
    @State private var selectedVideoItem: PhotosPickerItem?
    @State private var asuwaVideoPath: String = ""
    @State private var asuwaVideoCover: String = ""
    
    @EnvironmentObject var asuwaNavi: NavigationManager
    @EnvironmentObject var asuwaVideoVM: VyualmaOiajVideoViewModel
    
    func copyVideoToLocal(url: URL) -> URL {
        let fileName = "video_\(Int(Date().timeIntervalSince1970)).mp4"
        let doc = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let targetURL = doc.appendingPathComponent(fileName)

        if FileManager.default.fileExists(atPath: targetURL.path) {
            try? FileManager.default.removeItem(at: targetURL)
        }

        try? FileManager.default.copyItem(at: url, to: targetURL)
        return targetURL
    }
    
    func handlePickedVideo(_ item: PhotosPickerItem) async {

        await MainActor.run {
            LealoeoHUD.showLoading()
        }

        defer {
            Task { @MainActor in
                LealoeoHUD.hideLoading()
            }
        }

        guard let data = try? await item.loadTransferable(type: Data.self) else {
            print("❌ 获取视频失败")
            return
        }

        let fileName = "video_\(Int(Date().timeIntervalSince1970)).mp4"
        let doc = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let localURL = doc.appendingPathComponent(fileName)

        do {
            try data.write(to: localURL)
            print("🎬 视频已保存：\(localURL.path)")
        } catch {
            print("❌ 写入失败：\(error)")
            return
        }

        if let cover = generateVideoCover(url: localURL),
           let coverPath = saveImageToLocal(cover) {

            await MainActor.run {
                asuwaVideoPath = localURL.path
                asuwaVideoCover = coverPath
            }

            print("🖼 封面生成成功")
        }
    }
    
    func generateVideoCover(url: URL) -> UIImage? {
        let asset = AVAsset(url: url)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true

        let time = CMTime(seconds: 0.1, preferredTimescale: 600)

        do {
            let cgImage = try generator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: cgImage)
        } catch {
            print("❌ 封面截取失败：\(error)")
            return nil
        }
    }
    
    func saveImageToLocal(_ image: UIImage) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }

        let name = "video_cover_\(Int(Date().timeIntervalSince1970)).jpg"
        let doc = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let url = doc.appendingPathComponent(name)

        try? data.write(to: url)
        return url.path
    }
    
    var body: some View {
        ZStack(alignment: .top){
            GeometryReader { geo in
              Image("cponlzna_main_bg")
                .resizable()
                .frame(maxHeight: .infinity)
                .clipped()
                .ignoresSafeArea()
            }
            VStack {
                VNauwAUWTopBar() {
                    Image("cponlzna_up_logo")
                        .resizable()
                        .frame(width: 102, height: 65)
                }
                ScrollView {
                    VStack(alignment: .leading, spacing: 20){
                        VStack(alignment: .leading, spacing: 16){
                            Text("Title:")
                                .font(LerWifaTheme.LerotFont.baigo(18))
                                .foregroundColor(.black)
                            NbykzwTextFiled(nbykzInputText: $mrlnzlTitle, nbykzIsFocus: $mrlanxIsFocus_1, nbykzPlaceholder: "Enter...")
                        }
                        VStack(alignment: .leading, spacing: 16){
                            Text("Copywriting:")
                                .font(LerWifaTheme.LerotFont.baigo(18))
                                .foregroundColor(.black)
                            NbykzwTextFiled(nbykzInputText: $mrlnzlCopywriter, nbykzIsFocus: $mrlanxIsFocus_2, nbykzPlaceholder: "Enter...", nbykzHeight: 132)
                        }
                        VStack(alignment: .leading, spacing: 16){
                            Text("Video:")
                                .font(LerWifaTheme.LerotFont.baigo(18))
                                .foregroundColor(.black)
                            PhotosPicker(
                                selection: $selectedVideoItem,
                                    matching: .videos
                            ) {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.white)
                                    .frame(width: 92, height: 108)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(LerWifaTheme.Color.mainPurple, lineWidth: 1)
                                    }.overlay{
                                        if(asuwaVideoCover.isEmpty){
                                            Image(systemName: "plus")
                                                .font(.system(size: 20))
                                                .foregroundColor(LerWifaTheme.Color.mainPurple)
                                        }else{
                                            ZStack(alignment: .center){
                                                KalfwalxImage(KalfwalxImageUrl: asuwaVideoCover, KalfwalxWidth: 92, KalfwalxHeight: 108)
                                                    .cornerRadius(20)
                                                Image("cponlzna_icon_play")
                                                    .resizable()
                                                    .frame(width: 20, height: 24)
                                            }
                                        }
                                        
                                    }
                            }.onChange(of: selectedVideoItem) { item in
                                guard let item else { return }

                                Task {
                                    await handlePickedVideo(item)
                                }
                            }
                            
                        }
                    }.padding(.horizontal, 20)
                }
            }
            if(!mrlanxIsFocus_1 && !mrlanxIsFocus_2) {
                VStack{
                    Spacer()
                    RyyeuaButton(ryyeuaWidth: 193, ryyeuaHeight: 48, ryyeuaText: "Upload", ryyeuaIsGradient: false, ryyeaAction: {
                        if(mrlnzlTitle.isEmpty || mrlnzlCopywriter.isEmpty) {
                            LealoeoHUD.toast("The text box cannot be empty.")
                            return
                        }
                        if(asuwaVideoPath.isEmpty || asuwaVideoCover.isEmpty) {
                            LealoeoHUD.toast("Please upload a video")
                            return
                        }
                        let asuNewWorkId = asuwaVideoVM.addNewWork(title: mrlnzlTitle, textContent: mrlnzlCopywriter, videoUrl: asuwaVideoPath, videoCover: asuwaVideoCover)
                        Task {
                            LealoeoHUD.showLoading()
                            await delay(0.5)
                            LealoeoHUD.hideLoading()
                            
                            asuwaNavi.pop()
                            asuwaNavi.push(VeulaNwiAppRoute.woinbiVideoDetail(videoId: asuNewWorkId))
                            LealoeoHUD.success("Upload successful")
                        }
                        
                    })
                }.padding(.bottom, 24)
            }
            
        }.navigationBarHidden(true)
            .onTapGesture {
                mrlanxIsFocus_1 = false
                mrlanxIsFocus_2 = false
            }
    }
}
