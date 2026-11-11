
import SwiftUI

struct PlantListView: View {

    @StateObject private var viewModel = PlantListViewModel()

    @State private var isShowingAddReminder = false
    @State private var plantToEdit: PlantReminder?

    @AppStorage("hasCreatedFirstReminder")
    private var hasCreatedFirstReminder = false

    private var areAllPlantsComplete: Bool {
        !viewModel.plants.isEmpty &&
        viewModel.completedCount == viewModel.plants.count
    }

    var body: some View {

        ZStack(alignment: .bottomTrailing) {

            AppColors.background
                .ignoresSafeArea()

            if hasCreatedFirstReminder {

                VStack(spacing: 0) {

                    screenHeader

                    Rectangle()
                        .fill(AppColors.divider)
                        .frame(height: 1)

                    if viewModel.plants.isEmpty {
                        emptyState
                    } else if areAllPlantsComplete {
                        allDoneState
                    } else {
                        plantsContent
                    }
                }

                addButton

            } else {

                StartPlantJourneyView {
                    plantToEdit = nil
                    isShowingAddReminder = true
                }
            }
        }
        .sheet(isPresented: $isShowingAddReminder) {
            reminderSheet
        }
    }

    private var reminderSheet: some View {

        Group {

            if let plant = plantToEdit {

                AddReminderView(
                    plant: plant,
                    onSave: { updatedPlant in
                        viewModel.update(plant, with: updatedPlant)
                    },
                    onDelete: { plantToDelete in
                        viewModel.delete(plantToDelete)
                    }
                )

            } else {

                AddReminderView(
                    onSave: { reminder in
                        viewModel.add(reminder)
                        hasCreatedFirstReminder = true
                    }
                )
            }
        }
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

    private var emptyState: some View {

        VStack {

            Spacer()

            Text("No reminders set yet..")
                .font(AppTypography.emptyState)
                .foregroundStyle(AppColors.secondaryText)

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    private var allDoneState: some View {

        VStack(spacing: 12) {

            Spacer()

            Image("PlantMascotWinking")
                .resizable()
                .scaledToFit()
                .frame(width: 219, height: 227)
                .background(
                    Color(hex: 0x14141A).opacity(0.58),
                    in: Circle()
                )
                .accessibilityHidden(true)

            Text("All Done! 🎉")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(AppColors.primaryText)

            Text("All Reminders Completed")
                .font(.system(size: 15))
                .foregroundStyle(AppColors.secondaryText)

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    private var plantsContent: some View {

        VStack(spacing: 0) {

            ProgressBarView(
                completedCount: viewModel.completedCount,
                totalCount: viewModel.plants.count
            )
            .padding(.top, 28)
            .padding(.bottom, 24)

            List {

                ForEach(viewModel.plants) { plant in

                    PlantRowView(
                        plant: plant,
                        onEdit: {
                            plantToEdit = plant
                            isShowingAddReminder = true
                        },
                        onToggleDone: {
                            viewModel.toggleDone(for: plant)
                        }
                    )
                    .listRowInsets(
                        EdgeInsets(
                            top: 0,
                            leading: 16,
                            bottom: 0,
                            trailing: 16
                        )
                    )
                    .listRowBackground(AppColors.background)
                    .listRowSeparatorTint(AppColors.divider)
                }
                .onDelete { offsets in

                    let plantsToDelete = offsets.map {
                        viewModel.plants[$0]
                    }

                    plantsToDelete.forEach(viewModel.delete)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }

    private var addButton: some View {

        Button {

            plantToEdit = nil
            isShowingAddReminder = true

        } label: {

            addButtonIcon
        }
        .buttonStyle(.plain)
        .padding(.trailing, 24)
        .padding(.bottom, 38)
        .accessibilityLabel("Add plant reminder")
    }

    @ViewBuilder
    private var addButtonIcon: some View {

        if #available(iOS 26.0, *) {

            Image(systemName: "plus")
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(.white)
                .frame(width: 44, height: 44)
                .glassEffect(
                    .regular
                        .tint(Color(hex: 0x338069))
                        .interactive(),
                    in: Circle()
                )

        } else {

            Image(systemName: "plus")
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(.white)
                .frame(width: 44, height: 44)
                .background(Color(hex: 0x338069), in: Circle())
        }
    }
}

#Preview {
    PlantListView()
}
