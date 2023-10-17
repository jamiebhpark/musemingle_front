import SwiftUI

struct SearchView: View {
    
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search", text: $searchText)
                    .padding(.leading, 5)
            }
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 15)
            .padding(.top, 15)
            
            Spacer()
            
            // Title and Description
            VStack(alignment: .center, spacing: 5) {
                Text("Search MuseMingle")
                    .font(.headline)
                Text("Find works, artists, galleries, and portfolios.")
                    .font(.subheadline)
            }
            
            Spacer()
        }
        .background(Color.white)
        .navigationBarTitle("SEARCH", displayMode: .inline)
    }
}
