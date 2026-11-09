import SwiftUI

// الشاشة الرئيسية عندما لا توجد تذكيرات نباتات.
struct PlantListView: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // عنوان الشاشة والخط الفاصل أسفله.
                HStack {
                    Text("My Plants 🌱")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.white)

                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.top, 38)
                .padding(.bottom, 18)

                Rectangle()
                    .fill(Color.white.opacity(0.18))
                    .frame(height: 1)

                // تظهر الرسالة في منتصف الشاشة عند عدم وجود نباتات.
                Spacer()

                Text("No reminders set yet..")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.gray)

                Spacer()
            }

            // زر إضافة تذكير، مثبت أسفل الشاشة من الجهة اليمنى.
            Button {
                // سنضيف فتح نموذج التذكير في خطوة لاحقة.
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(width: 48, height: 48)
                    .background(Color(red: 0.12, green: 0.48, blue: 0.39))
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(Color.white.opacity(0.25), lineWidth: 1)
                    }
            }
            .padding(.trailing, 24)
            .padding(.bottom, 38)
        }
        .preferredColorScheme(.dark)
    }
}
#Preview {
    PlantListView()
        .environment(\.locale, Locale(identifier: "ar"))
        .environment(\.layoutDirection, .rightToLeft)
}
