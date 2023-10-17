import SwiftUI
import Combine

class AppViewModel: ObservableObject {
        @Published var isLoggedIn = false
        @Published var selectedTab: CustomTabBar.Tab = .home
        @Published var isAppleSignInInProgress = false

    }

struct MainView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        ZStack {
            switch viewModel.selectedTab {
            case .home:
                HomeView()
            case .feed:
                FeedView()
            case .search:
                SearchView()
            case .archive:
                ArchiveView(isLoggedIn: $viewModel.isLoggedIn)
            }
            VStack{
                Spacer()
                CustomTabBar(selectedTab: $viewModel.selectedTab)
            }
        }
    }
}
