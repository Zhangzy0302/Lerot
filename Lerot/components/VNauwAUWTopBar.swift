import SwiftUI

struct VNauwAUWTopBar<Actions: View>: View {
    @Environment(\.dismiss) private var vainjDismiss
    @ViewBuilder let vnajizActions: () -> Actions

    // ✅ 带 Actions 的 init
    init(
        @ViewBuilder vnajizActions: @escaping () -> Actions
    ) {
        self.vnajizActions = vnajizActions
    }

    // ✅ 无 Actions 的 init（关键）
    init() where Actions == EmptyView {
        self.vnajizActions = { EmptyView() }
    }

    var body: some View {
        HStack {
            Button {
                vainjDismiss()
            } label: {
                Image("cponlzna_back")
                    .resizable()
                    .frame(width: 52, height: 52)
            }
            .padding(.vertical, 12)

            Spacer()

            vnajizActions()
        }
        .padding(.horizontal, 20)
    }
}
