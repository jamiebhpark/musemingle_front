import SwiftUI

struct PortfolioView: View {
    var userID: String = "JAMIEPARK90"
    
    // Sample portfolio pieces for demonstration
    var portfolioItems: [String] = ["sampleImage1", "sampleImage102", "sampleImage103", "sampleImage104","sampleImage105"]


    // We're using the same grid structure as in MyCollectionView
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 15), count: 2)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("My Portfolio")
                .font(.title3)
                .bold()
            
            Text(userID)
                .font(.subheadline)
                .opacity(0.7)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(portfolioItems, id: \.self) { itemImage in
                        NavigationLink(destination: DescriptionView(artwork: ArtworkDetail(imageName: itemImage, title: "Portfolio Title", subtitle: "Portfolio Subtitle", artistName: "Artist Name", year: "2023", method: "Art Method", description: "Detailed description of the portfolio item."), otherWorks: [])) {
                            Image(itemImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: (UIScreen.main.bounds.width - 60) / 2, height: (UIScreen.main.bounds.width - 60) / 2)
                                .clipped()
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
        }
        .padding([.leading, .trailing])
    }
}

struct PortfolioDetail {
    var imageName: String
    var title: String
    var subtitle: String
    var description: String
}

struct PortfolioDetailView: View {
    var item: PortfolioDetail
    
    var body: some View {
        VStack {
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width - 30)
                .cornerRadius(10)
                .padding(.top)
            
            Text(item.title)
                .font(.title2)
                .bold()
                .padding(.top)
            
            Text(item.subtitle)
                .font(.title3)
                .opacity(0.7)
                .padding(.bottom)
            
            Text(item.description)
                .font(.body)
                .multilineTextAlignment(.leading)
                .padding()
            
            Spacer()
        }
    }
}

