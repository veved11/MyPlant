
import SwiftUI

struct ProgressBarView: View {

    let completedCount: Int
    let totalCount: Int

    private var progress: Double {

        guard totalCount > 0 else { return 0 }

        return Double(completedCount) / Double(totalCount)
    }

    private var message: String {

        if totalCount > 0, completedCount == totalCount {
            return "All your plants feel loved today✨"
        }

        if completedCount > 0 {
            return "\(completedCount) of your plants feel loved today✨"
        }

        return "Your plants are waiting for a sip 💦"
    }

    var body: some View {

        VStack(spacing: 14) {

            Text(message)
                .font(AppTypography.progressMessage)
                .foregroundStyle(AppColors.primaryText)

            GeometryReader { geometry in

                ZStack(alignment: .leading) {

                    Capsule()
                        .fill(AppColors.surfaceSecondary)

                    Capsule()
                        .fill(AppColors.primary)
                        .frame(width: geometry.size.width * progress)
                }
            }
            .frame(height: 8)
        }
        .padding(.horizontal, 32)
    }
}
