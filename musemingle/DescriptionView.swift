import SwiftUI

struct DescriptionView: View {
    @State private var isBookmarked = false
    @State private var showProfile = false
    
    var artwork: ArtworkDetail
    var otherWorks: [Artwork]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Image(artwork.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                HStack{
                    Text(artwork.title)
                        .font(.title)
                        .padding(.top, 4)
                    
                    Spacer()
                    
                    VStack {
                        Image(systemName: "person.circle")
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                            .onTapGesture {
                                showProfile = true
                            }
                    }
                    if showProfile {
                        NavigationLink("", destination:
                                        ProfileView(artistProfile: ArtistProfile(name: artwork.artistName, isVerified: true, field: "Photographer", majorWork: Artwork(imageName: artwork.imageName, title: artwork.title, artistName: artwork.artistName), otherWorks: otherWorks, userID: "JAMIEPARK90")), isActive: $showProfile)
                        .opacity(0)
                    }
                    
                }
                if let subtitle = artwork.subtitle {
                    Text(subtitle)
                        .font(.title2)
                        .opacity(0.7)
                }
                
                Text("\(artwork.artistName), \(artwork.year)")
                    .font(.subheadline)
                
                Text(artwork.method)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 1)
                
                Text(artwork.description)
                    .font(.body)
            }
            .padding()
        }
        
        .navigationBarItems(trailing: bookmarkButton)
    }
    var bookmarkButton: some View {
        Button(action: {
            isBookmarked.toggle() // 북마크 상태 토글
        }) {
            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                .foregroundColor(isBookmarked ? .yellow : .primary)
        }
    }
}
    struct ArtworkDetail {
        var imageName: String
        var title: String
        var subtitle: String? 
        var artistName: String
        var year: String
        var method: String
        var description: String
    }

