import Foundation

struct PlantReminder: Identifiable, Codable {
    let id: UUID
    var name: String
    var room: String
    var light: String
    var wateringDays: String
    var waterAmount: String
    var isDoneToday: Bool

    init(
        id: UUID = UUID(),
        name: String,
        room: String,
        light: String,
        wateringDays: String = "Every day",
        waterAmount: String,
        isDoneToday: Bool = false
    ) {
        self.id = id
        self.name = name
        self.room = room
        self.light = light
        self.wateringDays = wateringDays
        self.waterAmount = waterAmount
        self.isDoneToday = isDoneToday
    }
}
