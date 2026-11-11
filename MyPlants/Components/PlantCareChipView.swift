
import SwiftUI

struct PlantCareChipView: View {

    let title: String
    let icon: String
    let color: Color

    var body: some View {

        Label(title, systemImage: icon)
            .font(AppTypography.careDetail)
            .foregroundStyle(color)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(
                AppColors.surface,
                in: Capsule()
            )
    }
}
