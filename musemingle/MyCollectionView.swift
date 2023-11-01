import SwiftUI

struct MyCollectionView: View {
    var userID: String = "JAMIEPARK90"
    
    var bookmarkedImages: [String] = ["sampleImage1", "sampleImage2", "sampleImage3", "sampleImage41","sampleImage42","sampleImage14","sampleImage4","sampleImage21","sampleImage43",]

    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 15), count: 2)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("My Collection")
                .font(.title3)
                .bold()
            
            Text(userID)
                .font(.subheadline)
                .opacity(0.7)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(bookmarkedImages, id: \.self) { imageName in
                        NavigationLink(destination: DescriptionView(artwork: ArtworkDetail(imageName: imageName, title: "Artwork Title", subtitle: "Artwork Subtitle", artistName: "Artist Name", year: "2023", method: "Art Method", description: "Artwork Description"), otherWorks: [])) { // 추가적인 작품 정보를 기입해야 합니다.
                            Image(imageName)
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
