import SwiftUI

// أنماط الخطوط المستخدمة في شاشات التطبيق ومكوّناته.
enum AppTypography {
    // عنوان الشاشة الرئيسية.
    static let screenTitle = Font.system(size: 28, weight: .bold)

    // اسم النبتة في صف القائمة.
    static let plantName = Font.system(size: 28, weight: .regular)

    // موقع النبتة بجانب أيقونة الغرفة.
    static let plantLocation = Font.system(size: 15, weight: .regular)

    // النص داخل شارات الإضاءة والماء.
    static let careDetail = Font.system(size: 14, weight: .medium)

    // رسالة الحالة الفارغة.
    static let emptyState = Font.system(size: 16, weight: .semibold)

    // رسالة التقدم اليومي فوق شريط الإنجاز.
    static let progressMessage = Font.system(size: 18, weight: .regular)
}
