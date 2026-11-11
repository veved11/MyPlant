import Combine
import Foundation

final class PlantListViewModel: ObservableObject {
    @Published private(set) var plants: [PlantReminder]

    private let storageService = PlantStorageService()

    init() {
        plants = storageService.loadPlants()
    }

    var completedCount: Int {
        plants.filter(\.isDoneToday).count
    }

    func toggleDone(for plant: PlantReminder) {
        guard let index = plants.firstIndex(where: { $0.id == plant.id }) else {
            return
        }

        plants[index].isDoneToday.toggle()
        savePlants()
    }

    func add(_ plant: PlantReminder) {
        plants.append(plant)
        savePlants()

        Task {
            await PlantNotificationService.shared.scheduleReminder(for: plant)
        }
    }

    func update(_ plant: PlantReminder, with updatedPlant: PlantReminder) {
        guard let index = plants.firstIndex(where: { $0.id == plant.id }) else {
            return
        }

        plants[index].name = updatedPlant.name
        plants[index].room = updatedPlant.room
        plants[index].light = updatedPlant.light
        plants[index].wateringDays = updatedPlant.wateringDays
        plants[index].waterAmount = updatedPlant.waterAmount

        let savedPlant = plants[index]
        savePlants()

        Task {
            PlantNotificationService.shared.cancelReminder(for: plant)

            await PlantNotificationService.shared.scheduleReminder(
                for: savedPlant,
                identifier: plant.id
            )
        }
    }

    func delete(_ plant: PlantReminder) {
        plants.removeAll { $0.id == plant.id }
        savePlants()
        PlantNotificationService.shared.cancelReminder(for: plant)
    }

    private func savePlants() {
        storageService.savePlants(plants)
    }
}
