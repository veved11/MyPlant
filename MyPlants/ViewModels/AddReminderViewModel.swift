
import Combine
import Foundation

final class AddReminderViewModel: ObservableObject {

    @Published var plantName: String
    @Published var room: String
    @Published var light: String
    @Published var wateringDays: String
    @Published var waterAmount: String

    // MARK: - Room Options

    let rooms = [
        "Bedroom",
        "Living Room",
        "Kitchen",
        "Balcony",
        "Bathroom"
    ]

    // MARK: - Light Options

    let lightOptions = [
        "Full Sun",
        "Partial Sun",
        "Low Light"
    ]

    // MARK: - Watering Days Options

    let wateringOptions = [
        "Every day",
        "Every 2 days",
        "Every 3 days",
        "Once a week",
        "Every 10 days",
        "Every 2 weeks"
    ]

    // MARK: - Water Amount Options

    let waterAmounts = [
        "20–50 ml",
        "50–100 ml",
        "100–200 ml",
        "200–300 ml"
    ]

    // MARK: - Editing State

    let isEditing: Bool

    // MARK: - Initializer

    init(plant: PlantReminder? = nil) {

        isEditing = plant != nil

        plantName = plant?.name ?? ""
        room = plant?.room ?? "Bedroom"
        light = plant?.light ?? "Full Sun"
        wateringDays = plant?.wateringDays ?? "Every day"
        waterAmount = plant?.waterAmount ?? "20–50 ml"
    }

    // MARK: - Validation

    var canSave: Bool {
        !plantName.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty
    }

    // MARK: - Create Reminder

    func makeReminder() -> PlantReminder? {

        let trimmedName = plantName.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !trimmedName.isEmpty else {
            return nil
        }

        return PlantReminder(
            name: trimmedName,
            room: room,
            light: light,
            wateringDays: wateringDays,
            waterAmount: waterAmount
        )
    }
}
