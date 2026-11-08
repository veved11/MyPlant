import SwiftUI

// يعرض رسالة تذكير وشريطًا يوضح نسبة إنجاز العناية بالنباتات.
struct ProgressBarView: View {
    let completedCount: Int
    let totalCount: Int

    // تحسب نسبة الإنجاز، وتتعامل مع حالة عدم وجود نباتات.
    private var progress: Double {
        guard totalCount > 0 else { return 0 }
        return Double(completedCount) / Double(totalCount)
    }

    // تختار رسالة مناسبة بحسب عدد النباتات المكتملة.
    private var message: String {
        if totalCount > 0 && completedCount == totalCount {
            return "All your plants feel loved today ✨"
        } else {
            return "Your plants are waiting for a sip 💦"
        }
    }

    var body: some View {
        VStack(spacing: 8) {
            Text(message)
                .font(.footnote)
                .foregroundStyle(.white)

            ProgressView(value: progress)
                .tint(.mint)
        }
        .padding(.horizontal)
    }
}
