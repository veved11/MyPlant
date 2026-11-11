import Foundation

final class PlantStorageService {
    private let storageKey = "savedPlantReminders"
    private let userDefaults = UserDefaults.standard

    func loadPlants() -> [PlantReminder] {
        guard
            let data = userDefaults.data(forKey: storageKey),
            let plants = try? JSONDecoder().decode(
                [PlantReminder].self,
                from: data
            )
        else {
            return []
        }

        return plants
    }

    func savePlants(_ plants: [PlantReminder]) {
        guard let data = try? JSONEncoder().encode(plants) else {
            return
        }

        userDefaults.set(data, forKey: storageKey)
    }
}
