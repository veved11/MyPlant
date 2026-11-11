
import SwiftUI

struct PlantRowView: View {

    let plant: PlantReminder
    let onEdit: () -> Void
    let onToggleDone: () -> Void

    var body: some View {

        VStack(alignment: .leading, spacing: 6) {

            locationLabel

            HStack(alignment: .center, spacing: 22) {

                completionButton

                VStack(alignment: .leading, spacing: 10) {

                    plantName

                    HStack(spacing: 8) {

                        PlantCareChipView(
                            title: plant.light,
                            icon: "sun.max",
                            color: AppColors.sunlight
                        )

                        PlantCareChipView(
                            title: plant.waterAmount,
                            icon: "drop",
                            color: AppColors.water
                        )
                    }
                }
            }
        }
        .padding(.vertical, 4)
        .background(AppColors.background)
    }

    private var locationLabel: some View {

        HStack(spacing: 7) {

            Image(systemName: "paperplane")
                .font(AppTypography.careDetail)
                .foregroundStyle(AppColors.secondaryText)

            Text("in \(plant.room)")
                .font(AppTypography.plantLocation)
                .foregroundStyle(AppColors.secondaryText)
        }
        .padding(.leading, 44)
    }

    private var completionButton: some View {

        Button(action: onToggleDone) {

            Image(
                systemName: plant.isDoneToday
                    ? "checkmark.circle.fill"
                    : "circle"
            )
            .font(.system(size: 34))
            .foregroundStyle(
                plant.isDoneToday
                    ? AppColors.mint
                    : AppColors.secondaryText
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(
            plant.isDoneToday ? "Mark as not done" : "Mark as done"
        )
    }

    private var plantName: some View {

        Button(action: onEdit) {

            Text(plant.name)
                .font(AppTypography.plantName)
                .foregroundStyle(
                    plant.isDoneToday
                        ? AppColors.mutedText
                        : AppColors.primaryText
                )
                .strikethrough(plant.isDoneToday)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Edit \(plant.name)")
    }
}
