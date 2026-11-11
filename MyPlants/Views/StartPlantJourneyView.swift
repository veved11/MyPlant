import SwiftUI

struct StartPlantJourneyView: View {

    let onSetReminder: () -> Void

    var body: some View {

        VStack(spacing: 0) {

            screenHeader

            Rectangle()
                .fill(AppColors.divider)
                .frame(height: 1)

            Spacer(minLength: 48)

            Image("PlantMascot")
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 180)
                .accessibilityHidden(true)

            Text("Start your plant journey!")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(AppColors.primaryText)
                .padding(.top, 30)

            Text("Now all your plants will be in one place and\nwe will help you take care of them :) 🪴")
                .font(.system(size: 14))
                .foregroundStyle(AppColors.secondaryText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                .padding(.top, 18)

            Button(action: onSetReminder) {
                buttonLabel
            }
            .buttonStyle(.plain)
            .padding(.top, 88)

            Spacer(minLength: 48)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background.ignoresSafeArea())
    }

    private var screenHeader: some View {

        HStack {

            Text("My Plants 🌱")
                .font(AppTypography.screenTitle)
                .foregroundStyle(AppColors.primaryText)

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 38)
        .padding(.bottom, 18)
    }

    @ViewBuilder
    private var buttonLabel: some View {

        if #available(iOS 26.0, *) {

            buttonText
                .glassEffect(
                    .regular
                        .tint(Color(hex: 0x338069))
                        .interactive(),
                    in: Capsule()
                )

        } else {

            buttonText
                .background(Color(hex: 0x338069), in: Capsule())
                .overlay {
                    Capsule()
                        .stroke(.white.opacity(0.96), lineWidth: 1)
                }
        }
    }

    private var buttonText: some View {

        Text("Set Plant Reminder")
            .font(.system(size: 18, weight: .medium))
            .foregroundStyle(.white)
            .frame(width: 280, height: 42)
            .contentShape(Capsule())
    }
}

#Preview {
    StartPlantJourneyView(onSetReminder: {})
}
