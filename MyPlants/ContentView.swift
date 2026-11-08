import SwiftUI

// الشاشة الرئيسية للتطبيق، وتعرض شريط تقدم تجريبيًا.
struct ContentView: View {
    var body: some View {
        VStack {
            ProgressBarView(
                completedCount: 3,
                totalCount: 4
            )
        }
        .padding()
        .background(.black)
        .preferredColorScheme(.dark)
    }
}
