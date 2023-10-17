import SwiftUI

struct WelcomeView: View {
    private var viewModel: AppViewModel
    @StateObject private var loginStatusViewModel: LoginStatusViewModel
    @StateObject private var appleSignInManager: AppleSignInManager

    init(viewModel: AppViewModel, loginStatus: LoginStatusViewModel) {
        self.viewModel = viewModel
        self._loginStatusViewModel = StateObject(wrappedValue: loginStatus)
        self._appleSignInManager = StateObject(wrappedValue: AppleSignInManager(loginStatusViewModel: loginStatus))
    }
    var body: some View {


        NavigationView {
            ZStack {
                Image("")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Spacer()

                    NavigationLink(destination: SignInOrSignUpView(viewModel: viewModel, loginStatus: loginStatusViewModel)) {

                        Text("Create an account")
                            .padding(.vertical, 12)
                            .frame(maxWidth: 300)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding([.leading, .trailing], 16)

                    NavigationLink(destination: SignInOrSignUpView(viewModel: viewModel, loginStatus: loginStatusViewModel)){ // Fixed here
                        Text("I already have an account")
                            .padding(.vertical, 12)
                            .frame(maxWidth: 300)
                            .foregroundColor(.blue)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                    }
                    .padding([.leading, .trailing], 16)
                }
            }
        }
    }
}
