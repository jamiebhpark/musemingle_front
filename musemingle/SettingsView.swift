import SwiftUI

struct SettingsView: View {
    @Binding var isLoggedIn: Bool
    @State private var showShareSheet = false 
    
    var body: some View {
        List {
            NavigationLink(destination: AccountView(isLoggedIn: $isLoggedIn)) {
                HStack {
                    Text("Account")
                    Spacer()
                }
            }
            NavigationLink(destination: NotificationView()) {
                HStack {
                    Text("Notification")
                    Spacer()
                }
            }
            Button(action: {
                showShareSheet = true
            }) {
                // 여기서는 NavigationLink 없이 HStack만 사용되었습니다.
                HStack {
                    Text("Introduce to a friend")
                    Spacer()
                }
            }
            .sheet(isPresented: $showShareSheet) {
                ShareSheet(activityItems: ["Hey, Do you join us?", URL(string: "https://3.34.187.225")!])
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Settings")
                    .font(.system(size: 20))
                    .foregroundColor(.primary)
            }
        }
    }
}
struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
