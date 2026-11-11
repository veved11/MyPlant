
import Foundation
import UserNotifications

final class PlantNotificationService {

    static let shared = PlantNotificationService()

    private let notificationCenter = UNUserNotificationCenter.current()

    private init() {}

    // MARK: - Request Permission

    func requestPermission() async -> Bool {
        do {
            return try await notificationCenter.requestAuthorization(
                options: [.alert, .sound, .badge]
            )
        } catch {
            print("Notification permission error: \(error)")
            return false
        }
    }

    // MARK: - Watering Intervals

    private func wateringInterval(for wateringDays: String) -> TimeInterval {

        let oneDay: TimeInterval = 24 * 60 * 60

        switch wateringDays {
        case "Every day":
            return oneDay

        case "Every 2 days":
            return 2 * oneDay

        case "Every 3 days":
            return 3 * oneDay

        case "Once a week":
            return 7 * oneDay

        case "Every 10 days":
            return 10 * oneDay

        case "Every 2 weeks":
            return 14 * oneDay

        default:
            return oneDay
        }
    }

    // MARK: - Schedule Reminder

    func scheduleReminder(
        for plant: PlantReminder,
        identifier: UUID? = nil
    ) async {

        let permissionGranted = await requestPermission()

        guard permissionGranted else {
            print("Notification permission not granted")
            return
        }

        let content = UNMutableNotificationContent()

        content.title = "MyPlants 🌱"
        content.body = "Hey! Let's water your \(plant.name) 💧"
        content.sound = .default

        let interval = wateringInterval(for: plant.wateringDays)

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: interval,
            repeats: true
        )

        let notificationID = (identifier ?? plant.id).uuidString

        let request = UNNotificationRequest(
            identifier: notificationID,
            content: content,
            trigger: trigger
        )

        do {
            notificationCenter.removePendingNotificationRequests(
                withIdentifiers: [notificationID]
            )

            try await notificationCenter.add(request)

            print("Reminder scheduled for \(plant.name)")
        } catch {
            print("Could not schedule notification: \(error)")
        }
    }

    // MARK: - Cancel Reminder

    func cancelReminder(for plant: PlantReminder) {

        notificationCenter.removePendingNotificationRequests(
            withIdentifiers: [plant.id.uuidString]
        )

        print("Reminder cancelled for \(plant.name)")
    }
}
