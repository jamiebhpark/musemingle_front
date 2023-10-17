import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Tab

    enum Tab: String, CaseIterable {
        case home, feed, search, archive
    }

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Button(action: {
                    selectedTab = tab // 선택한 탭 업데이트
                }) {
                    VStack {
                        Image(systemName: iconName(for: tab))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(selectedTab == tab ? .blue : .gray)
                        Text(tab.rawValue.capitalized) 
                            .font(.caption)
                            .foregroundColor(selectedTab == tab ? .blue : .gray)
                    }
                    .padding(.horizontal)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 10)
        .background(Color.white)
        .shadow(color: .gray.opacity(0.3), radius: 10)
    }

    // 각 탭에 해당하는 아이콘 이름
    private func iconName(for tab: Tab) -> String {
        switch tab {
        case .home:
            return "house.fill"
        case .feed:
            return "list.bullet"
        case .search:
            return "magnifyingglass"
        case .archive:
            return "archivebox.fill"
        }
    }
}
