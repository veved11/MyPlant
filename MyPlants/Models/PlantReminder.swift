import Foundation

// يخزن بيانات نبتة واحدة وتذكير العناية بها.
struct PlantReminder: Identifiable {
    // معرّف فريد يساعد SwiftUI على تمييز كل نبتة في القائمة.
    let id = UUID()

    // اسم النبتة ومكانها واحتياجاتها.
    var name: String
    var room: String
    var light: String
    var waterAmount: String

    // يوضح هل اكتملت العناية بهذه النبتة اليوم.
    var isDoneToday: Bool = false
}
