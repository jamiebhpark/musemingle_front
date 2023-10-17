import SwiftUI

struct ArchiveView: View {
    
    @Binding var isLoggedIn: Bool
    @State private var showLogoutAlert: Bool = false
    
    var body: some View {
        List {
            NavigationLink(destination: MyCollectionView()) {
                HStack {
                    Text("My Collection")
                    Spacer()
                }
            }
            NavigationLink(destination: PortfolioView()) {
                HStack {
                    Text("My Portfolio")
                    Spacer()
                }
            }
            NavigationLink(destination: FollowingView()) {
                HStack {
                    Text("My Following")
                    Spacer()
                }
            }
            NavigationLink(destination: SettingsView(isLoggedIn: $isLoggedIn)) {
                HStack {
                    Text("My Settings")
                    Spacer()
                }
            }
            Section {
                Button(action: {
                    showLogoutAlert = true
                }){
                    HStack {
                        Spacer()
                        Text("Sign Out")
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("ARCHIVE", displayMode: .inline)

            .alert(isPresented: $showLogoutAlert) {
                Alert(title: Text("Are you sure you want to Sign Out?"),
                      primaryButton: .default(Text("Sign Out"), action: {
                    let appleSignInManager = AppleSignInManager(loginStatusViewModel: LoginStatusViewModel()) // AppleSignInManager의 초기화 방법을 따라 수정할 수 있습니다.
                    appleSignInManager.logout()
                    isLoggedIn = false
                }),
                      secondaryButton: .cancel())
            }
        }
    }
}
