import SwiftUI

struct AddReminderView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: AddReminderViewModel
    @State private var isShowingDeleteConfirmation = false

    private let plant: PlantReminder?
    private let onSave: (PlantReminder) -> Void
    private let onDelete: ((PlantReminder) -> Void)?

    init(
        plant: PlantReminder? = nil,
        onSave: @escaping (PlantReminder) -> Void,
        onDelete: ((PlantReminder) -> Void)? = nil
    ) {
        self.plant = plant
        self.onSave = onSave
        self.onDelete = onDelete
        _viewModel = StateObject(
            wrappedValue: AddReminderViewModel(plant: plant)
        )
    }

    var body: some View {
        VStack(spacing: 28) {
            header
            plantNameField
            roomAndLightFields
            wateringFields

            deleteButton

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 20)
        .padding(.top, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background.ignoresSafeArea())
        .preferredColorScheme(.dark)
        .confirmationDialog(
            "Delete Reminder?",
            isPresented: $isShowingDeleteConfirmation,
            titleVisibility: .visible
        ) {
            Button("Delete Reminder", role: .destructive) {
                guard let plant else { return }
                onDelete?(plant)
                dismiss()
            }

            Button("Cancel", role: .cancel) {}
        }
    }

    private var header: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
                    .background(AppColors.surface, in: Circle())
            }
            .accessibilityLabel("Cancel")

            Spacer()

            Text(viewModel.isEditing ? "Edit Reminder" : "Set Reminder")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)

            Spacer()

            Button {
                guard let reminder = viewModel.makeReminder() else { return }
                onSave(reminder)
                dismiss()
            } label: {
                Image(systemName: "checkmark")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
                    .background(AppColors.primary, in: Circle())
            }
            .disabled(!viewModel.canSave)
            .opacity(viewModel.canSave ? 1 : 0.5)
            .accessibilityLabel("Save reminder")
        }
    }

    private var plantNameField: some View {
        HStack(spacing: 8) {
            Text("Plant Name")
                .foregroundStyle(.white)

            TextField("Pothos", text: $viewModel.plantName)
                .textInputAutocapitalization(.words)
                .foregroundStyle(.white)
        }
        .font(.system(size: 16))
        .padding(.horizontal, 20)
        .frame(height: 64)
        .background(AppColors.surface, in: Capsule())
    }

    private var roomAndLightFields: some View {
        VStack(spacing: 0) {
            selectionRow(
                title: "Room",
                systemImage: "paperplane",
                selection: $viewModel.room,
                options: viewModel.rooms
            )

            Divider()
                .overlay(AppColors.divider)

            selectionRow(
                title: "Light",
                systemImage: "sun.max",
                selection: $viewModel.light,
                options: viewModel.lightOptions
            )
        }
        .padding(.horizontal, 18)
        .background(AppColors.surface, in: RoundedRectangle(cornerRadius: 28))
    }

    private var wateringFields: some View {
        VStack(spacing: 0) {
            selectionRow(
                title: "Watering Days",
                systemImage: "drop",
                selection: $viewModel.wateringDays,
                options: viewModel.wateringOptions
            )

            Divider()
                .overlay(AppColors.divider)

            selectionRow(
                title: "Water",
                systemImage: "drop",
                selection: $viewModel.waterAmount,
                options: viewModel.waterAmounts
            )
        }
        .padding(.horizontal, 18)
        .background(AppColors.surface, in: RoundedRectangle(cornerRadius: 28))
    }

    @ViewBuilder
    private var deleteButton: some View {
        if plant != nil, onDelete != nil {
            Button(role: .destructive) {
                isShowingDeleteConfirmation = true
            } label: {
                Text("Delete Reminder")
                    .font(.system(size: 16))
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        AppColors.surface,
                        in: Capsule()
                    )
            }
            .padding(.top, 16)
        }
    }

    private func selectionRow(
        title: String,
        systemImage: String,
        selection: Binding<String>,
        options: [String]
    ) -> some View {
        Menu {
            ForEach(options, id: \.self) { option in
                Button(option) {
                    selection.wrappedValue = option
                }
            }
        } label: {
            HStack(spacing: 10) {
                Image(systemName: systemImage)
                    .foregroundStyle(.white)
                    .frame(width: 18)

                Text(title)
                    .foregroundStyle(.white)

                Spacer()

                Text(selection.wrappedValue)
                    .foregroundStyle(AppColors.secondaryText)

                Image(systemName: "chevron.up.chevron.down")
                    .font(.system(size: 11))
                    .foregroundStyle(AppColors.secondaryText)
            }
            .font(.system(size: 16))
            .frame(height: 48)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
