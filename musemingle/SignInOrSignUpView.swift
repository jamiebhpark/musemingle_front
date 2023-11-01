import SwiftUI

class SignInOrSignUpViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var selectedTab: CustomTabBar.Tab = .home
}

struct SignInOrSignUpView: View {
    @ObservedObject private var viewModel: AppViewModel
    private var loginStatusViewModel: LoginStatusViewModel
    
    init(viewModel: AppViewModel, loginStatus: LoginStatusViewModel) {
        self.viewModel = viewModel
        self.loginStatusViewModel = loginStatus
    }
    
    var body: some View {
        ZStack {
            // 배경 이미지 추가
            Image("bgimage")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Button(action: {
                    viewModel.isLoggedIn = true
                }) {
                    HStack {
                        Image("google_icon")
                            .resizable()
                            .frame(width: 18, height: 18)
                        Text("Continue with Google")
                    }
                    .padding(.vertical, 12)
                    .frame(maxWidth: 280)
                    .background(Color.white)
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    .shadow(color: .black.opacity(0.25), radius: 1, x: 0, y: 1)
                    .shadow(color: .black.opacity(0.08), radius: 0, x: 0, y: 0)
                }
                .padding(.bottom, 10)
                
                Button(action: {
                    viewModel.isLoggedIn = true
                }) {
                    HStack {
                        Image("facebook_icon")
                            .resizable()
                            .frame(width: 18, height: 18)
                        Text("Continue with Facebook")
                    }
                    .padding(.vertical, 12)
                    .frame(maxWidth: 280)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                }
                .padding(.bottom, 10)
                
                Button(action: {
                    viewModel.isLoggedIn = true
                }) {
                    HStack {
                        Image(systemName: "applelogo")
                            .resizable()
                            .frame(width: 18, height: 18)
                        Text("Continue with Apple")
                    }
                    .padding(.vertical, 12)
                    .frame(maxWidth: 280)
                    .background(Color.black)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                }
                .padding(.bottom, 50)
            }
            .padding([.leading, .trailing], 16)
            .navigationBarHidden(true)
            .overlay(
                NavigationLink(destination: MainView().environmentObject(viewModel), isActive: $viewModel.isLoggedIn) {
                    EmptyView()
                }
                    .hidden()
            )
        }
    }
}
